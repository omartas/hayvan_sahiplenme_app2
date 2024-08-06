
import 'package:cloud_firestore/cloud_firestore.dart';

class AnimalModel {
  final String id;
  final String type;
  final String breed;
  final String gender;
  final bool isNeutered;
  final String status;
  final int age;
  final Timestamp date;

  AnimalModel( {
    required this.date,
    required this.id,
    required this.type,
    required this.breed,
    required this.gender,
    required this.isNeutered,
    required this.status,
    required this.age,
  });

  factory AnimalModel.fromMap(Map<String, dynamic> map) {
    return AnimalModel(

      id: map['id'] ?? '',
      type: map['type'] ?? '',
      breed: map['breed'] ?? '',
      gender: map['gender'] ?? '',
      isNeutered: map['isNeutered'] ?? false,
      status: map['status'] ?? '',
      age: map['age']?.toInt() ?? 0, 
      date: map["date"]?? Timestamp(2, 2), 
    );
  }
}
