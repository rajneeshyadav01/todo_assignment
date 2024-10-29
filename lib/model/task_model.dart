class TodoItem {
  String title;
  bool isCompleted;

  TodoItem({required this.title, this.isCompleted = false});

  Map<String, dynamic> toJson() => {
    'title': title,
    'isCompleted': isCompleted,
  };

  factory TodoItem.fromJson(Map<String, dynamic> json) {
    return TodoItem(
      title: json['title'],
      isCompleted: json['isCompleted'],
    );
  }
}