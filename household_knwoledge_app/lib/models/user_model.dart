class User {
  String username;
  int points;

  User({required this.username, this.points = 0});

  void addPoints(int pointsToAdd) {
    points += pointsToAdd;
  }
}
