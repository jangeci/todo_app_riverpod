import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/common/utils/app_colors.dart';
import 'package:todo_app/common/widgets/text_widgets.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final FontWeight? fontWeight;
  final List<Widget>? actions;

  const AppBarWidget({
    super.key,
    this.title = '',
    this.fontWeight = FontWeight.w600,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primarySecondaryBackground,
      title: Text16Normal(
        title,
        color: AppColors.primaryText,
        fontWeight: fontWeight,
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(10),
        child: Container(
          height: 1,
          color: Colors.grey.withAlpha(70),
        ),
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(60);
}
