// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$todosControllerHash() => r'653391b0af68efdab4b5fcff4430fefec4b75aab';

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
    r'd2de131cf4f809c07c204e2c2510440a05732527';

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
    r'cc213ffa4434cd368263ac769ddaad568e470e39';

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
