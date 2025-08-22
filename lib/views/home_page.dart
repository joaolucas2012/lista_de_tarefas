import 'package:flutter/material.dart';
import 'package:lista_de_tarefas/config/app_config.dart';
import 'package:lista_de_tarefas/models/task.dart';
import 'package:lista_de_tarefas/widgets/add_task_widget.dart';
import 'package:lista_de_tarefas/widgets/task_list_item.dart';
import 'package:lista_de_tarefas/widgets/task_stats_widget.dart';
import 'package:provider/provider.dart';
import '../controllers/task_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    // Carrega as tarefas quando a página é inicializada
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TaskController>().loadTasks();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: const Text(
        AppConfig.appTitle,
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
      ),
      backgroundColor: Colors.blue[600],
      elevation: 0,
      centerTitle: true,
      actions: [
        Consumer<TaskController>(
          builder: (context, controller, child) {
            return IconButton(
              icon: const Icon(Icons.refresh, color: Colors.white),
              onPressed: controller.isLoading
                  ? null
                  : () {
                      controller.refreshTasks();
                    },
              tooltip: 'Atualizar',
            );
          },
        ),
      ],
    );
  }

  Widget _buildBody() {
    return Consumer<TaskController>(
      builder: (context, controller, child) {
        return Column(
          children: [
            // Widget de estatísticas
            if (controller.totalTasksCount > 0)
              Padding(
                padding: const EdgeInsets.all(16),
                child: TaskStatsWidget(
                  totalTasks: controller.totalTasksCount,
                  completedTasks: controller.completedTasksCount,
                ),
              ),

            // Widget para adicionar tarefas
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: AddTaskWidget(
                onAddTask: (title) => controller.addTask(title),
                isLoading: controller.isLoading,
              ),
            ),

            const SizedBox(height: 16),

            // Lista de tarefas
            Expanded(child: _buildTaskList(controller)),
          ],
        );
      },
    );
  }

  Widget _buildTaskList(TaskController controller) {
    if (controller.isLoading && controller.tasks.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text(
              AppConfig.loadingText,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      );
    }

    if (controller.tasks.isEmpty) {
      return _buildEmptyState();
    }

    return RefreshIndicator(
      onRefresh: () => controller.refreshTasks(),
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: controller.tasks.length,
        itemBuilder: (context, index) {
          final task = controller.tasks[index];
          return TaskListItem(
            task: task,
            onToggle: () => controller.toggleTaskCompletion(task.id),
            onDelete: () => controller.deleteTask(task.id),
            onShowDeleteConfirmation: () {
              _showDeleteConfirmation(context, controller, task);
            },
          );
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.task_alt, size: 80, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            AppConfig.emptyStateTitle,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            AppConfig.emptyStateSubtitle,
            style: TextStyle(fontSize: 14, color: Colors.grey[500]),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmation(
    BuildContext context,
    TaskController controller,
    Task task,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(AppConfig.deleteConfirmationTitle),
          content: Text(
            '${AppConfig.deleteConfirmationMessage} "${task.title}"?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(AppConfig.cancelButton),
            ),
            TextButton(
              onPressed: () {
                controller.deleteTask(task.id);
                Navigator.of(context).pop();
                _showSnackBar(context, AppConfig.taskDeletedMessage);
              },
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: const Text(AppConfig.deleteButton),
            ),
          ],
        );
      },
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green[600],
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}
