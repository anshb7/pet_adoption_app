import 'package:flutter_test/flutter_test.dart';
import 'package:pet_adoption_app/blocs/adoption_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('AdoptionCubit', () {
    setUp(() {
      SharedPreferences.setMockInitialValues({});
    });

    test('initial state is empty', () async {
      final cubit = AdoptionCubit();
      await Future.delayed(const Duration(milliseconds: 10));
      expect(cubit.state, isEmpty);
    });

    test('adoptPet adds petId to state', () async {
      final cubit = AdoptionCubit();
      await Future.delayed(const Duration(milliseconds: 10));
      await cubit.adoptPet('pet1');
      expect(cubit.state.containsKey('pet1'), isTrue);
      expect(cubit.isAdopted('pet1'), isTrue);
    });
  });
} 