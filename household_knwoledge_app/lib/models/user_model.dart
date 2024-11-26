class User {
  String username;
  int points;
  String role; // child
  List<String> preferences; 
  Map<String, int> contributions; 

  User({
    required this.username,
    this.points = 0,
    this.role = 'Member', 
    this.preferences = const [], 
    this.contributions = const {}, 
  });

  void addPoints(int pointsToAdd) {
    points += pointsToAdd;
  }

  void updateRole(String newRole) {
    role = newRole;
  }

  void setPreferences(List<String> newPreferences) {
    preferences = newPreferences;
  }

  void updateContributions(Map<String, int> newContributions) {
    contributions = newContributions;
  }
}
