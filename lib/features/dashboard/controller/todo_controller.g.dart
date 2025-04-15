// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$todosControllerHash() => r'8063aada1e47b8797ccd94a5aca939c2344b2d3d';

/// See also [TodosController].
@ProviderFor(TodosController)
final todosControllerProvider =
    StreamNotifierProvider<TodosController, List<Todo>>.internal(
  TodosController.new,
  name: r'todosControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$todosControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$TodosController = StreamNotifier<List<Todo>>;
String _$sharedTodosControllerHash() =>
    r'b23ea2d65cd10a85f5c9eecdfcc33349812a26f9';

/// See also [SharedTodosController].
@ProviderFor(SharedTodosController)
final sharedTodosControllerProvider =
    StreamNotifierProvider<SharedTodosController, List<Todo>>.internal(
  SharedTodosController.new,
  name: r'sharedTodosControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$sharedTodosControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SharedTodosController = StreamNotifier<List<Todo>>;
String _$todoActionsControllerHash() =>
    r'f7f49a6bdfad8c354f227a98561e5693caa2055e';

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
