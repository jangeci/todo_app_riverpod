import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app_links/app_links.dart';
import 'package:todo_app/features/dashboard/controller/todo_controller.dart';
import 'package:todo_app/global.dart';
import 'package:todo_app/models/todo.dart';

class DeepLinkHandler extends ConsumerStatefulWidget {
  final Widget child;

  const DeepLinkHandler({super.key, required this.child});

  @override
  ConsumerState<DeepLinkHandler> createState() => _DeepLinkHandlerState();
}

class _DeepLinkHandlerState extends ConsumerState<DeepLinkHandler> {
  final _appLinks = AppLinks();

  @override
  void initState() {
    super.initState();
    _initDeepLinks();
  }

  void _initDeepLinks() async {
    final initial = await _appLinks.getInitialLink();
    if (initial != null) _handleUri(initial);

    _appLinks.uriLinkStream.listen((uri) {
      _handleUri(uri);
    });
  }

  Future<void> _handleUri(Uri uri) async {
    debugPrint("Deep link received: $uri");

    final path = uri.host;
    final id = uri.queryParameters['id'];

    switch (path) {
      case 'dashboard':
        if (id != null) {
          String? email = Global.storageService.getUserProfile()?.email;
          if (email != null) {
            final actionsController = ref.read(todoActionsControllerProvider.notifier);
            Todo? todo = await actionsController.getTodoById(id);
            if (todo != null) {
              actionsController.onTodoShared(id);
            }
          }
        }
        break;
      default:
        debugPrint("Unknown deep link: $uri");
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
