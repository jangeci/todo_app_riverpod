import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/common/routes.dart';
import 'package:todo_app/common/utils/constants.dart';
import 'package:todo_app/features/login/repo/log_in_repo.dart';
import 'package:todo_app/global.dart';

class AppUtils {
  static void logout(BuildContext context) {
    LogInRepo.firebaseSignOut();
    Global.storageService.remove(AppConstants.STORAGE_USER_PROFILE_KEY);
    Global.storageService.remove(AppConstants.STORAGE_USER_TOKEN_KEY);
    context.go(AppRoutes.login);
  }

  static String makeShareLink(String id) {
    return 'todoapp://dashboard?id=$id';
  }
}
