import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:tarefas/models/todo.dart';

const todoListKey = 'todo_list';

class TodoRepository{

  //Chave utilizado para armazenar a lista de tarefas
  // no sharedpreferences
  late SharedPreferences sharedPreferences;

  // Função assíncrona para obter a lista de tarefas do SharedPreferences
  Future<List<Todo>> getTodoList() async{

    // Inicialização do shared
    sharedPreferences = await SharedPreferences.getInstance();

    // Obtém a String Json da lista de tarefas ou lista vazia
    final String jsonString = sharedPreferences.getString(todoListKey) ?? '[]';

    // Decodifica a lista de objetos Json
    final List jsonDecoded = json.decode(jsonString) as List;

    //Mapeia os objetos para uma instância da classe
    return jsonDecoded.map((e) => Todo.fromJson(e)).toList();
  }

  // Função para salvar a lista
  void saveTodoList(List<Todo> todos){
    // Codific a lista de tarefas em uma String Json
    final String jsonString = json.encode(todos);

    // Armazena a string Json com a chave apropriada
    sharedPreferences.setString(todoListKey, jsonString);
  }

}