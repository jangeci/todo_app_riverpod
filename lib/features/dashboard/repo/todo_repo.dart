import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/common/utils/constants.dart';
import 'package:todo_app/global.dart';
import 'package:todo_app/models/todo.dart';

class TodoRepository {
  final FirebaseFirestore _firestore;

  final String _email;

  TodoRepository({FirebaseFirestore? fireStore})
      : _firestore = fireStore ?? FirebaseFirestore.instance,
        _email = Global.storageService.getUserProfile()!.email;

  CollectionReference<Todo> get _todoCollection => _firestore.collection(AppConstants.TODO_COLLECTION_REF).withConverter<Todo>(
        fromFirestore: (snap, _) => Todo.fromJson(snap.id, snap.data()!),
        toFirestore: (todo, _) => todo.toJson(),
      );

  Query<Todo> get _myTodosQuery => _todoCollection.where('owner', isEqualTo: _email);

  Query<Todo> get _sharedTodosQuery => _todoCollection.where('sharedWith', arrayContains: _email);

  Stream<List<Todo>> getTodos() {
    return _myTodosQuery.snapshots().map((snapshot) => snapshot.docs.map((doc) {
          return doc.data();
        }).toList());
  }

  Stream<List<Todo>> getSharedTodos() {
    return _sharedTodosQuery.snapshots().map((snapshot) => snapshot.docs.map((doc) {
          return doc.data();
        }).toList());
  }

  Future<void> addTodo(Todo todo) => _todoCollection.add(todo);

  Future<void> updateTodo(Todo todo) => _todoCollection.doc(todo.id).update(todo.toJson());

  Future<void> deleteTodo(String id) => _todoCollection.doc(id).delete();

  Future<Todo?> getTodoById(String id) async {
    final doc = await _todoCollection.doc(id).get();
    return doc.data();
  }
}
