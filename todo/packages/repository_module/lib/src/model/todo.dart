class Todo {
  final int id;
  final String title;
  final String description;
  final String createdDate;

  Todo({
    this.id = 0,
    this.title = '',
    this.description = '',
    this.createdDate = '',
  });

  Todo copyWith({
    int id = 0,
    String title = '',
    String description = '',
    String createdDate = '',
  }) {
    return Todo(
      id: id,
      title: title,
      description: description,
      createdDate: createdDate,
    );
  }
}
