import 'package:flutter/material.dart';
import '../models/pet.dart';
import '../utils/responsive.dart';
import 'package:auto_size_text/auto_size_text.dart';
// Removed cached_network_image import

class PetCard extends StatelessWidget {
  final Pet pet;
  final bool isAdopted;
  final bool isFavorite;
  final VoidCallback? onTap;
  final VoidCallback? onFavorite;

  const PetCard({
    super.key,
    required this.pet,
    this.isAdopted = false,
    this.isFavorite = false,
    this.onTap,
    this.onFavorite,
  });

  Color getBgColor(BuildContext context) {
    return Theme.of(context).cardColor;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return LayoutBuilder(
      builder: (context, constraints) {
        double width = constraints.maxWidth;
        double imageAspectRatio = 3 / 2;
        double iconSize = width >= 300 ? 32 : width >= 200 ? 28 : 22;
        double nameFontSize = width >= 300 ? 20 : width >= 200 ? 18 : 15;
        double breedFontSize = width >= 300 ? 16 : width >= 200 ? 14 : 12;
        double ageFontSize = width >= 300 ? 14 : width >= 200 ? 13 : 11;
        double cardPadding = width >= 300 ? 16 : width >= 200 ? 12 : 8;
        double spacing = width >= 300 ? 12 : width >= 200 ? 8 : 6;
        return Opacity(
          opacity: isAdopted ? 0.5 : 1.0,
          child: InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: onTap,
            child: Container(
              decoration: BoxDecoration(
                color: getBgColor(context),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: theme.shadowColor.withOpacity(0.08),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              padding: EdgeInsets.all(cardPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(height: spacing),
                  Hero(
                    tag: 'pet_image_${pet.id}',
                    child: AspectRatio(
                      aspectRatio: imageAspectRatio,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.network(
                          pet.imageUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Icon(
                            Icons.pets,
                            size: iconSize,
                            color: theme.colorScheme.secondary,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: spacing),
                  Flexible(
                    child: AutoSizeText(
                      pet.name,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: nameFontSize,
                      ),
                      textAlign: TextAlign.center,
                      minFontSize: 10,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Flexible(
                    child: AutoSizeText(
                      '(${pet.breed ?? 'Pet'})',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.hintColor,
                        fontSize: breedFontSize,
                      ),
                      textAlign: TextAlign.center,
                      minFontSize: 10,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.surface,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: AutoSizeText(
                          'Age: ${pet.age} yrs.',
                          style: theme.textTheme.labelMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.primary,
                            fontSize: ageFontSize,
                          ),
                          textAlign: TextAlign.center,
                          minFontSize: 10,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: isFavorite ? theme.colorScheme.error : theme.iconTheme.color,
                          size: iconSize,
                        ),
                        onPressed: onFavorite,
                        splashRadius: 24,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
} 