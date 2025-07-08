import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:confetti/confetti.dart';
import '../models/pet.dart';
import '../blocs/adoption_cubit.dart';
import '../widgets/imageviewer.dart';
import 'package:auto_size_text/auto_size_text.dart';

class DetailsPage extends StatefulWidget {
  final Pet pet;
  const DetailsPage({required this.pet, super.key});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  late ConfettiController _confettiController;

  @override
  void initState() {
    _confettiController = ConfettiController(duration: const Duration(seconds: 2));
    super.initState();
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  void _handleAdoption(String petId) {
    context.read<AdoptionCubit>().adoptPet(petId);
    _confettiController.play();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('🎉 Congratulations!'),
        content: Text("You've now adopted ${widget.pet.name}!"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isAdopted = context.watch<AdoptionCubit>().state.containsKey(widget.pet.id);
    final media = MediaQuery.of(context);
    final width = media.size.width;
    final height = media.size.height;
    final maxContentWidth = 700.0;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: maxContentWidth),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final isWide = constraints.maxWidth > 700;
                      final imageHeight = media.size.height * (isWide ? 0.45 : 0.32);
                      final infoPadding = isWide ? 32.0 : 20.0;
                      final cardRadius = isWide ? 32.0 : 20.0;
                      final cardSpacing = isWide ? 24.0 : 14.0;
                      final avatarSize = isWide ? 120.0 : 90.0;
                      final buttonHeight = isWide ? 64.0 : 48.0;
                      final buttonFontSize = isWide ? 22.0 : 18.0;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Top image with interactive zoom viewer
                          Padding(
                            padding: EdgeInsets.only(bottom: cardSpacing),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) => ImageViewer(imageUrl: widget.pet.imageUrl),
                                  ),
                                );
                              },
                              child: Hero(
                                tag: 'pet_image_${widget.pet.id}',
                                child: ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(cardRadius),
                                    bottomRight: Radius.circular(cardRadius),
                                  ),
                                  child: AspectRatio(
                                    aspectRatio: isWide ? 16 / 7 : 3 / 2,
                                    child: Image.network(
                                      widget.pet.imageUrl,
                                      width: double.infinity,
                                      height: imageHeight,
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) => Icon(Icons.pets, size: 60, color: theme.colorScheme.secondary),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          // Info card: Row for wide, Column for narrow
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: infoPadding, vertical: infoPadding),
                            child: isWide
                                ? Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      // Info
                                      Expanded(child: _buildInfoColumn(theme, cardSpacing)),
                                      SizedBox(width: cardSpacing),
                                      // Pet avatar
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(cardRadius),
                                        child: AspectRatio(
                                          aspectRatio: 1,
                                          child: Image.network(
                                            widget.pet.imageUrl,
                                            width: avatarSize,
                                            height: avatarSize,
                                            fit: BoxFit.cover,
                                            errorBuilder: (context, error, stackTrace) => Icon(Icons.pets, size: avatarSize * 0.6, color: theme.colorScheme.secondary),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      
                                      SizedBox(height: cardSpacing),
                                      _buildInfoColumn(theme, cardSpacing),
                                    ],
                                  ),
                          ),
                          SizedBox(height: cardSpacing),
                          // Adopt button
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: infoPadding, vertical: cardSpacing),
                            child: SizedBox(
                              width: double.infinity,
                              height: buttonHeight,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: theme.colorScheme.primary,
                                  foregroundColor: theme.colorScheme.onPrimary,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(cardRadius),
                                  ),
                                  textStyle: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, fontSize: buttonFontSize),
                                ),
                                onPressed: isAdopted ? null : () => _handleAdoption(widget.pet.id),
                                child: AutoSizeText(isAdopted ? 'Already Adopted' : 'Adopt ${widget.pet.name}'),
                              ),
                            ),
                          ),
                          SizedBox(height: cardSpacing * 2),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
            // Confetti Overlay
            Align(
              alignment: Alignment.topCenter,
              child: ConfettiWidget(
                confettiController: _confettiController,
                blastDirectionality: BlastDirectionality.explosive,
                shouldLoop: false,
                emissionFrequency: 0.05,
                numberOfParticles: 20,
                maxBlastForce: 20,
                minBlastForce: 10,
                gravity: 0.3,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoColumn(ThemeData theme, double cardSpacing) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Flexible(
              child: AutoSizeText(
                widget.pet.name,
                style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                maxLines: 1,
                minFontSize: 10,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(width: 8),
            Flexible(
              child: AutoSizeText(
                '(${widget.pet.breed ?? 'Dog'})',
                style: theme.textTheme.bodyMedium?.copyWith(color: theme.hintColor),
                maxLines: 1,
                minFontSize: 10,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        SizedBox(height: cardSpacing / 2),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: theme.colorScheme.secondary.withOpacity(0.15),
                borderRadius: BorderRadius.circular(20),
              ),
              child: AutoSizeText(
                'Female',
                style: theme.textTheme.labelMedium?.copyWith(
                  color: theme.colorScheme.secondary,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                minFontSize: 10,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withOpacity(0.08),
                borderRadius: BorderRadius.circular(20),
              ),
              child: AutoSizeText(
                '${widget.pet.age} yrs.',
                style: theme.textTheme.labelMedium?.copyWith(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                minFontSize: 10,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        SizedBox(height: cardSpacing / 2),
        Row(
          children: [
            Icon(Icons.location_on, color: theme.colorScheme.error, size: 28),
            SizedBox(width: 4),
            Flexible(
              child: AutoSizeText(
                'Dummy Location',
                style: theme.textTheme.bodySmall?.copyWith(color: theme.hintColor),
                maxLines: 1,
                minFontSize: 10,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
