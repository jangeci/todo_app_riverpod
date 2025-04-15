import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/common/utils/app_colors.dart';

class Text24Normal extends StatelessWidget {
  final String text;
  final Color color;
  final FontWeight weight;

  const Text24Normal(
    this.text, {
    super.key,
    this.color = AppColors.primaryText,
    this.weight = FontWeight.w400,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 24.sp,
        color: color,
        fontWeight: weight,
      ),
      textAlign: TextAlign.center,
    );
  }
}

class Text16Normal extends StatelessWidget {
  final String text;
  final Color color;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;

  const Text16Normal(
    this.text, {
    super.key,
    this.fontWeight,
    this.color = AppColors.primarySecondaryElementText,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 16.sp,
        color: color,
        fontWeight: fontWeight,
      ),
      textAlign: textAlign,
    );
  }
}

class Text14Normal extends StatelessWidget {
  final String text;
  final Color color;
  final FontWeight fontWeight;
  final TextAlign? textAlign;

  const Text14Normal(
    this.text, {
    super.key,
    this.color = AppColors.primaryThirdElementText,
    this.fontWeight = FontWeight.normal,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 14.sp,
        color: color,
        fontWeight: fontWeight,
      ),
      textAlign: textAlign,
    );
  }
}

class Text13Normal extends StatelessWidget {
  final String text;
  final Color color;
  final FontWeight fontWeight;
  final TextAlign? textAlign;

  const Text13Normal(
    this.text, {
    super.key,
    this.color = AppColors.primaryText,
    this.fontWeight = FontWeight.normal,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 13.sp,
        color: color,
        fontWeight: fontWeight,
      ),
      textAlign: textAlign,
    );
  }
}

class Text11Normal extends StatelessWidget {
  final String text;
  final Color color;
  final FontWeight weight;
  final TextAlign? textAlign;

  const Text11Normal(
    this.text, {
    super.key,
    this.weight = FontWeight.normal,
    this.color = AppColors.primarySecondaryElementText,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 11.sp,
        color: color,
        fontWeight: weight,
      ),
      textAlign: textAlign,
    );
  }
}

class Text10Normal extends StatelessWidget {
  final String text;
  final Color color;
  final FontWeight weight;

  const Text10Normal(
    this.text, {
    super.key,
    this.weight = FontWeight.normal,
    this.color = AppColors.primarySecondaryElementText,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 10.sp,
        color: color,
        fontWeight: weight,
      ),
      textAlign: TextAlign.center,
    );
  }
}
