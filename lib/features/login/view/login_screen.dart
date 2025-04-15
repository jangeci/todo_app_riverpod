import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/common/routes.dart';
import 'package:todo_app/common/widgets/app_bar_widget.dart';
import 'package:todo_app/common/widgets/app_textfield.dart';
import 'package:todo_app/common/widgets/primary_button.dart';
import 'package:todo_app/features/login/controller/log_in_controller.dart';
import 'package:todo_app/features/login/provider/log_in_notifier.dart';

class LogInScreen extends ConsumerStatefulWidget {
  const LogInScreen({super.key});

  @override
  ConsumerState<LogInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<LogInScreen> {
  final LogInController _controller = LogInController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) => _controller.init(ref),
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loginProvider = ref.watch(logInNotifierProvider);

    return Container(
      color: Colors.white,
      child: Scaffold(
        appBar: AppBarWidget(title: 'Login'),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 25.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 50.h),
              AppTextField(
                controller: _controller.emailController,
                label: 'Email',
                autoFocus: true,
                onChanged: (val) => ref.read(logInNotifierProvider.notifier).onEmailChange(val),
              ),
              SizedBox(height: 20.h),
              AppTextField(
                controller: _controller.passwordController,
                label: 'Password',
                isPassword: true,
                onChanged: (val) => ref.read(logInNotifierProvider.notifier).onPasswordChange(val),
              ),
              SizedBox(height: 20.h),
              PrimaryButton(
                isLoading: loginProvider.loading,
                text: 'Login',
                onTap: () => _controller.handleSignIn(
                  ref,
                  () => context.go(AppRoutes.dashboard),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
