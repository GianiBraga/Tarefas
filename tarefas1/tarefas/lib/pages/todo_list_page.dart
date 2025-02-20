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
                              ),
                            )),
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    // Botão de adicionar nova tarefa.
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple,
                        padding: EdgeInsets.all(10),
                      ),
                      onPressed: () {},
                      child: Icon(
                        Icons.add,
                        size: 35,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                // Novas informações
                // Texto contendo a quantidade de tarefas
                // botão com o icone de lixeira
                Row(children: [
                  // Texto que mostra a quantidade de tarefas
                  Text(
                    'Você tem 0 tarefas adicionadas',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 40),
                  // Botão de lixeira
                  IconButton(
                    icon: Icon(
                      Icons.delete_sweep,
                      color: Colors.purple,
                      size: 30,
                    ),
                    onPressed: () {},
                  ),
                ]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
