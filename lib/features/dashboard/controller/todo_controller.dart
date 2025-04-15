import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
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
  final List<StreamSubscription<List<Todo>>> _subscriptions = [];
  final List<Todo> _allTodos = [];
  final Set<String> _existingIds = {};
  DocumentSnapshot<Todo>? _lastDoc;
  bool _hasMore = true;

  bool get getHasMore => _hasMore;

  final _mergedStream = StreamController<List<Todo>>.broadcast();

  @override
  Stream<List<Todo>> build() {
    ref.onDispose(() {
      for (final sub in _subscriptions) {
        sub.cancel();
      }
      _mergedStream.close();
    });

    _loadNextPage();
    return _mergedStream.stream;
  }

  Future<void> _loadNextPage() async {
    if (!_hasMore) return;
    final pageStream = _repo.getTodosPageStream(startAfter: _lastDoc);

    final sub = pageStream.listen((todos) {
      for (var todo in todos) {
        if (!_existingIds.contains(todo.id)) {
          _existingIds.add(todo.id);
          _allTodos.add(todo);
        } else {
          final index = _allTodos.indexWhere((item) => item.id == todo.id);
          if (index != -1) {
            _allTodos[index] = todo;
          }
        }
      }
      _mergedStream.add(List<Todo>.from(_allTodos));
    });

    _subscriptions.add(sub);

    _lastDoc = await _repo.getLastDocumentFromPage(
      startAfter: _lastDoc,
    );

    if (_lastDoc == null) {
      _hasMore = false;
    }
  }

  Future<void> loadMore() async {
    await _loadNextPage();
  }

  void refetch() {
    _allTodos.clear();
    _existingIds.clear();
    _lastDoc = null;
    _hasMore = true;
    for (final sub in _subscriptions) {
      sub.cancel();
    }
    _subscriptions.clear();
    _loadNextPage();
  }
}

@riverpod
class SharedTodosController extends _$SharedTodosController {
  final _repo = TodoRepository(isShared: true);
  final List<StreamSubscription<List<Todo>>> _subscriptions = [];
  final List<Todo> _allTodos = [];
  final Set<String> _existingIds = {};
  DocumentSnapshot<Todo>? _lastDoc;
  bool _hasMore = true;

  bool get getHasMore => _hasMore;

  final _mergedStream = StreamController<List<Todo>>.broadcast();

  @override
  Stream<List<Todo>> build() {
    ref.onDispose(() {
      for (final sub in _subscriptions) {
        sub.cancel();
      }
      _mergedStream.close();
    });

    _loadNextPage();
    return _mergedStream.stream;
  }

  Future<void> _loadNextPage() async {
    if (!_hasMore) return;
    final pageStream = _repo.getTodosPageStream(
      startAfter: _lastDoc,
    );

    final sub = pageStream.listen((todos) {
      for (var todo in todos) {
        if (!_existingIds.contains(todo.id)) {
          _existingIds.add(todo.id);
          _allTodos.add(todo);
        } else {
          final index = _allTodos.indexWhere((item) => item.id == todo.id);
          if (index != -1) {
            _allTodos[index] = todo;
          }
        }
      }
      _mergedStream.add(List<Todo>.from(_allTodos));
    });

    _subscriptions.add(sub);

    _lastDoc = await _repo.getLastDocumentFromPage(
      startAfter: _lastDoc,
    );

    if (_lastDoc == null) {
      _hasMore = false;
    }
  }

  Future<void> loadMore() async {
    await _loadNextPage();
  }

  void refetch() {
    _allTodos.clear();
    _existingIds.clear();
    _lastDoc = null;
    _hasMore = true;
    for (final sub in _subscriptions) {
      sub.cancel();
    }
    _subscriptions.clear();
    _loadNextPage();
  }
}

@riverpod
class TodoActionsController extends _$TodoActionsController {
  final _repo = TodoRepository();
  final TextEditingController textEditingController = TextEditingController();

  @override
  void build() {
    ref.onDispose(() {
      textEditingController.dispose();
    });
  }

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
