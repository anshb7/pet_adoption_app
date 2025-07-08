import 'package:flutter/material.dart';
import 'package:pet_adoption_app/widgets/pet_card.dart';
import '../models/pet.dart';
import '../blocs/adoption_cubit.dart';
import '../blocs/favorites_cubit.dart';
import '../blocs/pet_list_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../screens/details_page.dart';
import '../screens/home_page.dart';

class HomeGridWidget extends StatelessWidget {
  final List<Pet> pets;
  final bool isLoadingMore;
  final ScrollController scrollController;

  const HomeGridWidget({
    Key? key,
    required this.pets,
    required this.isLoadingMore,
    required this.scrollController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdoptionCubit, Map<String, DateTime>>(
      builder: (context, adoptedPetIds) {
        return BlocBuilder<FavoritesCubit, Set<String>>(
          builder: (context, favoritePetIds) {
            return RefreshIndicator(
              onRefresh: () async =>
                  context.read<PetListBloc>().add(FetchPets()),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  double width = constraints.maxWidth;
                  double minCardWidth = 220;
                  int crossAxisCount = (width / minCardWidth).floor().clamp(1, 6);
                  double cardWidth = width / crossAxisCount;
                  double cardHeight = cardWidth * 1.25; // 4:5 ratio
                  double childAspectRatio = cardWidth / cardHeight;
                  double gridPadding = width < 600 ? 12 : 24;
                  double spacing = width < 600 ? 12 : 20;

                  return GridView.builder(
                    controller: scrollController,
                    padding: EdgeInsets.all(gridPadding),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      mainAxisSpacing: spacing,
                      crossAxisSpacing: spacing,
                      childAspectRatio: childAspectRatio,
                    ),
                    itemCount: pets.length + (isLoadingMore ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index == pets.length) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      final pet = pets[index];
                      return PetCard(
                        pet: pet,
                        isAdopted: adoptedPetIds.containsKey(pet.id),
                        isFavorite: favoritePetIds.contains(pet.id),
                        onTap: adoptedPetIds.containsKey(pet.id)
                            ? null
                            : () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => DetailsPage(pet: pet)),
                                ),
                        onFavorite: () =>
                            context.read<FavoritesCubit>().toggleFavorite(pet.id),
                      );
                    },
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
} 