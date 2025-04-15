// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$todoControllerHash() => r'ed90985c522277a21da15671144b94d33702f5be';

/// See also [TodoController].
@ProviderFor(TodoController)
final todoControllerProvider =
    AutoDisposeStreamNotifierProvider<TodoController, List<Todo>>.internal(
  TodoController.new,
  name: r'todoControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$todoControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$TodoController = AutoDisposeStreamNotifier<List<Todo>>;
String _$sharedTodosControllerHash() =>
    r'576a4ba71d6830a26261a7d67fe633a221df9118';

/// See also [SharedTodosController].
@ProviderFor(SharedTodosController)
final sharedTodosControllerProvider = AutoDisposeStreamNotifierProvider<
    SharedTodosController, List<Todo>>.internal(
  SharedTodosController.new,
  name: r'sharedTodosControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$sharedTodosControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SharedTodosController = AutoDisposeStreamNotifier<List<Todo>>;
String _$todoActionsControllerHash() =>
    r'fbd46c4a7dbccaa2c62ac460fa85ce0f4cadf04e';

/// See also [TodoActionsController].
@ProviderFor(TodoActionsController)
final todoActionsControllerProvider =
    AutoDisposeNotifierProvider<TodoActionsController, void>.internal(
  TodoActionsController.new,
  name: r'todoActionsControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$todoActionsControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$TodoActionsController = AutoDisposeNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
