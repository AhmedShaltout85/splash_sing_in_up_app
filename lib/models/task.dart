import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  final String id;
  final String? title;
  final bool status;
  final String? taskDescription;
  final String? assignedTo;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? notes;

  Task({
    this.taskDescription,
    required this.id,
    this.title,
    required this.status,
    this.assignedTo,
    this.createdAt,
    this.updatedAt,
    this.notes,
  });

  // Convert Firestore document to Task
  factory Task.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return Task(
      id: doc.id,
      title: data['title'] as String?,
      status: data['status'] as bool? ?? false,
      assignedTo: data['assignedTo'] as String?,
      notes: data['notes'] as String?,
      taskDescription: data['taskDescription'] as String?,
      // Convert Timestamp to DateTime
      createdAt: (data['createdAt'] as Timestamp?)?.toDate(),
      updatedAt: (data['updatedAt'] as Timestamp?)?.toDate(),
    );
  }

  // Convert Task to Map for Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'title': title,
      'status': status,
      'assignedTo': assignedTo,
      'notes': notes,
      'taskDescription': taskDescription,
      'createdAt': createdAt != null
          ? Timestamp.fromDate(createdAt!)
          : FieldValue.serverTimestamp(),
      'updatedAt': updatedAt != null
          ? Timestamp.fromDate(updatedAt!)
          : FieldValue.serverTimestamp(),
    };
  }

  // CopyWith method for updating
  Task copyWith({
    String? id,
    String? title,
    bool? status,
    String? assignedTo,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? taskDescription,
    String? notes,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      status: status ?? this.status,
      assignedTo: assignedTo ?? this.assignedTo,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      notes: notes ?? this.notes,
      taskDescription: taskDescription ?? this.taskDescription,
    );
  }
}
