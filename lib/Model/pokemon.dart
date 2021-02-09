class Pokemon {
  final int idNumber;
  final String name;
  final String fileName;
  int caught;

  Pokemon({this.idNumber, this.name, this.fileName, this.caught});

  //Converts a Pokemon into a Map to be saved in the database
  Map<String, dynamic> toMap() {
    return {
      '_id': idNumber,
      'name': name,
      'file_name': fileName,
      'caught': caught,
    };
  }

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    final pokemon = Pokemon(
        name: json['name'],
        idNumber: json['id'],
        fileName: json['sprites']['front_shiny'],
        caught: 0);
    return pokemon;
  }

  changeCaught() {
    caught = caught == 0 ? 1 : 0;
  }
}
