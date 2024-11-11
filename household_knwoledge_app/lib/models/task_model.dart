class Task {
  String title;
  DateTime deadline;
  String category;
  String difficulty;
  String description;
  int rewardPoints;
  bool isAccepted;
  bool isCompleted;
  String acceptedBy; // Username of the user who accepted the task

  Task({
    required this.title,
    required this.deadline,
    required this.category,
    required this.difficulty,
    this.description = '',
    this.rewardPoints = 0,
    this.isAccepted = false,
    this.isCompleted = false,
    this.acceptedBy = '',
  });
}
