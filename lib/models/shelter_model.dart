class ShelterModel {
  String id;
  String name;
  String address;

  ShelterModel({required this.id, required this.name, required this.address});

  factory ShelterModel.fromMap(Map<String, dynamic> map) {
    return ShelterModel(
      id: map['id'],
      name: map['name'],
      address: map['address'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'address': address,
    };
  }
}
  