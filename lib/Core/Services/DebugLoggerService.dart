import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

class DebugLogEntry {
  final DateTime timestamp;
  final String message;
  final String source;

  DebugLogEntry({
    required this.timestamp,
    required this.message,
    required this.source,
  });

  String get formattedTime {
    return '${timestamp.hour.toString().padLeft(2, '0')}:'
        '${timestamp.minute.toString().padLeft(2, '0')}:'
        '${timestamp.second.toString().padLeft(2, '0')}';
  }

  @override
  String toString() {
    return '[$formattedTime] [$source] $message';
  }
}

class DebugLoggerService {
  static final DebugLoggerService _instance = DebugLoggerService._internal();
  static DebugLoggerService get instance => _instance;

  final List<DebugLogEntry> _logs = [];
  final int _maxLogs = 500;
  Timer? _archiveTimer;
  File? _archiveFile;
  bool _initialized = false;

  DebugLoggerService._internal();

  /// Initialize the debug logger service
  Future<void> initialize() async {
    if (_initialized) return;
    _initialized = true;

    if (!kDebugMode) {
      // Only setup archiving in production mode
      await _setupArchiveFile();
      _startArchiveTimer();
    }
  }

  /// Setup the archive file (delete old one and create new)
  Future<void> _setupArchiveFile() async {
    try {
      if (kIsWeb) return;
      
      final directory = await getApplicationDocumentsDirectory();
      _archiveFile = File('${directory.path}/debug_logs_archive.txt');

      // Delete existing archive file to start fresh
      if (await _archiveFile!.exists()) {
        await _archiveFile!.delete();
      }

      // Create new archive file with header
      final header = '=== Debug Logs Archive ===\n'
          'App Start: ${DateTime.now()}\n'
          '${'-' * 50}\n\n';
      await _archiveFile!.writeAsString(header);
    } catch (e) {
      debugPrint('Error setting up archive file: $e');
    }
  }

  /// Start the timer to archive logs every 30 minutes
  void _startArchiveTimer() {
    _archiveTimer?.cancel();
    _archiveTimer = Timer.periodic(const Duration(minutes: 30), (_) {
      _archiveLogs();
    });
  }

  /// Archive current logs to file
  Future<void> _archiveLogs() async {
    if (_archiveFile == null || _logs.isEmpty) return;

    try {
      final timestamp = DateTime.now();
      final header = '\n=== Archive Session: '
          '${timestamp.year}-${timestamp.month.toString().padLeft(2, '0')}-${timestamp.day.toString().padLeft(2, '0')} '
          '${timestamp.hour.toString().padLeft(2, '0')}:${timestamp.minute.toString().padLeft(2, '0')}:${timestamp.second.toString().padLeft(2, '0')} ===\n';

      final logContent = _logs.map((log) => log.toString()).join('\n');
      await _archiveFile!.writeAsString(
        '$header$logContent\n',
        mode: FileMode.append,
      );

      // Clear logs after archiving
      _logs.clear();
    } catch (e) {
      debugPrint('Error archiving logs: $e');
    }
  }

  /// Main debug method to replace debugPrint
  void mDebug(String message) {
    if (kDebugMode) {
      // In debug mode, just print to terminal
      debugPrint(message);
    } else {
      // In production mode, store in memory
      final source = _extractSourceInfo();
      final entry = DebugLogEntry(
        timestamp: DateTime.now(),
        message: message,
        source: source,
      );

      _logs.add(entry);

      // Remove oldest logs if exceeding max
      if (_logs.length > _maxLogs) {
        _logs.removeAt(0);
      }
    }
  }

  /// Extract source file and method from stack trace
  String _extractSourceInfo() {
    try {
      final stackTrace = StackTrace.current.toString();
      final lines = stackTrace.split('\n');

      // Skip the first few lines (this method and mDebug)
      for (int i = 2; i < lines.length && i < 5; i++) {
        final line = lines[i].trim();
        
        // Look for lines with file paths (containing .dart)
        if (line.contains('.dart')) {
          // Extract file name and line number
          final match = RegExp(r'([a-zA-Z_][a-zA-Z0-9_]*\.dart):(\d+)').firstMatch(line);
          if (match != null) {
            final fileName = match.group(1) ?? '';
            final lineNumber = match.group(2) ?? '';
            
            // Try to extract method name
            final methodMatch = RegExp(r'#\d+\s+([a-zA-Z_][a-zA-Z0-9_.<>]*)\s+\(').firstMatch(line);
            final methodName = methodMatch?.group(1)?.split('.').last ?? '';
            
            if (methodName.isNotEmpty) {
              return '$fileName.$methodName:$lineNumber';
            } else {
              return '$fileName:$lineNumber';
            }
          }
        }
      }
    } catch (e) {
      // If extraction fails, return a generic marker
      return 'Unknown';
    }
    return 'Unknown';
  }

  /// Get current logs
  List<DebugLogEntry> get logs => List.unmodifiable(_logs);

  /// Clear all logs
  void clearLogs() {
    _logs.clear();
  }

  /// Export logs to a string
  String exportLogs() {
    return _logs.map((log) => log.toString()).join('\n');
  }

  /// Export last N logs to a string
  String exportLastNLogs(int n) {
    final count = n > _logs.length ? _logs.length : n;
    final lastLogs = _logs.sublist(_logs.length - count);
    return lastLogs.map((log) => log.toString()).join('\n');
  }

  /// Get time until next archive (for UI display)
  Duration? getTimeUntilNextArchive() {
    // This is an approximation - actual implementation would track exact time
    return const Duration(minutes: 30);
  }

  /// Dispose resources
  void dispose() {
    _archiveTimer?.cancel();
  }
}

// Global shorthand function for easier logging
void mDebug(String message) {
  DebugLoggerService.instance.mDebug(message);
}

