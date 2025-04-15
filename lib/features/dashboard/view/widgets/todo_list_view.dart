import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/features/dashboard/controller/todo_controller.dart';
import 'package:todo_app/models/todo.dart';

import 'todo_widget.dart';

class TodoListView extends StatefulWidget {
  final WidgetRef ref;
  final bool isSharedList;

  const TodoListView({
    super.key,
    required this.ref,
    this.isSharedList = false,
  });

  @override
  State<TodoListView> createState() => _TodoListViewState();
}

class _TodoListViewState extends State<TodoListView> {
  final _scrollController = ScrollController();
  bool _isLoadingMore = false;

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 40) {
        _maybeLoadMore();
      }
    });
  }

  void _maybeLoadMore() async {
    //I tried to write this better but ended up with this :s
    if (widget.isSharedList) {
      final todoController = widget.ref.read(sharedTodosControllerProvider.notifier);

      if (!_isLoadingMore && todoController.hasMore) {
        setState(() => _isLoadingMore = true);
        await todoController.loadMore();
        setState(() => _isLoadingMore = false);
      }
    } else {
      final todoController = widget.ref.read(todosControllerProvider.notifier);

      if (!_isLoadingMore && todoController.hasMore) {
        setState(() => _isLoadingMore = true);
        await todoController.loadMore();
        setState(() => _isLoadingMore = false);
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final todosStream = widget.isSharedList ? widget.ref.watch(sharedTodosControllerProvider) : widget.ref.watch(todosControllerProvider);
    final hasMore =
        widget.isSharedList ? widget.ref.watch(sharedTodosControllerProvider.notifier).hasMore : widget.ref.watch(todosControllerProvider.notifier).hasMore;
    final actions = widget.ref.read(todoActionsControllerProvider.notifier);

    return todosStream.when(
      data: (todos) {
        if (todos.isEmpty) {
          return const Center(child: Text('Add a Todo'));
        }

        return RefreshIndicator(
          onRefresh: () async {
            if (widget.isSharedList) {
              widget.ref.read(sharedTodosControllerProvider.notifier).refetch();
            } else {
              widget.ref.read(todosControllerProvider.notifier).refetch();
            }
          },
          child: ListView.builder(
            controller: _scrollController,
            itemCount: todos.length + (hasMore ? 1 : 0),
            itemBuilder: (context, index) {
              if (index == todos.length) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              final todo = todos[index];

              return TodoWidget(
                key: Key(todo.id),
                delete: () => actions.deleteTodo(todo.id),
                toggle: () => actions.updateTodo(todo.copyWith(done: !todo.done)),
                todo: todo,
                isFirst: index == 0,
                showOwner: widget.isSharedList,
              );
            },
          ),
        );
      },
      error: (error, stackTrace) => Center(
        child: Text('Something went wrong.'),
      ),
      loading: () => Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
