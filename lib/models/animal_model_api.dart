class AnimalModelApi {
  final int id;
  final String name;
  final int shelterID;
  final int petTypeID;
  final List<String> pictures;
  final bool adopted;
  final bool isNeutered;
  final int genusID;
  final String gender;
  final String age;
  final String createdAt;
  final String updatedAt;
  final PetType? type;
  final Genus? genus;
  final bool adoption;
  final bool feed;

  AnimalModelApi({
    required this.id,
    required this.name,
    required this.shelterID,
    required this.petTypeID,
    required this.pictures,
    required this.adopted,
    required this.isNeutered,
    required this.genusID,
    required this.gender,
    required this.age,
    required this.createdAt,
    required this.updatedAt,
     this.type,
     this.genus,
    required this.adoption,
    required this.feed,
  });

  factory AnimalModelApi.fromJson(Map<String, dynamic> json) {
    return AnimalModelApi(
      id: json['id'],
      name: json['name'],
      shelterID: json['shelterID'],
      petTypeID: json['pettypeID'],
      pictures: List<String>.from(json['pictures']),
      adopted: json['adopted'],
      isNeutered: json['kisirlik'],
      genusID: json['genusID'],
      gender: json['gender'],
      age: json['age'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      type: json['type'] != null ? PetType.fromJson(json['type']) : null, // Nullable kontrol
      genus: json['genus'] != null ? Genus.fromJson(json['genus']) : null, // Nullable kontrol
      adoption: json['adoption'],
      feed: json['feed'],
    );
  }
}

class PetType {
  final int id;
  final String name;

  PetType({required this.id, required this.name});

  factory PetType.fromJson(Map<String, dynamic> json) {
    return PetType(
      id: json['id'],
      name: json['name'],
    );
  }
}

class Genus {
  final int id;
  final String name;
  final int petTypeID;

  Genus({required this.id, required this.name, required this.petTypeID});

  factory Genus.fromJson(Map<String, dynamic> json) {
    return Genus(
      id: json['id'],
      name: json['name'],
      petTypeID: json['petTypeID'],
    );
  }
}
