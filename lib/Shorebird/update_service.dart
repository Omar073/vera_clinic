import 'package:flutter/material.dart';
import 'package:shorebird_code_push/shorebird_code_push.dart';
import 'package:window_manager/window_manager.dart';
import '../../Core/View/PopUps/MyAlertDialogue.dart';

/// Encapsulates all Shorebird–update logic & dialogs.
class UpdateService {
  final ShorebirdUpdater _updater = ShorebirdUpdater();

  /// Call this as soon as you have a [BuildContext], e.g. in
  /// your app’s root widget initState.
  Future<void> checkForUpdates(BuildContext context) async {
    try {
      final status = await _updater.checkForUpdate();
      if (status == UpdateStatus.outdated) {
        // notify user that we're downloading
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

        await _updater.update();

        // when done, prompt for restart
        await showAlertDialogue(
          context: context,
          title: 'تم التنزيل',
          content: 'تم تنزيل التحديث. هل تريد إعادة تشغيل التطبيق الآن؟',
          buttonText: 'إغلاق البرنامج',
          returnText: 'لاحقًا',
          onPressed: () async {
            // close window (on Windows will exit)
            await windowManager.close();
          },
        );
      }
    } on UpdateException catch (e) {
      // show error
      await showAlertDialogue(
        context: context,
        title: 'خطأ أثناء التحديث',
        content:
            'حدث خطأ أثناء التحديث برجاء التحقق من اتصال الانترنت. حاول مرة أخرى لاحقًا.',
        buttonText: '',
        returnText: 'إغلاق',
        onPressed: () async => Navigator.of(context).pop(),
      );
      debugPrint('Update failed: $e');
    }
  }

  /// Reads current patch (you can call once at startup to log it).
  Future<void> initPatch() async {
    final patch = await _updater.readCurrentPatch();
    debugPrint('Shorebird current patch: ${patch?.number}');
  }
}
