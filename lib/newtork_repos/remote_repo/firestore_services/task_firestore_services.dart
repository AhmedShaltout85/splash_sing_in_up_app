import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:splash_sing_in_up_app/models/task_model.dart';

class TaskFirestoreServices {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;
  static const String _collectionName = 'tasks';

  // Add a new document
  static Future<String> addTaskData(TaskModel task) async {
    try {
      DocumentReference docRef = await _db
          .collection(_collectionName)
          .add(task.toMap());
      return docRef.id;
    } catch (e) {
      throw Exception('Error adding data: $e');
    }
  }

  // Add a document with custom ID
  static Future<void> addTaskDataWithId(String id, TaskModel task) async {
    try {
      await _db.collection(_collectionName).doc(id).set(task.toMap());
    } catch (e) {
      throw Exception('Error adding data with ID: $e');
    }
  }

  // Retrieve a single document by ID
  static Future<TaskModel?> getData(String id) async {
    try {
      DocumentSnapshot doc = await _db
          .collection(_collectionName)
          .doc(id)
          .get();

      if (doc.exists) {
        return TaskModel.fromMap(doc.data() as Map<String, dynamic>);
      }
      return null;
    } catch (e) {
      throw Exception('Error retrieving data: $e');
    }
  }

  // Retrieve all documents
  static Future<List<TaskModel>> getAllTaskData() async {
    try {
      QuerySnapshot snapshot = await _db.collection(_collectionName).get();

      return snapshot.docs
          .map((doc) => TaskModel.fromMap(doc.data() as Map<String, dynamic>))
          .where((doc) => doc.status == true)
          .toList();
    } catch (e) {
      throw Exception('Error retrieving all data: $e');
    }
  }

  // Retrieve documents with a query
  static Future<List<TaskModel>> getTaskDataWhere({
    required String field,
    required dynamic isEqualTo,
  }) async {
    try {
      QuerySnapshot snapshot = await _db
          .collection(_collectionName)
          .where(field, isEqualTo: isEqualTo)
          .get();

      return snapshot.docs
          .map((doc) => TaskModel.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Error querying data: $e');
    }
  }

  // Update a document
  static Future<void> updateTaskData(
    String id,
    Map<String, dynamic> data,
  ) async {
    try {
      await _db.collection(_collectionName).doc(id).update(data);
    } catch (e) {
      throw Exception('Error updating data: $e');
    }
  }

  // Delete a document
  static Future<void> deleteTaskData(String id) async {
    try {
      await _db.collection(_collectionName).doc(id).delete();
    } catch (e) {
      throw Exception('Error deleting data: $e');
    }
  }

  // Stream for real-time updates (all documents)
  static Stream<List<TaskModel>> streamAllData() {
    return _db.collection(_collectionName).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => TaskModel.fromMap(doc.data())).toList();
    });
  }

  // Stream for real-time updates (single document)
  static Stream<TaskModel?> streamData(String id) {
    return _db.collection(_collectionName).doc(id).snapshots().map((doc) {
      if (doc.exists) {
        return TaskModel.fromMap(doc.data() as Map<String, dynamic>);
      }
      return null;
    });
  }
}
