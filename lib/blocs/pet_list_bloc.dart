import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../models/pet.dart';
import '../repositories/pet_repository.dart';

part 'pet_list_event.dart';
part 'pet_list_state.dart';

class PetListBloc extends Bloc<PetListEvent, PetListState> {
  final PetRepository petRepository;
  static const int _pageSize = 6;
  int _offset = 0;
  String? _searchQuery;
  List<Pet> _loadedPets = [];

  PetListBloc({required this.petRepository}) : super(PetListLoading()) {
    on<FetchPets>(_onFetchPets);
    on<SearchPets>(_onSearchPets);
    on<LoadMorePets>(_onLoadMorePets);
  }

  Future<void> _onFetchPets(FetchPets event, Emitter<PetListState> emit) async {
    emit(PetListLoading());
    _offset = 0;
    _searchQuery = null;
    _loadedPets = [];
    try {
      final pets = await petRepository.fetchPets(offset: _offset, limit: _pageSize);
      _loadedPets = pets;
      _offset = pets.length;
      emit(PetListLoaded(_loadedPets));
    } catch (e) {
      emit(PetListError('Failed to load pets'));
    }
  }

  Future<void> _onSearchPets(SearchPets event, Emitter<PetListState> emit) async {
    emit(PetListLoading());
    _offset = 0;
    _searchQuery = event.query;
    _loadedPets = [];
    try {
      final pets = await petRepository.fetchPets(searchQuery: _searchQuery, offset: _offset, limit: _pageSize);
      _loadedPets = pets;
      _offset = pets.length;
      emit(PetListLoaded(_loadedPets));
    } catch (e) {
      emit(PetListError('Failed to search pets'));
    }
  }

  Future<void> _onLoadMorePets(LoadMorePets event, Emitter<PetListState> emit) async {
    if (state is PetListLoaded || state is PetListLoadingMore) {
      emit(PetListLoadingMore(_loadedPets));
      try {
        final pets = await petRepository.fetchPets(searchQuery: _searchQuery, offset: _offset, limit: _pageSize);
        if (pets.isNotEmpty) {
          _loadedPets = List<Pet>.from(_loadedPets)..addAll(pets);
          _offset += pets.length;
        }
        emit(PetListLoaded(_loadedPets));
      } catch (e) {
        emit(PetListError('Failed to load more pets'));
      }
    }
  }
} 