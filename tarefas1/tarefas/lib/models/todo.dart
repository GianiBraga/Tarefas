
class Todo{
  //Construtor da classe Todo
  Todo({required this.title, required this.dateTime});

  //Atributos da classe
  String title;
  DateTime dateTime;

  //Construtor nomeado para criar uma instância
  // de Todo a partir de um mapa JSON
  Todo.fromJson(Map<String, dynamic> json)
    : title = json['title'],
      dateTime = DateTime.parse(json['date']);

  // Método toJson para converter instância em um mapa
  Map<String, dynamic> toJson(){
    return {
      'title': title,
      'date': dateTime.toIso8601String(),
    };
  }

}