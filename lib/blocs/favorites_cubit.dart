import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesCubit extends Cubit<Set<String>> {
  static const _favoritesKey = 'favorite_pet_ids';

  FavoritesCubit() : super({}) {
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final ids = prefs.getStringList(_favoritesKey) ?? [];
    emit(ids.toSet());
  }

  Future<void> toggleFavorite(String petId) async {
    final updated = Set<String>.from(state);
    if (updated.contains(petId)) {
      updated.remove(petId);
    } else {
      updated.add(petId);
    }
    emit(updated);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_favoritesKey, updated.toList());
  }

  bool isFavorite(String petId) => state.contains(petId);
} 