import 'package:flutter/material.dart';
import 'package:splash_sing_in_up_app/models/task_model.dart';
import 'package:splash_sing_in_up_app/newtork_repos/remote_repo/firestore_services/task_firestore_services.dart';

import '../newtork_repos/remote_repo/firestore_services/user_firestore_services.dart';

class TaskProvider with ChangeNotifier {
  List<TaskModel> _tasks = [];
  bool _isLoading = false;
  String? _error;

  List<TaskModel> get tasks => _tasks;
  bool get isLoading => _isLoading;
  String? get error => _error;

  //add new task
  Future<void> addTask(TaskModel task) async {
    _setLoading(true);
    try {
      String id = await TaskFirestoreServices.addTaskData(task);
      _tasks.add(task.copyWith(id: id));
      _error = null;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    } finally {
      _setLoading(false);
    }
  }

  // Fetch all tasks
  Future<void> fetchTasks() async {
    _setLoading(true);
    try {
      _tasks = await TaskFirestoreServices.getAllTaskData();
      _error = null;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    } finally {
      _setLoading(false);
    }
  }

  // Update a task
  Future<void> updateTask(String id, Map<String, dynamic> data) async {
    _setLoading(true);
    try {
      await TaskFirestoreServices.updateTaskData(id, data);

      // Update local list
      int index = _tasks.indexWhere((task) => task.id == id);
      if (index != -1) {
        _tasks[index] = _tasks[index].copyWith(
          status: data['status'] ?? _tasks[index].status,
          assignedTo: data['assignedTo'] ?? _tasks[index].assignedTo,
          updatedAt: data['updatedAt'] ?? _tasks[index].updatedAt,
          notes: data['notes'] ?? _tasks[index].notes,
        );
      }

      _error = null;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    } finally {
      _setLoading(false);
    }
  }

  // Delete a task
  Future<void> deleteTask(String id) async {
    _setLoading(true);
    try {
      await UserFirestoreServices.deleteData(id);
      _tasks.removeWhere((task) => task.id == id);
      _error = null;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    } finally {
      _setLoading(false);
    }
  }

  // Listen to real-time updates
  void listenToTasks() {
    TaskFirestoreServices.streamAllData().listen(
      (tasks) {
        _tasks = tasks;
        _error = null;
        notifyListeners();
      },
      onError: (e) {
        _error = e.toString();
        notifyListeners();
      },
    );
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}
