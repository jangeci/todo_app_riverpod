import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:todo_app/common/utils/app_utils.dart';
import 'package:todo_app/common/widgets/popup_messages.dart';

class ShareService {
  static share(BuildContext context, {required String id}) async {
    final box = context.findRenderObject() as RenderBox?;

    ShareResult shareResult;

    shareResult = await Share.share(
      AppUtils.makeShareLink(id),
      subject: 'Share a todo',
      sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
    );

    if (shareResult.status == ShareResultStatus.dismissed) {
      return;
    }

    toastInfo('Share result: ${shareResult.status}'
        '${shareResult.status == ShareResultStatus.success ? '\nShared to: ${shareResult.raw}' : ''}');
  }
}
