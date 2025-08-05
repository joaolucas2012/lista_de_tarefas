import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lista_de_tarefas/shared/types.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de tarefas',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _todoController = TextEditingController();

  MapList _todoList = [];
  DynamicMap _lastRemoved = {};
  int _lastRemovedIndex = -1;

  @override
  void initState() {
    super.initState();
    _readData().then((data) {
      setState(() => _todoList = data);
    });
  }

  void _addTask() {
    setState(() {
      DynamicMap newTask = {};
      newTask["title"] = _todoController.text;
      newTask["done"] = false;
      _todoController.text = "";
      _todoList.add(newTask);
      _saveData();
    });
  }

  Future<void> _refresh() async {
    await Future.delayed(Duration(milliseconds: 400));
    setState(() {
      _todoList.sort((a, b) {
        if (a["done"] && !b["done"]) return 1;
        if (!a["done"] && b["done"]) return -1;
        return 0;
      });

      _saveData();
    });
  }

  Future<File> _getFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File("${directory.path}/data.json");
  }

  Future<void> _saveData() async {
    String data = jsonEncode(_todoList);
    File json = await _getFile();
    await json.writeAsString(data);
  }

  Future<MapList> _readData() async {
    try {
      File json = await _getFile();
      String data = await json.readAsString();
      return MapList.from(jsonDecode(data) as List);
    } catch (e) {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Lista de tarefas',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(17, 1, 7, 1),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _todoController,
                    decoration: InputDecoration(
                      labelText: "Nova tarefa",
                      labelStyle: TextStyle(color: Colors.blueAccent),
                    ),
                  ),
                ),
                SizedBox(width: 15),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.blueAccent),
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                  onPressed: _addTask,
                  child: Text(
                    "Nova",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: _refresh,
              child: ListView.builder(
                padding: EdgeInsets.only(top: 10),
                itemCount: _todoList.length,
                itemBuilder: buildItem,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildItem(BuildContext context, int index) {
    DynamicMap item = _todoList[index];
    return Dismissible(
      key: Key(DateTime.now().millisecondsSinceEpoch.toString()),
      direction: DismissDirection.startToEnd,
      background: Container(
        color: Colors.red,
        child: Align(
          alignment: Alignment(-0.9, 0.0),
          child: Icon(Icons.delete, color: Colors.white),
        ),
      ),
      onDismissed: (direction) {
        setState(() {
          _lastRemoved = DynamicMap.from(_todoList[index]);
          _lastRemovedIndex = index;
          _todoList.removeAt(index);
          _saveData();

          final snackBar = SnackBar(
            content: Text('Tarefa "${_lastRemoved["title"]}" removida!'),
            duration: Duration(seconds: 4),
            action: SnackBarAction(
              label: "Desfazer",

              onPressed: () {
                setState(() {
                  _todoList.insert(_lastRemovedIndex, _lastRemoved);
                  _saveData();
                });
              },
            ),
          );

          ScaffoldMessenger.of(context).removeCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        });
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 5),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
        child: CheckboxListTile(
          activeColor: Colors.blueAccent,
          title: Text(
            item["title"],
            style: TextStyle(overflow: TextOverflow.ellipsis),
          ),
          tileColor: Colors.grey[200],
          value: item["done"],
          secondary: CircleAvatar(
            backgroundColor: !item["done"]
                ? Colors.orangeAccent
                : Colors.blueAccent,
            child: Icon(
              item["done"] ? Icons.check : Icons.error,
              color: Colors.white,
            ),
          ),
          onChanged: (value) => setState(() {
            item["done"] = value;
            _saveData();
          }),
        ),
      ),
    );
  }
}
