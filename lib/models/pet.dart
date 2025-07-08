import 'package:equatable/equatable.dart';

class Pet extends Equatable {
  final String id;
  final String name;
  final int age;
  final double price;
  final String imageUrl;
  final bool isAdopted;
  final bool isFavorite;
  final String? breed;
  final String? genderAge;

  const Pet({
    required this.id,
    required this.name,
    required this.age,
    required this.price,
    required this.imageUrl,
    this.isAdopted = false,
    this.isFavorite = false,
    this.breed,
    this.genderAge,
  });

  Pet copyWith({
    String? id,
    String? name,
    int? age,
    double? price,
    String? imageUrl,
    bool? isAdopted,
    bool? isFavorite,
    String? breed,
    String? genderAge,
  }) {
    return Pet(
      id: id ?? this.id,
      name: name ?? this.name,
      age: age ?? this.age,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      isAdopted: isAdopted ?? this.isAdopted,
      isFavorite: isFavorite ?? this.isFavorite,
      breed: breed ?? this.breed,
      genderAge: genderAge ?? this.genderAge,
    );
  }

  factory Pet.fromJson(Map<String, dynamic> json) {
    return Pet(
      id: json['id'] as String,
      name: json['name'] as String,
      age: json['age'] as int,
      price: (json['price'] as num).toDouble(),
      imageUrl: json['imageUrl'] as String,
      isAdopted: json['isAdopted'] ?? false,
      isFavorite: json['isFavorite'] ?? false,
      breed: json['breed'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'age': age,
      'price': price,
      'imageUrl': imageUrl,
      'isAdopted': isAdopted,
      'isFavorite': isFavorite,
      'breed': breed,

    };
  }

  @override
  List<Object?> get props => [id, name, age, price, imageUrl, isAdopted, isFavorite, breed];
}

// Mock data
