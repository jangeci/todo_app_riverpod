import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrimaryButton extends StatelessWidget {
  final bool isLoading;
  final Function() onTap;
  final String text;
  final Color? color;
  final Color? textColor;

  const PrimaryButton({
    super.key,
    required this.onTap,
    required this.text,
    this.isLoading = false,
    this.color,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.h,
      width: double.infinity,
      child: FilledButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color ?? Colors.blue.shade900,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: !isLoading
            ? () {
                onTap();
              }
            : null,
        child: isLoading
            ? Center(
                child: SizedBox(
                  width: 30.w,
                  height: 30.w,
                  child: CircularProgressIndicator(
                    strokeWidth: 6.w,
                    strokeCap: StrokeCap.round,
                  ),
                ),
              )
            : Text(
                text,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: textColor,
                ),
              ),
      ),
    );
  }
}
