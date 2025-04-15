import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/features/dashboard/repo/todo_repo.dart';
import 'package:todo_app/models/todo.dart';

class TodosPaginationManager {
  final _mergedStream = StreamController<List<Todo>>.broadcast();
  final List<StreamSubscription<List<Todo>>> _subscriptions = [];
  final List<Todo> _allTodos = [];
  final Set<String> _existingIds = {};

  DocumentSnapshot<Todo>? _lastDoc;
  bool _hasMore = true;

  bool get hasMore => _hasMore;

  Stream<List<Todo>> get stream => _mergedStream.stream;

  Future<void> loadNextPage(TodoRepository repo) async {
    if (!_hasMore) return;

    final pageStream = repo.getTodosPageStream(startAfter: _lastDoc);
    final sub = pageStream.listen((todos) {
      for (var todo in todos) {
        if (_existingIds.add(todo.id)) {
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

    _lastDoc = await repo.getLastDocumentFromPage(startAfter: _lastDoc);
    if (_lastDoc == null) {
      _hasMore = false;
    }
  }

  void dispose() {
    for (final sub in _subscriptions) {
      sub.cancel();
    }
    _mergedStream.close();
  }

  void refetch(TodoRepository repo) {
    _allTodos.clear();
    _existingIds.clear();
    _lastDoc = null;
    _hasMore = true;
    for (final sub in _subscriptions) {
      sub.cancel();
    }
    _subscriptions.clear();
    loadNextPage(repo);
  }
}
