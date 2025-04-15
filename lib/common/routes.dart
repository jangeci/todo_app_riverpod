import 'package:go_router/go_router.dart';
import 'package:todo_app/features/dashboard/view/dashboard_screen.dart';
import 'package:todo_app/features/login/view/login_screen.dart';
import 'package:todo_app/global.dart';

class AppRoutes {
  static const String login = '/';
  static const String dashboard = '/dashboard';
}

final GoRouter router = GoRouter(
  initialLocation: AppRoutes.login,
  redirect: (context, state) {
    final isLoggedIn = Global.storageService.isLoggedIn();
    final loggingIn = state.fullPath == AppRoutes.login;

    if (!isLoggedIn && !loggingIn) return AppRoutes.login;
    if (isLoggedIn && loggingIn) return AppRoutes.dashboard;

    return null;
  },
  routes: [
    GoRoute(
      path: AppRoutes.login,
      builder: (context, state) => LogInScreen(),
    ),
    GoRoute(
      path: AppRoutes.dashboard,
      builder: (context, state) => DashboardScreen(),
    )
  ],
);
