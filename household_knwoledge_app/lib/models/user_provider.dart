// lib/providers/user_provider.dart

import 'package:flutter/foundation.dart';
import 'package:household_knwoledge_app/models/user_model.dart';

class UserProvider with ChangeNotifier {
  // Initialize currUsers with predefined users
  final List<User> _currUsers = [
    User(
      username: 'JohnDoe',
      points: 100,
      role: 'child',
      preferences: ['Cleaning', 'Cooking'],
      contributions: {'Cleaning': 50, 'Gardening': 30, 'Cooking': 20, "Shopping": 0, "Planning" : 0,"Care" : 0,"Maintenance" : 0,"Other" : 0},
      profilepath: "lib/assets/f.jpeg",
    ),
    User(username: 'Sarah',preferences: ["Gardening","Shopping"], points: 122, profilepath: "lib/assets/f.jpeg",),
    User(username: 'Max', preferences: ["Shopping","Planning",],points: 125, profilepath: "lib/assets/f.jpeg",),
    User(username: 'Anna', preferences: ["Planning","Care",], points: 90),
    User(username: 'Marie', preferences: ['Cleaning', "Maintenance",], points: 100),
    User(username: 'Alex', preferences: ['Gardening', 'Cooking'], points: 75),
  ];

  // Getter to access currUsers
  List<User> get currUsers => _currUsers;

  // Method to add a new user
  void addUser(User user) {
    _currUsers.add(user);
    notifyListeners();
  }

  // Method to remove a user
  void removeUser(User user) {
    _currUsers.remove(user);
    notifyListeners();
  }

  // Method to update a user
/*   void updateUser(int index, User updatedUser) {
    if (index >= 0 && index < _currUsers.length) {
      _currUsers[index] = updatedUser;
      notifyListeners();
    }
  } */

  // Example method to add points to a user
  void addPointsToUser(int index, int pointsToAdd) {
    if (index >= 0 && index < _currUsers.length) {
      _currUsers[index].addPoints(pointsToAdd);
      notifyListeners();
    }
  }
  User getCurrUser() {
    return _currUsers.firstWhere((user) => user.username == 'JohnDoe');
  }
  

  // Additional methods as needed...
}
