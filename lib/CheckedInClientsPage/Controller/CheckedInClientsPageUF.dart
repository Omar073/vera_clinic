import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:path_provider/path_provider.dart';

import '../../Core/Controller/Providers/ClinicProvider.dart';
import '../../Core/Model/Classes/Client.dart';
import '../../Core/View/PopUps/MySnackBar.dart';
import '../../Core/Services/DebugLoggerService.dart';

class CheckedInClientsLogic with WidgetsBindingObserver {
  CheckedInClientsLogic({
    required this.context,
    required this.onRefreshRequested,
  });

  final BuildContext context;
  final VoidCallback onRefreshRequested;

  Future<void>? fetchDataFuture;
  bool isLoading = false;
  Timer? _pollingTimer;
  bool _isFetching = false;
  static Set<String> _lastArrivedClientIds = {};
  final AudioPlayer _audioPlayer = AudioPlayer();
  String? _cachedAudioPath;
  bool _audioInitLogged = false;
  bool _audioStreamsBound = false;

  void init() {
    WidgetsBinding.instance.addObserver(this);
    fetchDataFuture = fetchData();
    _startPolling();
    _ensureAudioFileExists();
    
    // Initialize _lastArrivedClientIds with current checked-in clients on first init
    final clinicProvider = context.read<ClinicProvider>();
    if (_lastArrivedClientIds.isEmpty && clinicProvider.checkedInClients.isNotEmpty) {
      final clinic = clinicProvider.clinic;
      if (clinic != null) {
        _lastArrivedClientIds = clinicProvider.checkedInClients
            .map((c) => c.mClientId)
            .whereType<String>()
            .where((id) => clinic.hasClientArrived(id))
            .toSet();
        mDebug('Initialized arrival tracking with ${_lastArrivedClientIds.length} already-arrived clients');
      }
    }
  }

  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _stopPolling();
    _audioPlayer.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _startPolling();
      onRefreshRequested();
    } else {
      _stopPolling();
    }
  }

  void startManualRefresh() {
    fetchDataFuture = fetchData();
    onRefreshRequested();
  }

  /// Test method to manually trigger the arrival sound
  void testArrivalSound() {
    mDebug('Manual test triggered');
    _playArrivalSound();
  }

  void _startPolling() {
    _pollingTimer?.cancel();
    _pollingTimer = Timer.periodic(const Duration(seconds: 5), (_) {
      _pollForUpdates();
    });
  }

  void _stopPolling() {
    _pollingTimer?.cancel();
  }

  Future<void> _pollForUpdates() async {
    if (_isFetching) return;
    try {
      _isFetching = true;
      await context.read<ClinicProvider>().getCheckedInClients(context);
    } catch (e) {
      mDebug('Error polling for checked-in clients: $e');
      if (context.mounted) {
        showMySnackBar(
            context, 'خطأ في التحديث التلقائي: ${e.toString()}', Colors.orange);
      }
    } finally {
      _isFetching = false;
    }
  }

  Future<void> fetchData() async {
    if (_isFetching) {
      mDebug('Skipping fetch - already in progress');
      return;
    }
    try {
      _isFetching = true;
      isLoading = true;
      onRefreshRequested();
      await context.read<ClinicProvider>().getCheckedInClients(context);
    } catch (e) {
      mDebug('Error getting checked-in clients: $e');
      if (context.mounted) {
        showMySnackBar(
            context, 'فشل تحميل القائمة: ${e.toString()}', Colors.red);
      }
    } finally {
      _isFetching = false;
      isLoading = false;
      onRefreshRequested();
    }
  }

  void handleArrivalNotifications(List<Client?> arrivedClients) {
    final currentIds = arrivedClients
        .map((client) => client?.mClientId)
        .whereType<String>()
        .toSet();

    final newlyArrived = currentIds.difference(_lastArrivedClientIds);

    if (newlyArrived.isNotEmpty) {
      mDebug('New client(s) arrived: ${newlyArrived.length}');
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _playArrivalSound();
      });
    }

    _lastArrivedClientIds = currentIds;
  }

  static const String _driveDownloadUrl =
      'https://drive.google.com/uc?export=download&id=1XRWxTvM5x5KWtaxnb4mnbIHn1PRkEL7W';

  /// Download the alert sound from Google Drive if not already cached locally.
  Future<void> _ensureAudioFileExists() async {
    if (kIsWeb) return;
    if (defaultTargetPlatform != TargetPlatform.windows) return;

    try {
      if (!_audioInitLogged) {
        _audioInitLogged = true;
        mDebug('Audio debug | platform: $defaultTargetPlatform | kIsWeb=$kIsWeb | player=${_audioPlayer.hashCode}');
      }
      if (!_audioStreamsBound) {
        _audioStreamsBound = true;
        _audioPlayer.onPlayerStateChanged.listen((state) {
          mDebug('Audio debug | onPlayerStateChanged -> $state');
        });
        _audioPlayer.onPlayerComplete.listen((event) {
          mDebug('Audio debug | onPlayerComplete fired');
        });
      }
      mDebug('Audio debug | ensuring audio cache...');
      // Get the app's local documents directory.
      final Directory appDir = await getApplicationDocumentsDirectory();
      final String localPath = '${appDir.path}/alert_sound.mp3';
      final File localFile = File(localPath);

      mDebug('Checking for audio file at: $localPath');

      // If file already exists locally, cache the path and return.
      if (await localFile.exists()) {
        final fileSize = await localFile.length();
        _cachedAudioPath = localPath;
        mDebug('Alert sound already cached ($fileSize bytes)');
        return;
      }

      // Download from Google Drive.
      mDebug('Audio debug | starting download from Drive...');
      await _downloadFileFromDrive(localFile);

      final fileSize = await localFile.length();
      _cachedAudioPath = localPath;
      mDebug('Audio debug | download completed ($fileSize bytes) -> $_cachedAudioPath');
    } catch (e, stack) {
      mDebug('Audio debug | ERROR downloading alert sound: $e');
      mDebug('Audio debug | stack: $stack');
      // If download fails, we'll fall back to system sound.
    }
  }

  Future<void> _playArrivalSound() async {
    mDebug('Audio debug | _playArrivalSound called | cachedPath=$_cachedAudioPath');
    
    if (kIsWeb) {
      mDebug('Platform is web, skipping audio');
      return;
    }
    
    if (defaultTargetPlatform == TargetPlatform.windows) {
      // If we have a cached audio file, play it.
      if (_cachedAudioPath != null && File(_cachedAudioPath!).existsSync()) {
        try {
          mDebug('Playing custom audio from: $_cachedAudioPath');
          await _audioPlayer.stop();
          mDebug('Audio debug | AudioPlayer state before play: ${_audioPlayer.state}');
          await _audioPlayer.play(
            DeviceFileSource(_cachedAudioPath!),
            volume: 1.0,
          );
          mDebug('Audio debug | play() future completed, state=${_audioPlayer.state}');
          Future.delayed(const Duration(milliseconds: 1500), () {
            _audioPlayer.stop();
            mDebug('Audio debug | forced stop after delay, state=${_audioPlayer.state}');
          });
          return;
        } catch (e, stack) {
          mDebug('Audio debug | ERROR playing custom audio: $e');
          mDebug('Audio debug | stack: $stack');
        }
      } else {
        mDebug('Audio debug | No cached audio file available, path: $_cachedAudioPath');
        // If no cached file yet, try to ensure it exists (async, won't block).
        _ensureAudioFileExists();
      }
    }
    
    // Fallback to system sound.
    try {
      mDebug('Audio debug | Playing system sound fallback');
      await SystemSound.play(SystemSoundType.alert);
      await SystemSound.play(SystemSoundType.alert);
      mDebug('Audio debug | System sound played');
    } catch (e, stack) {
      mDebug('Audio debug | ERROR playing system sound: $e');
      mDebug('Audio debug | stack: $stack');
    }
  }

  Future<void> _downloadFileFromDrive(File target) async {
    final httpClient = HttpClient();
    try {
      mDebug('Audio debug | HTTP GET -> $_driveDownloadUrl');
      final request = await httpClient.getUrl(Uri.parse(_driveDownloadUrl));
      final response = await request.close();

      if (response.statusCode != 200) {
        throw HttpException(
          'Failed to download alert sound: HTTP ${response.statusCode}',
          uri: Uri.parse(_driveDownloadUrl),
        );
      }

      final bytes = await consolidateHttpClientResponseBytes(response);
      mDebug('Audio debug | HTTP response ${response.statusCode}, bytes=${bytes.length}');
      await target.writeAsBytes(bytes, flush: true);
      mDebug('Audio debug | File written to ${target.path}');
    } finally {
      mDebug('Audio debug | closing HttpClient');
      httpClient.close();
    }
  }
}

