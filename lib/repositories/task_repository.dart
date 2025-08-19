import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../models/task.dart';

abstract class ITaskRepository {
  Future<List<Task>> getAllTasks();
  Future<void> saveTasks(List<Task> tasks);
  Future<void> addTask(Task task);
  Future<void> updateTask(Task task);
  Future<void> deleteTask(String taskId);
}

class TaskRepository implements ITaskRepository {
  static const String _fileName = 'tasks.json';

  Future<File> _getFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/$_fileName');
  }

  @override
  Future<List<Task>> getAllTasks() async {
    try {
      final file = await _getFile();
      if (!await file.exists()) {
        return [];
      }

      final jsonString = await file.readAsString();
      final jsonList = jsonDecode(jsonString) as List;

      return jsonList
          .map((json) => Task.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      // Em caso de erro, retorna lista vazia
      return [];
    }
  }

  @override
  Future<void> saveTasks(List<Task> tasks) async {
    try {
      final file = await _getFile();
      final jsonList = tasks.map((task) => task.toJson()).toList();
      final jsonString = jsonEncode(jsonList);
      await file.writeAsString(jsonString);
    } catch (e) {
      throw Exception('Erro ao salvar tarefas: $e');
    }
  }

  @override
  Future<void> addTask(Task task) async {
    final tasks = await getAllTasks();
    tasks.add(task);
    await saveTasks(tasks);
  }

  @override
  Future<void> updateTask(Task task) async {
    final tasks = await getAllTasks();
    final index = tasks.indexWhere((t) => t.id == task.id);

    if (index != -1) {
      tasks[index] = task;
      await saveTasks(tasks);
    }
  }

  @override
  Future<void> deleteTask(String taskId) async {
    final tasks = await getAllTasks();
    tasks.removeWhere((task) => task.id == taskId);
    await saveTasks(tasks);
  }
}
