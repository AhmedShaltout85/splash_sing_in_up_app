class TaskModel {
  final String id;
  final String taskTitle;
  final String taskDescription;
  final String dateTime;
  final bool status;
  final String assignedTo;
  final String assignedBy;
  final String createdAt;
  final String updatedAt;
  String? notes;

  TaskModel({
    required this.id,
    required this.taskTitle,
    required this.taskDescription,
    required this.dateTime,
    required this.status,
    required this.assignedTo,
    required this.assignedBy,
    required this.createdAt,
    required this.updatedAt,
    this.notes,
  });

  TaskModel copyWith({
    String? id,
    String? taskTitle,
    String? taskDescription,
    String? dateTime,
    bool? status,
    String? assignedTo,
    String? assignedBy,
    String? createdAt,
    String? updatedAt,
    String? notes,
  }) {
    return TaskModel(
      id: id ?? this.id,
      taskTitle: taskTitle ?? this.taskTitle,
      taskDescription: taskDescription ?? this.taskDescription,
      dateTime: dateTime ?? this.dateTime,
      status: status ?? this.status,
      assignedTo: assignedTo ?? this.assignedTo,
      assignedBy: assignedBy ?? this.assignedBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      notes: notes ?? this.notes,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'taskTitle': taskTitle,
      'taskDescription': taskDescription,
      'dateTime': dateTime,
      'status': status,
      'assignedTo': assignedTo,
      'assignedBy': assignedBy,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'notes': notes,
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'] ?? '',
      taskTitle: map['taskTitle'] ?? '',
      taskDescription: map['taskDescription'] ?? '',
      dateTime: map['dateTime'] ?? '',
      status: map['status'] ?? false,
      assignedTo: map['assignedTo'] ?? '',
      assignedBy: map['assignedBy'] ?? '',
      createdAt: map['createdAt'] ?? '',
      updatedAt: map['updatedAt'] ?? '',
      notes: map['notes'] ?? '',
    );
  }
}
