import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/common/utils/constants.dart';
import 'package:todo_app/global.dart';
import 'package:todo_app/models/todo.dart';

class TodoRepository {
  final FirebaseFirestore _firestore;

  final String _email;
  final bool isShared;

  TodoRepository({FirebaseFirestore? fireStore, this.isShared = false})
      : _firestore = fireStore ?? FirebaseFirestore.instance,
        _email = Global.storageService.getUserProfile()!.email;

  CollectionReference<Todo> get _todoCollection => _firestore.collection(AppConstants.TODO_COLLECTION_REF).withConverter<Todo>(
        fromFirestore: (snap, _) => Todo.fromJson(snap.id, snap.data()!),
        toFirestore: (todo, _) => todo.toJson(),
      );

  Query<Todo> get _myTodosQuery => isShared ? _todoCollection.where('sharedWith', arrayContains: _email) : _todoCollection.where('owner', isEqualTo: _email);

  Stream<List<Todo>> getTodosPageStream({
    int limit = 10,
    DocumentSnapshot<Todo>? startAfter,
  }) {
    Query<Todo> query = _myTodosQuery.orderBy('createdAt', descending: true).limit(limit);

    if (startAfter != null) {
      query = query.startAfterDocument(startAfter);
    }

    return query.snapshots().map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }

  Future<DocumentSnapshot<Todo>?> getLastDocumentFromPage({
    int limit = 10,
    DocumentSnapshot<Todo>? startAfter,
  }) async {
    Query<Todo> query = _myTodosQuery.orderBy('createdAt', descending: true).limit(limit);

    if (startAfter != null) {
      query = query.startAfterDocument(startAfter);
    }

    final snapshot = await query.get();
    return snapshot.docs.isNotEmpty ? snapshot.docs.last : null;
  }

  Future<void> addTodo(Todo todo) => _todoCollection.add(todo);

  Future<void> updateTodo(Todo todo) => _todoCollection.doc(todo.id).update(todo.toJson());

  Future<void> deleteTodo(String id) => _todoCollection.doc(id).delete();

  Future<Todo?> getTodoById(String id) async {
    final doc = await _todoCollection.doc(id).get();
    return doc.data();
  }
}
