part of 'pet_list_bloc.dart';

abstract class PetListState extends Equatable {
  const PetListState();

  @override
  List<Object?> get props => [];
}

class PetListLoading extends PetListState {}

class PetListLoaded extends PetListState {
  final List<Pet> pets;
  const PetListLoaded(this.pets);

  @override
  List<Object?> get props => [pets];
}

class PetListError extends PetListState {
  final String message;
  const PetListError(this.message);

  @override
  List<Object?> get props => [message];
}

class PetListLoadingMore extends PetListLoaded {
  const PetListLoadingMore(super.pets);
} 