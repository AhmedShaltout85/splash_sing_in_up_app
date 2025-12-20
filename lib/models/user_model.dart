import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  final String name;
  final String email;
  final int age;
  final DateTime createdAt;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.age,
    required this.createdAt,
  });

  // Convert UserModel to Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'age': age,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  // Create UserModel from Firestore document
  factory UserModel.fromMap(String id, Map<String, dynamic> map) {
    DateTime createdAtDateTime;

    // Handle Timestamp from Firestore
    if (map['createdAt'] is Timestamp) {
      createdAtDateTime = (map['createdAt'] as Timestamp).toDate();
    } else if (map['createdAt'] is String) {
      createdAtDateTime = DateTime.parse(map['createdAt']);
    } else {
      createdAtDateTime = DateTime.now();
    }

    return UserModel(
      id: id,
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      age: map['age'] ?? 0,
      createdAt: createdAtDateTime,
    );
  }

  // Create a copy with modified fields
  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    int? age,
    DateTime? createdAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      age: age ?? this.age,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
