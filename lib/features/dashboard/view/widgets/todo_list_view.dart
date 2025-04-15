import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/features/dashboard/controller/todo_controller.dart';
import 'package:todo_app/models/todo.dart';

import 'todo_widget.dart';

class TodoListView extends StatelessWidget {
  final WidgetRef ref;
  final List<Todo>? todos;
  final bool showOwner;

  const TodoListView({
    super.key,
    required this.ref,
    required this.todos,
    this.showOwner = false,
  });

  @override
  Widget build(BuildContext context) {
    if (todos == null || todos!.isEmpty) {
      return const Center(child: Text('Add a Todo'));
    }

    return ListView.builder(
      itemCount: todos!.length,
      itemBuilder: (context, index) {
        final todo = todos![index];

        final actions = ref.read(todoActionsControllerProvider.notifier);

        return TodoWidget(
          key: Key(todo.id),
          delete: () => actions.deleteTodo(todo.id),
          toggle: () => actions.updateTodo(todo.copyWith(done: !todo.done)),
          todo: todo,
          isFirst: index == 0,
          showOwner: showOwner,
        );
      },
    );
  }
}
