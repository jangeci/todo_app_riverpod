import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/common/utils/app_utils.dart';
import 'package:todo_app/common/widgets/app_bar_widget.dart';
import 'package:todo_app/common/widgets/app_textfield.dart';
import 'package:todo_app/common/widgets/primary_button.dart';
import 'package:todo_app/common/widgets/text_widgets.dart';
import 'package:todo_app/features/dashboard/controller/todo_controller.dart';
import 'package:todo_app/features/dashboard/view/widgets/todo_list_view.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBarWidget(
        title: 'TODO App',
        actions: [
          TextButton(
            onPressed: () {
              AppUtils.logout(context);
            },
            child: const Text13Normal(
              'Logout',
              color: Colors.red,
              fontWeight: FontWeight.w600,
            ),
          )
        ],
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            Container(
              color: Colors.grey.shade200,
              child: TabBar(
                tabs: [
                  Tab(
                      child: Text16Normal(
                    'My tasks',
                    fontWeight: FontWeight.w600,
                  )),
                  Tab(
                      child: Text16Normal(
                    'Shared with me',
                    fontWeight: FontWeight.w600,
                  )),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: TabBarView(children: [
                      TodoListView(
                        ref: ref,
                      ),
                      TodoListView(
                        ref: ref,
                        isSharedList: true,
                      ),
                    ]),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.w),
                    child: PrimaryButton(onTap: () => _displayTextInputDialog(ref), text: 'Add todo'),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }

  _displayTextInputDialog(WidgetRef ref) async {
    final actionsController = ref.read(todoActionsControllerProvider.notifier);
    final todosNotifier = ref.read(todosControllerProvider.notifier);

    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text16Normal('Add a todo'),
          content: AppTextField(controller: actionsController.textEditingController, label: 'Title'),
          actions: [
            PrimaryButton(
                onTap: () {
                  actionsController.addTodo();
                  todosNotifier.refetch();
                  Navigator.pop(context);
                },
                text: 'Create')
          ],
        );
      },
    );
  }
}
