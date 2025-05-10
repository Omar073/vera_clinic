import 'package:flutter/material.dart';
import 'package:shorebird_code_push/shorebird_code_push.dart';
import 'package:window_manager/window_manager.dart';
import '../../Core/View/PopUps/MyAlertDialogue.dart';

class UpdateService {
  final ShorebirdUpdater _updater = ShorebirdUpdater();

  Future<void> checkForUpdates(BuildContext context) async {
    try {
      final status = await _updater.checkForUpdate();
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

        await _updater.update();

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
      // await showAlertDialogue(
      //   context: context,
      //   title: '',
      //   content: 'برجاء إعادة تشغيل البرنامج',
      //   buttonText: 'إغلاق البرنامج',
      //   returnText: 'لاحقًا',
      //   onPressed: () async {
      //     await windowManager.close();
      //   },
      // );
      debugPrint('Update may have failed: $e');
    }
  }

  Future<void> initPatch() async {
    final patch = await _updater.readCurrentPatch();
    debugPrint('Shorebird current patch: ${patch?.number}');
  }
}
