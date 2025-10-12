import 'package:flutter/material.dart';
import 'package:shorebird_code_push/shorebird_code_push.dart';
import 'package:window_manager/window_manager.dart';
import '../../Core/View/PopUps/MyAlertDialogue.dart';

class UpdateService {
  final ShorebirdUpdater _updater = ShorebirdUpdater();

  Future<void> checkForUpdates(BuildContext context) async {
    try {
      final status = await _updater.checkForUpdate();
      debugPrint('Shorebird update status: $status');
      if (status == UpdateStatus.outdated) {
        await showAlertDialogue(
          context: context,
          title: 'تحديث متاح',
          content: 'هناك تحديث جديد. سيتم تنزيله في الخلفية تلقائيًا.',
          buttonText: '',
          returnText: 'تأكيد',
          onPressed: () async {
            Navigator.of(context).pop();
          },
        );

        // Give the navigator a moment to fully dismiss the previous dialog
        await Future.delayed(const Duration(milliseconds: 100));

        // Show a blocking progress dialog while downloading the update
        // and close it once the download finishes (or fails).
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (dialogContext) => PopScope(
            canPop: false,
            child: AlertDialog(
              backgroundColor: Colors.blue[50]!,
              title: const Text('جاري تنزيل التحديث'),
              content: Row(
                children: const [
                  SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(strokeWidth: 2.5),
                  ),
                  SizedBox(width: 12),
                  Expanded(child: Text('يرجى الانتظار حتى يكتمل التنزيل...')),
                ],
              ),
            ),
          ),
        );

        try {
          debugPrint('Shorebird update() starting...');
          await _updater.update();
          debugPrint('Shorebird update() completed');
        } finally {
          // Dismiss the progress dialog if it's still showing.
          try {
            Navigator.of(context, rootNavigator: true).pop();
          } catch (_) {}
        }

        // when done, prompt for restart
        await showAlertDialogue(
          context: context,
          title: 'تم التنزيل',
          content: 'تم تنزيل التحديث. هل تريد إعادة تشغيل البرنامج الآن؟',
          buttonText: 'إغلاق البرنامج',
          returnText: 'لاحقًا',
          onPressed: () async {
            await windowManager.close();
          },
        );
      }
    } on UpdateException catch (e) {
      // Ensure the progress dialog is dismissed if an error occurs.
      try {
        Navigator.of(context, rootNavigator: true).pop();
      } catch (_) {}

      // await showAlertDialogue(
      //   context: context,
      //   title: 'تعذر إكمال التحديث',
      //   content: 'حدث خطأ أثناء تنزيل التحديث. برجاء المحاولة لاحقًا.\n$e',
      //   buttonText: 'حسنًا',
      //   returnText: '',
      //   onPressed: () async {},
      // );
      // when done, prompt for restart
        await showAlertDialogue(
          context: context,
          title: 'تم التنزيل',
          content: 'تم تنزيل التحديث. هل تريد إعادة تشغيل البرنامج الآن؟',
          buttonText: 'إغلاق البرنامج',
          returnText: 'لاحقًا',
          onPressed: () async {
            await windowManager.close();
          },
        );
      debugPrint('Update may have failed: $e');
    }
  }

  Future<void> initPatch() async {
    final patch = await _updater.readCurrentPatch();
    debugPrint('Shorebird current patch: ${patch?.number}');
  }
}
