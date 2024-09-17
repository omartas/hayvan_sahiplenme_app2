class City {
  final String name;
  final int id;
  final List<District> districts;

  City({required this.name, required this.id, required this.districts});

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      name: json['name'],
      id: json['id'],
      districts: List<District>.from(json['districts'].map((x) => District.fromJson(x))),
    );
  }
}

class District {
  final String name;
  final int id;

  District({required this.name, required this.id});

  factory District.fromJson(Map<String, dynamic> json) {
    return District(
      name: json['name'],
      id: json['id'],
    );
  }
}
