import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todo_app/common/widgets/popup_messages.dart';
import 'package:todo_app/features/dashboard/repo/todo_repo.dart';
import 'package:todo_app/global.dart';
import 'package:todo_app/models/todo.dart';

part 'todo_controller.g.dart';

@riverpod
class TodoController extends _$TodoController {
  final _repo = TodoRepository();

  @override
  Stream<List<Todo>> build() {
    return _repo.getTodos();
  }
}

@riverpod
class SharedTodosController extends _$SharedTodosController {
  final _repo = TodoRepository();

  @override
  Stream<List<Todo>> build() {
    return _repo.getSharedTodos();
  }
}

@riverpod
class TodoActionsController extends _$TodoActionsController {
  final _repo = TodoRepository();
  final TextEditingController textEditingController = TextEditingController();

  @override
  void build() {}

  Future<void> addTodo() async {
    String? email = Global.storageService.getUserProfile()?.email;
    if (email != null) {
      Todo todo = Todo(
        id: '',
        title: textEditingController.text,
        owner: email,
        done: false,
        sharedWith: [],
        createdAt: DateTime.now(),
      );
      await _repo.addTodo(todo);
      textEditingController.clear();
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
