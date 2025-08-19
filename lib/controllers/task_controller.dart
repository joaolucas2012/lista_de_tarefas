import 'package:flutter/foundation.dart';
import '../models/task.dart';
import '../services/task_service.dart';
import '../config/app_config.dart';

class TaskController extends ChangeNotifier {
  final ITaskService _taskService;

  List<Task> _tasks = [];
  bool _isLoading = false;
  String? _errorMessage;

  TaskController({ITaskService? taskService})
    : _taskService = taskService ?? TaskService();

  // Getters
  List<Task> get tasks => _tasks;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  int get completedTasksCount =>
      _tasks.where((task) => task.isCompleted).length;
  int get totalTasksCount => _tasks.length;

  // Métodos públicos
  Future<void> loadTasks() async {
    _setLoading(true);
    _clearError();

    try {
      final tasks = await _taskService.getAllTasks();
      _tasks = _taskService.sortTasks(tasks);
      notifyListeners();
    } catch (e) {
      _setError('Erro ao carregar tarefas: $e');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> addTask(String title) async {
    if (title.trim().isEmpty) {
      _setError(AppConfig.emptyTaskError);
      return;
    }

    _setLoading(true);
    _clearError();

    try {
      await _taskService.addTask(title);
      await loadTasks(); // Recarrega a lista para mostrar a nova tarefa
    } catch (e) {
      _setError('Erro ao adicionar tarefa: $e');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> toggleTaskCompletion(String taskId) async {
    _clearError();

    try {
      await _taskService.toggleTaskCompletion(taskId);
      await loadTasks(); // Recarrega a lista para atualizar o estado
    } catch (e) {
      _setError('Erro ao atualizar tarefa: $e');
    }
  }

  Future<void> deleteTask(String taskId) async {
    _clearError();

    try {
      await _taskService.deleteTask(taskId);
      await loadTasks(); // Recarrega a lista para remover a tarefa
    } catch (e) {
      _setError('Erro ao deletar tarefa: $e');
    }
  }

  Future<void> refreshTasks() async {
    await loadTasks();
  }

  void clearError() {
    _clearError();
  }

  // Métodos privados
  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String message) {
    _errorMessage = message;
    notifyListeners();
  }

  void _clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
