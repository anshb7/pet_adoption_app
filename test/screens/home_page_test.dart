import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pet_adoption_app/screens/home_page.dart';
import 'package:pet_adoption_app/blocs/pet_list_bloc.dart';
import 'package:pet_adoption_app/blocs/adoption_cubit.dart';
import 'package:pet_adoption_app/blocs/favorites_cubit.dart';
import 'package:pet_adoption_app/repositories/pet_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  testWidgets('HomePage shows pet list and search bar', (WidgetTester tester) async {
    await tester.pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => PetListBloc(petRepository: PetRepository())..add(FetchPets())),
          BlocProvider(create: (_) => AdoptionCubit()),
          BlocProvider(create: (_) => FavoritesCubit()),
        ],
        child: const MaterialApp(
          home: HomePage(),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.byType(TextField), findsOneWidget);
    expect(find.text('Search pets by name...'), findsOneWidget);
    expect(find.byType(ListView), findsOneWidget);
    // Should show at least one pet name from mockPets
    expect(find.text('Simba'), findsWidgets);
  });
} 