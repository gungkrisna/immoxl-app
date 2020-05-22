import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String userId;
  final String name;

  User({
    this.userId,
    this.name,
  });

  Map<String, Object> toJson() {
    return {
      'userId': userId,
      'name': name,
    };
  }

  factory User.fromJson(Map<String, Object> doc) {
    User user = new User(
      userId: doc['userId'],
      name: doc['name'],
    );
    return user;
  }

  factory User.fromDocument(DocumentSnapshot doc) {
    return User.fromJson(doc.data);
  }
}
