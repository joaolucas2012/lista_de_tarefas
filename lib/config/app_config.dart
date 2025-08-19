class AppConfig {
  // Cores do tema
  static const primaryColor = 0xFF2196F3; // Azul
  static const secondaryColor = 0xFF4CAF50; // Verde
  static const accentColor = 0xFFFF9800; // Laranja
  static const errorColor = 0xFFF44336; // Vermelho

  // Textos da aplicação
  static const appTitle = 'Lista de Tarefas';
  static const addTaskTitle = 'Nova Tarefa';
  static const addTaskHint = 'Digite o título da tarefa...';
  static const addTaskButton = 'Adicionar Tarefa';
  static const addTaskButtonLoading = 'Adicionando...';
  static const emptyStateTitle = 'Nenhuma tarefa encontrada';
  static const emptyStateSubtitle = 'Adicione sua primeira tarefa acima!';
  static const loadingText = 'Carregando tarefas...';
  static const deleteConfirmationTitle = 'Confirmar exclusão';
  static const deleteConfirmationMessage =
      'Tem certeza que deseja excluir a tarefa';
  static const cancelButton = 'Cancelar';
  static const deleteButton = 'Excluir';
  static const taskDeletedMessage = 'Tarefa excluída com sucesso!';

  // Validações
  static const emptyTaskError = 'O título da tarefa não pode estar vazio';
  static const validationError = 'Por favor, digite o título da tarefa';

  // Estatísticas
  static const totalLabel = 'Total';
  static const completedLabel = 'Concluídas';
  static const pendingLabel = 'Pendentes';
  static const progressLabel = 'Progresso';
  static const completedPercentage = '% concluído';

  // Formatação de data
  static const todayText = 'hoje às';
  static const yesterdayText = 'ontem às';
  static const daysAgoText = 'há';
  static const daysText = 'dias';
  static const createdText = 'Criada em';
  static const completedText = 'Concluída em';

  // Animações
  static const refreshDelay = Duration(milliseconds: 400);

  // Dimensões
  static const defaultPadding = 16.0;
  static const smallPadding = 8.0;
  static const borderRadius = 12.0;
  static const iconSize = 24.0;
  static const largeIconSize = 80.0;
}
