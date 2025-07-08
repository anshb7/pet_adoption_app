import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class AdoptionCubit extends Cubit<Map<String, DateTime>> {
  static const _adoptedKey = 'adopted_pet_dates';

  AdoptionCubit() : super({}) {
    _loadAdoptedPets();
  }

  Future<void> _loadAdoptedPets() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_adoptedKey);
    if (jsonString != null) {
      final Map<String, dynamic> map = json.decode(jsonString);
      final result = <String, DateTime>{};
      map.forEach((key, value) {
        result[key] = DateTime.parse(value as String);
      });
      emit(result);
    } else {
      // Migrate from old Set<String> if present
      final oldIds = prefs.getStringList('adopted_pet_ids');
      if (oldIds != null) {
        final now = DateTime.now();
        final migrated = {for (var id in oldIds) id: now};
        emit(migrated);
        await prefs.setString(_adoptedKey, json.encode({for (var e in migrated.entries) e.key: e.value.toIso8601String()}));
        await prefs.remove('adopted_pet_ids');
      } else {
        emit({});
      }
    }
  }

  Future<void> adoptPet(String petId) async {
    final updated = Map<String, DateTime>.from(state);
    updated[petId] = DateTime.now();
    emit(updated);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_adoptedKey, json.encode({for (var e in updated.entries) e.key: e.value.toIso8601String()}));
  }

  bool isAdopted(String petId) => state.containsKey(petId);
} 