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
        name: _processName(json['name']),
        idNumber: json['id'],
        fileName: json['sprites']['front_shiny'],
        caught: 0);
    return pokemon;
  }

  changeCaught() {
    caught = caught == 0 ? 1 : 0;
  }

  set fileName(String newFileName) {
    fileName = newFileName;
  }

  static String _processName(String name) {
    switch (name) {
      case 'ho-oh':
        return 'Ho-oh';
      case 'giratina-altered':
        return 'Giratina';
      case 'tornadus-incarnate':
        return 'Tornadus';
      case 'thundurus-incarnate':
        return 'Thundurus';
      case 'landorus-incarnate':
        return 'Landorus';
      case 'tapu-koko':
        return 'Tapu Koko';
      case 'tapu-lele':
        return 'Tapu Lele';
      case 'tapu-bulu':
        return 'Tapu Bulu';
      case 'tapu-fini':
        return 'Tapu Fini';
      case 'mr-mime':
        return 'Mr. Mime';
      default:
        String newName = name[0].toUpperCase() + name.substring(1);
        if (newName.contains('-')) {
          return newName.substring(0, name.indexOf('-'));
        }
        return newName;
    }
  }
}
