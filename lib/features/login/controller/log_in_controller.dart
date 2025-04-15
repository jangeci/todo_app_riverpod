import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/common/utils/constants.dart';
import 'package:todo_app/common/widgets/popup_messages.dart';
import 'package:todo_app/features/login/provider/log_in_notifier.dart';
import 'package:todo_app/features/login/repo/log_in_repo.dart';
import 'package:todo_app/global.dart';
import 'package:todo_app/models/user.dart';

class LogInController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void init(WidgetRef ref) {
    if (kDebugMode) {
      const testEmail = 'test@test.com';
      const testPassword = 'password';

      final notifier = ref.read(logInNotifierProvider.notifier);
      notifier.onEmailChange(testEmail);
      notifier.onPasswordChange(testPassword);

      emailController.text = testEmail;
      passwordController.text = testPassword;
    }
  }

  void dispose() {
    passwordController.dispose();
    emailController.dispose();
  }

  void handleSignIn(WidgetRef ref, Function() navigate) async {
    var state = ref.read(logInNotifierProvider);

    String email = state.email;
    String password = state.password;

    emailController.text = email;
    passwordController.text = password;

    if (email.isEmpty || state.email.isEmpty) {
      toastInfo('Your email is empty');
      return;
    }

    if (state.password.isEmpty || password.isEmpty) {
      toastInfo('Enter password');
      return;
    }

    ref.read(logInNotifierProvider.notifier).onLoadingChange(true);

    try {
      final credential = await LogInRepo.firebaseSignIn(email, password);
      if (credential.user == null) {
        toastInfo('User not found');
      }
      // } else if (!credential.user!.emailVerified) {
      //   toastInfo('You must verify your email');
      // }
      var user = credential.user;
      if (user != null) {
        String? email = user.email;
        if (email == null) {
          toastInfo(
            'Sorry, we were not able to get you email from firebase, this app will not work without it.',
            variant: ToastVariant.error,
          );
          await LogInRepo.firebaseSignOut();
          ref.read(logInNotifierProvider.notifier).onLoadingChange(false);
          return;
        }

        String id = user.uid;

        UserProfileModel appUer = UserProfileModel(
          id: id,
          email: email,
        );

        String? accessToken = await user.getIdToken();

        if (accessToken == null) {
          throw 'Couldnt get access token';
        }

        Global.storageService.setString(
          AppConstants.STORAGE_USER_PROFILE_KEY,
          jsonEncode(appUer.toJson()),
        );
        Global.storageService.setString(AppConstants.STORAGE_USER_TOKEN_KEY, accessToken);

        navigate();

        print('user loged in firebase');
      } else {
        toastInfo('login error');
      }
    } on FirebaseException catch (e) {
      if (e.code == 'user-not-found') {
        toastInfo('User doesnt exist');
      } else if (e.code == 'wrong-password') {
        toastInfo('Your password is wrong');
      } else {
        toastInfo(e.toString());
      }
    } catch (e) {
      if (kDebugMode) {
        toastInfo(e.toString());
      }
    }

    ref.read(logInNotifierProvider.notifier).onLoadingChange(false);
  }
}
