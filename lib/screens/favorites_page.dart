import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/favorites_cubit.dart';
import '../blocs/pet_list_bloc.dart';
import '../models/pet.dart';
import '../utils/responsive.dart';
import 'package:auto_size_text/auto_size_text.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(top: responsiveValue(context, 48, 72), bottom: responsiveValue(context, 24, 36)),
            decoration: BoxDecoration(
              border:Border(bottom: BorderSide(
                color: const Color(0xFF6366F1)
              )),
              color: theme.appBarTheme.backgroundColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(responsiveValue(context, 32, 48)),
                bottomRight: Radius.circular(responsiveValue(context, 32, 48)),
              ),
              boxShadow: [
                BoxShadow(
                  color: theme.appBarTheme.backgroundColor!.withOpacity(0.2),
                  blurRadius: responsiveValue(context, 12, 24),
                  offset: Offset(0, responsiveValue(context, 4, 8)),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.favorite, color: theme.appBarTheme.foregroundColor, size: responsiveValue(context, 28, 36)),
                SizedBox(width: responsiveValue(context, 8, 16)),
                AutoSizeText(
                  'Favorites',
                  style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: responsiveValue(context, 18, 24),
              ),
                  minFontSize: 10,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<FavoritesCubit, Set<String>>(
              builder: (context, favoritePetIds) {
                return BlocBuilder<PetListBloc, PetListState>(
                  builder: (context, state) {
                    List<Pet> pets = [];
                    if (state is PetListLoaded || state is PetListLoadingMore) {
                      final allPets = state is PetListLoaded ? state.pets : (state as PetListLoadingMore).pets;
                      pets = allPets.where((pet) => favoritePetIds.contains(pet.id)).toList();
                    }
                    if (pets.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.favorite_border, size: responsiveValue(context, 80, 120), color: theme.colorScheme.primary.withOpacity(0.2)),
                            SizedBox(height: responsiveValue(context, 24, 40)),
                            AutoSizeText(
                              'No pets have been favorited yet.',
                              style: theme.textTheme.titleMedium?.copyWith(fontSize: responsiveValue(context, 20, 28)),
                              minFontSize: 10,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: responsiveValue(context, 8, 16)),
                            AutoSizeText(
                              'Tap the heart on a pet to add it to your favorites!',
                              style: theme.textTheme.bodyMedium?.copyWith(color: theme.hintColor, fontSize: responsiveValue(context, 14, 18)),
                              minFontSize: 10,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      );
                    }
                    return ListView.separated(
                      padding: EdgeInsets.all(responsiveValue(context, 16, 40)),
                      itemCount: pets.length,
                      separatorBuilder: (_, __) => SizedBox(height: responsiveValue(context, 16, 28)),
                      itemBuilder: (context, index) {
                        final pet = pets[index];
                        return TweenAnimationBuilder<double>(
                          tween: Tween(begin: 0, end: 1),
                          duration: Duration(milliseconds: 400 + index * 60),
                          builder: (context, value, child) => Opacity(
                            opacity: value,
                            child: Transform.translate(
                              offset: Offset(0, 24 * (1 - value)),
                              child: child,
                            ),
                          ),
                          child: Material(
                            color: theme.cardColor,
                            borderRadius: BorderRadius.circular(responsiveValue(context, 24, 36)),
                            elevation: responsiveValue(context, 4, 8),
                            child: ListTile(
                              contentPadding: EdgeInsets.symmetric(horizontal: responsiveValue(context, 20, 60), vertical: responsiveValue(context, 12, 24)),
                              leading: CircleAvatar(
                                radius: responsiveValue(context, 32, 48),
                                backgroundImage: NetworkImage(pet.imageUrl),
                                backgroundColor: theme.colorScheme.secondary.withOpacity(0.1),
                              ),
                              title: AutoSizeText(
                                pet.name,
                                style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, fontSize: responsiveValue(context, 20, 28)),
                                minFontSize: 10,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              subtitle: AutoSizeText(
                                'Age: ${pet.age} years\nPrice: ₹${pet.price.toStringAsFixed(0)}',
                                style: theme.textTheme.bodyMedium?.copyWith(fontSize: responsiveValue(context, 14, 18)),
                                minFontSize: 10,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              trailing: IconButton(
                                icon: Icon(Icons.favorite, color: theme.colorScheme.error, size: responsiveValue(context, 28, 36)),
                                onPressed: () => context.read<FavoritesCubit>().toggleFavorite(pet.id),
                                tooltip: 'Remove from favorites',
                              ),
                              onTap: () {
                                // Optionally navigate to details
                              },
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
} 