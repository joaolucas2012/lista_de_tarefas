# 📋 Lista de Tarefas - Flutter App

[![Flutter](https://img.shields.io/badge/Flutter-3.8+-blue.svg)](https://flutter.dev/)
[![Dart](https://img.shields.io/badge/Dart-3.0+-blue.svg)](https://dart.dev/)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

> Um aplicativo moderno e elegante de lista de tarefas desenvolvido em Flutter, seguindo as melhores práticas de arquitetura e design patterns.

## ✨ Características

- 🎨 **Interface moderna e intuitiva** com Material Design 3
- 📱 **Responsivo** para diferentes tamanhos de tela
- 🔄 **Sincronização automática** com armazenamento local
- 📊 **Estatísticas em tempo real** do progresso das tarefas
- 🎯 **Gestos intuitivos** para completar e excluir tarefas
- 🌙 **Tema adaptativo** que se ajusta ao sistema
- ⚡ **Performance otimizada** com gerenciamento de estado eficiente

## 🏗️ Arquitetura

O projeto segue o padrão **MVC (Model-View-Controller)** com implementação de **Clean Architecture** e princípios **SOLID**:

```
lib/
├── 📁 models/          # Entidades e modelos de dados
├── 📁 views/           # Interface do usuário (UI)
├── 📁 controllers/     # Lógica de controle e gerenciamento de estado
├── 📁 services/        # Lógica de negócio
├── 📁 repositories/    # Acesso a dados e persistência
├── 📁 widgets/         # Componentes reutilizáveis
├── 📁 config/          # Configurações e constantes
├── 📁 shared/          # Recursos compartilhados
│   └── 📁 utils/       # Utilitários e helpers
└── main.dart           # Ponto de entrada da aplicação
```

### 🎯 Padrões Implementados

- **MVC (Model-View-Controller)**: Separação clara de responsabilidades
- **Repository Pattern**: Abstração do acesso a dados
- **Service Layer**: Encapsulamento da lógica de negócio
- **Provider Pattern**: Gerenciamento de estado reativo
- **Dependency Injection**: Inversão de dependências
- **Clean Code**: Código limpo e legível

## 🚀 Tecnologias Utilizadas

- **Flutter 3.8+** - Framework de desenvolvimento
- **Dart 3.0+** - Linguagem de programação
- **Provider** - Gerenciamento de estado
- **Path Provider** - Acesso ao sistema de arquivos
- **Material Design 3** - Design system

## 📱 Funcionalidades

### ✅ Gerenciamento de Tarefas

- Criar novas tarefas
- Marcar tarefas como concluídas
- Excluir tarefas com confirmação
- Editar tarefas existentes

### 📊 Dashboard Inteligente

- Contador de tarefas totais
- Progresso de conclusão
- Estatísticas em tempo real
- Filtros por status

### 🎨 Interface Moderna

- Design responsivo
- Animações suaves
- Gestos intuitivos
- Feedback visual

## 🛠️ Instalação e Execução

### Pré-requisitos

- Flutter SDK 3.8 ou superior
- Dart 3.0 ou superior
- Android Studio / VS Code
- Emulador Android ou dispositivo físico

### Passos para execução

1. **Clone o repositório**

```bash
git clone https://github.com/seu-usuario/lista_de_tarefas.git
cd lista_de_tarefas
```

2. **Instale as dependências**

```bash
flutter pub get
```

3. **Execute o aplicativo**

```bash
flutter run
```

## 📁 Estrutura do Projeto

### 🗂️ Estrutura Principal (lib/)

```
lib/
├── 📁 models/                    # Entidades e modelos de dados
│   └── task.dart                 # Modelo de dados da tarefa
├── 📁 views/                     # Interface do usuário (UI)
│   └── home_page.dart            # Tela principal da aplicação
├── 📁 controllers/               # Lógica de controle e gerenciamento de estado
│   └── task_controller.dart      # Controlador principal
├── 📁 services/                  # Lógica de negócio
│   └── task_service.dart         # Serviços de negócio
├── 📁 repositories/              # Acesso a dados e persistência
│   └── task_repository.dart      # Repositório de dados
├── 📁 widgets/                   # Componentes reutilizáveis
│   ├── add_task_widget.dart      # Widget para adicionar tarefas
│   ├── task_list_item.dart       # Item da lista de tarefas
│   └── task_stats_widget.dart    # Widget de estatísticas
├── 📁 config/                    # Configurações e constantes
│   └── app_config.dart           # Configurações centralizadas
├── 📁 shared/                    # Recursos compartilhados
│   └── 📁 utils/                 # Utilitários e helpers
│       └── date_formatter.dart   # Utilitários de formatação de data
└── main.dart                     # Ponto de entrada da aplicação
```

### 🎨 Estrutura de Assets

```
assets/
├── 📁 icons/                     # Ícones do aplicativo
│   └── icon.png                  # Ícone principal (usado pelo flutter_launcher_icons)
└── logo.svg                      # Logo original do projeto
```

### 📱 Estrutura de Plataformas

```
├── 📁 android/                   # Configurações específicas do Android
├── 📁 ios/                       # Configurações específicas do iOS
├── 📁 web/                       # Configurações específicas da Web
├── 📁 windows/                   # Configurações específicas do Windows
├── 📁 macos/                     # Configurações específicas do macOS
└── 📁 linux/                     # Configurações específicas do Linux
```

### 🔧 Arquivos de Configuração

```
├── pubspec.yaml                  # Dependências e configurações do projeto
├── pubspec.lock                  # Versões fixas das dependências
├── analysis_options.yaml         # Configurações do linter Dart
├── .gitignore                    # Arquivos ignorados pelo Git
└── README.md                     # Documentação do projeto
```

## 🎨 Design System

O aplicativo utiliza um design system consistente baseado no Material Design 3:

- **Cores primárias**: Azul (#2196F3)
- **Cores secundárias**: Verde (#4CAF50) e Laranja (#FF9800)
- **Tipografia**: Roboto (padrão do Material Design)
- **Espaçamento**: Sistema de 8px base
- **Bordas**: Raio de 12px para cards e botões

## 🔧 Configuração

### Variáveis de Ambiente

O aplicativo utiliza configurações centralizadas no arquivo `lib/config/app_config.dart`:

```dart
class AppConfig {
  static const primaryColor = 0xFF2196F3;
  static const appTitle = 'Lista de Tarefas';
  // ... outras configurações
}
```

### Persistência de Dados

Os dados são armazenados localmente usando:

- **Path Provider**: Para acesso ao diretório de documentos
- **JSON**: Formato de armazenamento
- **Async/Await**: Operações assíncronas

### 🎨 Configuração de Ícones

O aplicativo utiliza o pacote `flutter_launcher_icons` para gerar automaticamente ícones para todas as plataformas:

```yaml
flutter_launcher_icons:
  android: "launcher_icon"
  ios: true
  image_path: "assets/icons/icon.png"
  min_sdk_android: 21
  web:
    generate: true
    image_path: "assets/icons/icon.png"
    background_color: "#ffffff"
    theme_color: "#000000"
  windows:
    generate: true
    image_path: "assets/icons/icon.png"
    icon_size: 48
  macos:
    generate: true
    image_path: "assets/icons/icon.png"
```

**Para regenerar os ícones:**

```bash
dart run flutter_launcher_icons
```

## 🧪 Testes

Para executar os testes:

```bash
# Testes unitários
flutter test

# Testes de widget
flutter test test/widget_test.dart
```

## 📦 Build e Deploy

### Android

```bash
flutter build apk --release
```

### iOS

```bash
flutter build ios --release
```

### Web

```bash
flutter build web --release
```

## 🤝 Contribuição

1. Faça um fork do projeto
2. Crie uma branch para sua feature (`git checkout -b feature/AmazingFeature`)
3. Commit suas mudanças (`git commit -m 'Add some AmazingFeature'`)
4. Push para a branch (`git push origin feature/AmazingFeature`)
5. Abra um Pull Request

## 📄 Licença

Este projeto está sob a licença MIT. Veja o arquivo [LICENSE](LICENSE) para mais detalhes.

## 👨‍💻 Autor

**João Lucas Borges Ribeiro**

- GitHub: [@joaolucas2012](https://github.com/joaolucas2012)
- LinkedIn: [João Lucas Borges Ribeiro](https://www.linkedin.com/in/jo%C3%A3o-lucas-ribeiro)
- Email: ribeirojoaolucas68@gmail.com

## 🙏 Agradecimentos

- Flutter Team pelo framework incrível
- Material Design Team pelo design system
- Comunidade Flutter pela documentação e suporte

---

⭐ **Se este projeto te ajudou, considere dar uma estrela!**
