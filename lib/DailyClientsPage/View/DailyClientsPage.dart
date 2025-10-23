import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vera_clinic/Core/Model/Classes/Client.dart';
import 'package:vera_clinic/Core/View/Reusable%20widgets/BackGround.dart';
import 'package:vera_clinic/Core/View/Reusable%20widgets/my_app_bar.dart';
import 'package:vera_clinic/DailyClientsPage/Controller/DailyClientsController.dart';
import 'package:vera_clinic/DailyClientsPage/View/DailyClientCard.dart';

import '../../Core/Controller/Providers/ClinicProvider.dart';

class DailyClientsPage extends StatefulWidget {
  const DailyClientsPage({super.key});

  @override
  State<DailyClientsPage> createState() => _DailyClientsPageState();
}

class _DailyClientsPageState extends State<DailyClientsPage> {
  late Future<List<Client?>> _dailyClientsFuture;
  final DailyClientsController _controller = DailyClientsController();
  int? _lastShownAttempt;
  VoidCallback? _clinicProviderListener;
  late ClinicProvider _clinicProvider;

  @override
  void initState() {
    super.initState();
    _clinicProvider = context.read<ClinicProvider>();
    _dailyClientsFuture = _controller.getDailyClients(context);
    _clinicProvider.syncDailyClientsWithCheckedIn();

    // Listen for retry status to inform the user via SnackBar
    _clinicProviderListener = () {
      final attempt = _clinicProvider.currentRetryAttempt;
      final max = _clinicProvider.maxRetryAttempts;
      if (attempt != null && attempt != _lastShownAttempt) {
        _lastShownAttempt = attempt;
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('فشل التحميل، إعادة المحاولة $attempt من ${max ?? '-'}...'),
              duration: const Duration(seconds: 2),
            ),
          );
        }
      }
    };
    _clinicProvider.addListener(_clinicProviderListener!);
  }

  void _refreshClients() {
    setState(() {
      _dailyClientsFuture = _controller.getDailyClients(context);
      _clinicProvider.syncDailyClientsWithCheckedIn();
    });
  }

  @override
  void dispose() {
    if (_clinicProviderListener != null) {
      _clinicProvider.removeListener(_clinicProviderListener!);
      _clinicProviderListener = null;
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: 'قائمة عملاء اليوم',
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _refreshClients,
          ),
        ],
      ),
      body: Background(
        child: FutureBuilder<List<Client?>>(
          future: _dailyClientsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              final clinicProvider = context.watch<ClinicProvider>();
              final attempt = clinicProvider.currentRetryAttempt;
              final max = clinicProvider.maxRetryAttempts;
              final lastError = clinicProvider.lastRetryErrorMessage;
              final msg = attempt != null && max != null
                  ? 'محاولة إعادة الاتصال $attempt من $max...'
                  : 'جاري تحميل بيانات العيادة...';
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(color: Colors.blue[800]),
                    const SizedBox(height: 10),
                    Text(
                      msg,
                      style: const TextStyle(fontSize: 14),
                    ),
                    if (lastError != null) ...[
                      const SizedBox(height: 6),
                      Text(
                        lastError,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ]
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.info_outline, color: Colors.orange, size: 28),
                    const SizedBox(height: 8),
                    Text(
                      snapshot.error.toString(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton.icon(
                      onPressed: _refreshClients,
                      icon: const Icon(Icons.refresh),
                      label: const Text('إعادة المحاولة'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                      ),
                    )
                  ],
                ),
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                child: Text(
                  'لا يوجد عملاء لليوم',
                  style: TextStyle(fontSize: 18),
                ),
              );
            } else {
              final clients = snapshot.data!;
              return ListView.builder(
                itemCount: clients.length,
                itemBuilder: (context, index) {
                  final client = clients[index];
                  return client != null
                      ? DailyClientCard(
                          client: client,
                          index: index,
                          onClientRemoved: _refreshClients,
                        )
                      : const SizedBox.shrink();
                },
              );
            }
          },
        ),
      ),
    );
  }
} 