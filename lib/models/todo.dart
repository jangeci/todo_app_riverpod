class Todo {
  final String id;
  final String title;
  final String owner;
  final bool done;
  final List<String> sharedWith;
  final DateTime createdAt;

  Todo({
    required this.id,
    required this.title,
    required this.owner,
    required this.done,
    required this.sharedWith,
    required this.createdAt,
  });

  factory Todo.fromJson(id, Map<String, dynamic> json) {
    return Todo(
      id: id,
      title: json['title'] as String,
      owner: json['owner'] as String,
      done: json['done'] as bool? ?? false,
      createdAt: DateTime.fromMillisecondsSinceEpoch(json['createdAt'] as int),
      sharedWith: List<String>.from(json['sharedWith'] ?? []),
    );
  }

  Todo copyWith({
    String? id,
    String? title,
    String? owner,
    bool? done,
    List<String>? sharedWith,
    DateTime? createdAt,
  }) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      owner: owner ?? this.owner,
      done: done ?? this.done,
      sharedWith: sharedWith ?? List.from(this.sharedWith),
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'owner': owner,
      'done': done,
      'sharedWith': sharedWith,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }
}
