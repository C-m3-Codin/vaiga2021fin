import 'package:flutter/material.dart';
import 'userModel.dart';

class userProvider with ChangeNotifier {
  List<User> _users = [User(name: "Cyril", userID: "2018016")];
  int selectedUser = 0;

  List<User> get getUser {
    return [..._users];
  }

  get getSelected {
    return selectedUser;
  }

  void addUser(User user) {
    _users.add(user);
    notifyListeners();
  }

  void changeName(User user, String newName) {
    user.name = newName;
    notifyListeners();
  }

  void updateSelectedUser(int n) {
    selectedUser = n;
    notifyListeners();
  }
}
