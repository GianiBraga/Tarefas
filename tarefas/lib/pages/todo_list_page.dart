import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({super.key});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    // Campo para entrada de texto
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Adicionar uma nova tarefa',
                          hintText: 'Ex. Estudar...',
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                            color: Colors.purple,
                            width: 2,
                          ),) 
                        ),
                      ),
                    ),
                    // Botão de adicionar nova tarefa.
                    ElevatedButton(
                      onPressed: () {},
                      child: Icon(Icons.add),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
