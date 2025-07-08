part of 'pet_list_bloc.dart';

abstract class PetListEvent extends Equatable {
  const PetListEvent();

  @override
  List<Object?> get props => [];
}

class FetchPets extends PetListEvent {}

class SearchPets extends PetListEvent {
  final String query;
  const SearchPets(this.query);

  @override
  List<Object?> get props => [query];
}

class LoadMorePets extends PetListEvent {} 