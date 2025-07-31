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
  final MapList _todoList = [];

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
        title: const Text('Lista de tarefas'),
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
                  onPressed: () {},
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
            child: ListView.builder(
              padding: EdgeInsets.only(top: 10),
              itemCount: _todoList.length,
              itemBuilder: (context, index) {
                DynamicMap item = _todoList[index];
                return CheckboxListTile(
                  title: Text(item["title"]),
                  value: item["done"],
                  secondary: CircleAvatar(
                    child: Icon(item["done"] ? Icons.check : Icons.error),
                  ),
                  onChanged: (value) => setState(() {
                    item["done"] = value;
                  }),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
