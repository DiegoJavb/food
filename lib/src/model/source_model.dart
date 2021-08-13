//Definimos el modelo de datos
//para que sea facil hacer un parse a JSON
class Source {
  String? id;
  String? name;

  Source({this.id, this.name});
  //factory function to map the JSON
  factory Source.fromJson(Map<String, dynamic> json) {
    return Source(
      id: json["id"],
      name: json["name"],
    );
  }
}
