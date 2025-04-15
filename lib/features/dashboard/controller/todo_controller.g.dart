// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$todoControllerHash() => r'2a29164f4802358d44230274f0f336e39841d230';

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
    r'f3ff09d8bb373d4eec760f7ce984c8788b33f99e';

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
