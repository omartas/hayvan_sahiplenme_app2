class Municipality {
  final int id;
  final int cityID;
  final int districtID;
  final String name;
  final String email;
  final String phoneNumber;
  final String? logo;
  final bool isApproved;
  final String subMerchantKey;
  final String iyzicoExternalID;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<Shelter> shelters;
  final City city;
  final District district;

  Municipality({
    required this.id,
    required this.cityID,
    required this.districtID,
    required this.name,
    required this.email,
    required this.phoneNumber,
    this.logo,
    required this.isApproved,
    required this.subMerchantKey,
    required this.iyzicoExternalID,
    required this.createdAt,
    required this.updatedAt,
    required this.shelters,
    required this.city,
    required this.district,
  });

  factory Municipality.fromJson(Map<String, dynamic> json) {
    return Municipality(
      id: json['id'],
      cityID: json['cityID'],
      districtID: json['districtID'],
      name: json['name'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      logo: json['logo'],
      isApproved: json['isApproved'],
      subMerchantKey: json['subMerchantKey'],
      iyzicoExternalID: json['iyzicoExternalID'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      shelters: (json['shelters'] as List)
          .map((shelterJson) => Shelter.fromJson(shelterJson))
          .toList(),
      city: City.fromJson(json['city']),
      district: District.fromJson(json['district']),
    );
  }
}

class Shelter {
  final int id;
  final String address;
  final String? image;
  final String phoneNumber;
  final int municipalityID;
  final String name;
  final DateTime createdAt;
  final DateTime updatedAt;

  Shelter({
    required this.id,
    required this.address,
    this.image,
    required this.phoneNumber,
    required this.municipalityID,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Shelter.fromJson(Map<String, dynamic> json) {
    return Shelter(
      id: json['id'],
      address: json['address'],
      image: json['image'],
      phoneNumber: json['phoneNumber'],
      municipalityID: json['municipalityID'],
      name: json['name'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}

class City {
  final int id;
  final String name;

  City({
    required this.id,
    required this.name,
  });

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      id: json['id'],
      name: json['name'],
    );
  }
}

class District {
  final int id;
  final String name;
  final int cityID;

  District({
    required this.id,
    required this.name,
    required this.cityID,
  });

  factory District.fromJson(Map<String, dynamic> json) {
    return District(
      id: json['id'],
      name: json['name'],
      cityID: json['cityID'],
    );
  }
}
