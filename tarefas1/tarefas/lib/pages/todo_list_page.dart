import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tarefas/models/todo.dart';
import 'package:tarefas/repositories/todo_repository.dart';
import 'package:tarefas/widgets/todo_list_item.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({super.key});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  // Controller para o campo de texto onde o usuário
  // vai inserir a nova tarefa
  final TextEditingController todoControler = TextEditingController();

  // Instância do repositório da persistência dos dados
  final TodoRepository todoRepository = TodoRepository();

  // Listar todas as tarefas
  List<Todo> todos = [];

  // Variáveis usadas para rastrear a tarefa
  // que foi deletada temporariamente
  Todo? deletedTodo;
  int? deletedTodoPos;

  // Texto de erro exibido se o campo
  // estiver vazio
  String? errorText;

  // Carregar a lista de tarefas quando abre o app
  @override
  void initState() {
    super.initState();
    todoRepository.getTodoList().then((value) => {
          setState(() {
            todos = value;
          })
        });
  }

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
                        controller: todoControler, //
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Adicionar uma nova tarefa',
                            hintText: 'Ex. Estudar...',
                            errorText: errorText, //
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
                      onPressed: () {
                        String text = todoControler.text;

                        if (text.isEmpty) {
                          setState(() {
                            errorText = 'O campo não pode ser vazio!';
                          });
                          return;
                        }
                        // Função para adicionar nova tarefa
                        setState(() {
                          Todo newTodo = Todo(
                            title: text,
                            dateTime: DateTime.now(),
                          );
                          todos.add(newTodo);
                          errorText = null;
                        });
                        todoControler.clear();
                        todoRepository.saveTodoList(todos);
                      },
                      child: Icon(
                        Icons.add,
                        size: 35,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                // Lugar da
                Flexible(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      for (Todo todo in todos)
                        TodoListItem(
                          todo: todo,
                          onDelete: onDelete,
                        )
                    ],
                  ),
                ),

                //--------------
                // Novas informações
                // Texto contendo a quantidade de tarefas
                // botão com o icone de lixeira
                Row(children: [
                  // Texto que mostra a quantidade de tarefas
                  Text(
                    'Você tem ${todos.length} tarefas adicionadas',
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
                    onPressed: showDeleteTodoConfirmationDialog,
                  ),
                ]),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // função pra deletar uma tarefa
  void onDelete(Todo todo) {
    deletedTodo = todo;
    deletedTodoPos = todos.indexOf(todo);
    setState(() {
      todos.remove(todo);
    });
    todoRepository.saveTodoList(todos);
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Tarefa ${todo.title} foi removida com sucesso!',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        action: SnackBarAction(
          label: 'Desfazer',
          textColor: Colors.purple,
          onPressed: () {
            setState(() {
              todos.insert(deletedTodoPos!, deletedTodo!);
            });
            todoRepository.saveTodoList(todos);
          },
        ),
        duration: const Duration(seconds: 5),
      ),
    );
  }

// Função para exibir um diálago de confirmação para limpar
// as tarefas
  void showDeleteTodoConfirmationDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Limpar Tudo?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              'Cancelar',
              style: TextStyle(color: Colors.white),
            ),
            style: TextButton.styleFrom(
              backgroundColor: Colors.purple,
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              deleteAllTodo();
            },
            child: Text(
              'Limpar Tudo.',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            style: TextButton.styleFrom(
              backgroundColor: Colors.purple,
            ),
          ),
        ],
      ),
    );
  }

  // função pra deletar todas tarefas
  void deleteAllTodo(){
    setState(() {
      todos.clear();
    });
    todoRepository.saveTodoList(todos);
  }

}
