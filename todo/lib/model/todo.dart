class Todo {
  final int userId;
  final int id;
  final String title;
  final bool completed;

  Todo({
    this.userId = 1,
    required this.id,
    required this.title,
    this.completed = false,
  });
}
