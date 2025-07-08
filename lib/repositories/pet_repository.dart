import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/pet.dart';

class PetRepository {
  static const String apiUrl = 'https://686cc56614219674dcc90eb1.mockapi.io/pets/pet'; // Replace with your own if needed

  Future<List<Pet>> fetchPets({String? searchQuery, int offset = 0, int limit = 6}) async {
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        List<Pet> pets = data.map((json) => Pet.fromJson(json)).toList();
        if (searchQuery != null && searchQuery.isNotEmpty) {
          pets = pets.where((pet) => pet.name.toLowerCase().contains(searchQuery.toLowerCase())).toList();
        }
        // Ignore offset/limit for demo, just return all pets
        return pets;
      }
    } catch (e) {
      
    }
    // If all else fails, return empty list
    return [];
  }
} 