import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todo_app/common/widgets/popup_messages.dart';
import 'package:todo_app/features/dashboard/controller/todos_pagination_manager.dart';
import 'package:todo_app/features/dashboard/repo/todo_repo.dart';
import 'package:todo_app/global.dart';
import 'package:todo_app/models/todo.dart';

part 'todo_controller.g.dart';

@Riverpod(keepAlive: true)
class TodosController extends _$TodosController {
  final _repo = TodoRepository();
  final _pagination = TodosPaginationManager();

  @override
  Stream<List<Todo>> build() {
    ref.onDispose(_pagination.dispose);
    _pagination.loadNextPage(_repo);
    return _pagination.stream;
  }

  @override
  bool get hasMore => _pagination.hasMore;

  Future<void> loadMore() => _pagination.loadNextPage(_repo);

  Future<void> refetch() async {
    await _pagination.refetch(_repo);
  }
}

@Riverpod(keepAlive: true)
class SharedTodosController extends _$SharedTodosController {
  final _repo = TodoRepository(isShared: true);
  final _pagination = TodosPaginationManager();

  @override
  Stream<List<Todo>> build() {
    ref.onDispose(_pagination.dispose);
    _pagination.loadNextPage(_repo);
    return _pagination.stream;
  }

  @override
  bool get hasMore => _pagination.hasMore;

  Future<void> loadMore() => _pagination.loadNextPage(_repo);

  Future<void> refetch() async {
    await _pagination.refetch(_repo);
  }
}

@riverpod
class TodoActionsController extends _$TodoActionsController {
  final _repo = TodoRepository();

  @override
  void build() {}

  Future<void> addTodo(String title) async {
    String? email = Global.storageService.getUserProfile()?.email;
    if (email != null) {
      Todo todo = Todo(
        id: '',
        title: title,
        owner: email,
        done: false,
        sharedWith: [],
        createdAt: DateTime.now(),
      );
      await _repo.addTodo(todo);
    }
  }

  Future<void> updateTodo(Todo todo) async {
    await _repo.updateTodo(todo);
  }

  Future<void> deleteTodo(String id) async {
    await _repo.deleteTodo(id);
  }

  Future<Todo?> getTodoById(String id) async {
    final result = await _repo.getTodoById(id);
    return result;
  }

  Future<void> onTodoShared(String id) async {
    final Todo? todo = await _repo.getTodoById(id);
    if (todo != null) {
      String? email = Global.storageService.getUserProfile()?.email;
      if (email != null) {
        if (!todo.sharedWith.contains(email) && todo.owner != email) {
          await updateTodo(
            todo.copyWith(
              sharedWith: [...todo.sharedWith, email],
            ),
          );

          toastInfo('Task: ${todo.title}, was shared with you.');
        }
      }
    }
  }
}
