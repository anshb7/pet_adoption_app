import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/adoption_cubit.dart';
import 'blocs/favorites_cubit.dart';
import 'screens/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AdoptionCubit()),
        BlocProvider(create: (_) => FavoritesCubit()),
      ],
      child: MaterialApp(
        title: 'Pet Adoption',
      
        theme: ThemeData(
  colorScheme: ColorScheme.light(
    // Primary brand colors with better accessibility
    primary: const Color(0xFF6366F1), // Modern indigo
    onPrimary: Colors.white,
    primaryContainer: const Color(0xFFE0E7FF), // Light indigo container
    onPrimaryContainer: const Color(0xFF1E1B4B), // Dark indigo for text
    
    // Secondary colors with better harmony
    secondary: const Color(0xFF6366F1), // Cyan accent
    onSecondary: Colors.white,
    secondaryContainer: const Color(0xFFCFFAFE), // Light cyan container
    onSecondaryContainer: const Color(0xFF0E4F5C), // Dark cyan for text
    
    // Tertiary colors for additional accent
    tertiary: const Color(0xFF8B5CF6), // Purple accent
    onTertiary: Colors.white,
    tertiaryContainer: const Color(0xFFF3E8FF), // Light purple container
    onTertiaryContainer: const Color(0xFF4C1D95), // Dark gray for better readability
    
    // Surface colors with layered approach
    surface: Colors.white,
    onSurface: const Color(0xFF1F2937),
    surfaceContainerHighest: const Color(0xFFF9FAFB), // Subtle surface variant
    onSurfaceVariant: const Color(0xFF6B7280), // Medium gray
    
    // Error colors with better contrast
    error: const Color(0xFFEF4444), // Modern red
    onError: Colors.white,
    errorContainer: const Color(0xFFFEE2E2), // Light red container
    onErrorContainer: const Color(0xFF7F1D1D), // Dark red for text
    
    // Outline colors for borders
    outline: const Color(0xFFE5E7EB), // Light gray border
    outlineVariant: const Color(0xFFF3F4F6), // Subtle border variant
    
    // Additional semantic colors
    shadow: Colors.black.withOpacity(0.04), // Subtle shadow
    scrim: Colors.black.withOpacity(0.6), // Modal overlay
    inverseSurface: const Color(0xFF1F2937), // Dark surface for contrast
    onInverseSurface: Colors.white,
    inversePrimary: const Color(0xFFA5B4FC), // Light primary for dark surfaces
  ),
  
  // Enhanced scaffold background
  scaffoldBackgroundColor: const Color(0xFFFAFAFB),
  
  // Improved app bar theme
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    foregroundColor: Color(0xFF1F2937),
    elevation: 0,
    scrolledUnderElevation: 1,
    shadowColor: Colors.black12,
    surfaceTintColor: Colors.transparent,
    centerTitle: true,
    titleTextStyle: TextStyle(
      color: Color(0xFF1F2937),
      fontSize: 20,
      fontWeight: FontWeight.w600,
      fontFamily: 'Inter',
    ),
  ),
  
  // Enhanced card theme
  cardTheme: CardTheme(
    color: Colors.white,
    elevation: 2,
    shadowColor: Colors.black.withOpacity(0.06),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    margin: const EdgeInsets.all(8),
  ),
  
  // Enhanced elevated button theme
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF6366F1),
      foregroundColor: Colors.white,
      elevation: 2,
      shadowColor: Colors.black.withOpacity(0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      textStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        fontFamily: 'Inter',
      ),
    ),
  ),
  
  // Enhanced outlined button theme
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: const Color(0xFF6366F1),
      side: const BorderSide(
        color: Color(0xFF6366F1),
        width: 1.5,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      textStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        fontFamily: 'Inter',
      ),
    ),
  ),
  
  // Enhanced text button theme
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: const Color(0xFF6366F1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      textStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        fontFamily: 'Inter',
      ),
    ),
  ),
  
  // Enhanced input decoration theme
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: const Color(0xFFF9FAFB),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(
        color: Color(0xFFE5E7EB),
        width: 1,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(
        color: Color(0xFFE5E7EB),
        width: 1,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(
        color: Color(0xFF6366F1),
        width: 2,
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(
        color: Color(0xFFEF4444),
        width: 1,
      ),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(
        color: Color(0xFFEF4444),
        width: 2,
      ),
    ),
    contentPadding: const EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 12,
    ),
    hintStyle: const TextStyle(
      color: Color(0xFF9CA3AF),
      fontSize: 16,
      fontFamily: 'Inter',
    ),
    labelStyle: const TextStyle(
      color: Color(0xFF6B7280),
      fontSize: 16,
      fontFamily: 'Inter',
    ),
  ),
  
  // Enhanced bottom navigation bar theme
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    selectedItemColor: Color(0xFF6366F1),
    unselectedItemColor: Color(0xFF9CA3AF),
    type: BottomNavigationBarType.fixed,
    elevation: 8,
    selectedLabelStyle: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w600,
      fontFamily: 'Inter',
    ),
    unselectedLabelStyle: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      fontFamily: 'Inter',
    ),
  ),
  
  // Enhanced floating action button theme
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Color(0xFF6366F1),
    foregroundColor: Colors.white,
    elevation: 4,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(16)),
    ),
  ),
  
  // Enhanced divider theme
  dividerTheme: const DividerThemeData(
    color: Color(0xFFE5E7EB),
    thickness: 1,
    space: 1,
  ),
  
  // Enhanced chip theme
  chipTheme: ChipThemeData(
    backgroundColor: const Color(0xFFF3F4F6),
    disabledColor: const Color(0xFFF9FAFB),
    selectedColor: const Color(0xFF6366F1),
    secondarySelectedColor: const Color(0xFFE0E7FF),
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    labelStyle: const TextStyle(
      color: Color(0xFF1F2937),
      fontSize: 14,
      fontWeight: FontWeight.w500,
      fontFamily: 'Inter',
    ),
    secondaryLabelStyle: const TextStyle(
      color: Colors.white,
      fontSize: 14,
      fontWeight: FontWeight.w500,
      fontFamily: 'Inter',
    ),
    brightness: Brightness.light,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
  ),
  
  // Typography with Inter font family
  fontFamily: 'Inter',
  
  // Enhanced text theme
  textTheme: const TextTheme(
    displayLarge: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.w700,
      color: Color(0xFF1F2937),
      fontFamily: 'Inter',
    ),
    displayMedium: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.w600,
      color: Color(0xFF1F2937),
      fontFamily: 'Inter',
    ),
    displaySmall: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      color: Color(0xFF1F2937),
      fontFamily: 'Inter',
    ),
    headlineLarge: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w600,
      color: Color(0xFF1F2937),
      fontFamily: 'Inter',
    ),
    headlineMedium: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: Color(0xFF1F2937),
      fontFamily: 'Inter',
    ),
    headlineSmall: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: Color(0xFF1F2937),
      fontFamily: 'Inter',
    ),
    titleLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: Color(0xFF1F2937),
      fontFamily: 'Inter',
    ),
    titleMedium: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: Color(0xFF1F2937),
      fontFamily: 'Inter',
    ),
    titleSmall: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w600,
      color: Color(0xFF1F2937),
      fontFamily: 'Inter',
    ),
    bodyLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: Color(0xFF1F2937),
      fontFamily: 'Inter',
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: Color(0xFF1F2937),
      fontFamily: 'Inter',
    ),
    bodySmall: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: Color(0xFF6B7280),
      fontFamily: 'Inter',
    ),
    labelLarge: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: Color(0xFF1F2937),
      fontFamily: 'Inter',
    ),
    labelMedium: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: Color(0xFF6B7280),
      fontFamily: 'Inter',
    ),
    labelSmall: TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.w500,
      color: Color(0xFF6B7280),
      fontFamily: 'Inter',
    ),
  ),
  
  // Enhanced visual density for better touch targets
  visualDensity: VisualDensity.adaptivePlatformDensity,
  
  // Enhanced material design version
  useMaterial3: true,
),
        darkTheme: ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  colorScheme: const ColorScheme.dark(
    brightness: Brightness.dark,
    primary: Color(0xFF8B7CF6), // Modern purple
    onPrimary: Color(0xFF1A1A2E),
    primaryContainer: Color(0xFF5B4FD1),
    onPrimaryContainer: Color(0xFFE8E5FF),
    secondary: Color(0xFF6366F1),
    onSecondary: Color(0xFF1A1A2E),
    tertiary: Color(0xFF10B981), // Emerald accent
    onTertiary: Color(0xFF0F172A),
    error: Color(0xFFEF4444),
    onError: Color(0xFF0F172A),
    surface: Color(0xFF1A1A2E),
    onSurface: Color(0xFFF1F5F9),
    surfaceContainerHighest: Color(0xFF262640),
    onSurfaceVariant: Color(0xFFCBD5E1),
    outline: Color(0xFF475569),
    shadow: Color(0xFF000000),
    inverseSurface: Color(0xFFF8FAFC),
    onInverseSurface: Color(0xFF1E293B),
  ),
  scaffoldBackgroundColor: const Color(0xFF0F0F14),
  
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF1A1A2E),
    foregroundColor: Color(0xFFF1F5F9),
    elevation: 0,
    scrolledUnderElevation: 4,
    shadowColor: Color(0xFF000000),
    centerTitle: true,
    titleTextStyle: TextStyle(
      color: Color(0xFFF1F5F9),
      fontWeight: FontWeight.w600,
      fontSize: 20,
      fontFamily: 'Inter',
      letterSpacing: -0.5,
    ),
    iconTheme: IconThemeData(
      color: Color(0xFFF1F5F9),
      size: 24,
    ),
    actionsIconTheme: IconThemeData(
      color: Color(0xFF8B7CF6),
      size: 24,
    ),
  ),
  
  cardColor: const Color(0xFF1A1A2E),
  shadowColor: const Color(0xFF000000),
  
  iconTheme: const IconThemeData(
    color: Color(0xFFF1F5F9),
    size: 24,
  ),
  
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Color(0xFF1A1A2E),
    selectedItemColor: Color(0xFF8B7CF6),
    unselectedItemColor: Color(0xFF64748B),
    showUnselectedLabels: true,
    type: BottomNavigationBarType.fixed,
    elevation: 16,
    selectedLabelStyle: TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 12,
      fontFamily: 'Inter',
    ),
    unselectedLabelStyle: TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 12,
      fontFamily: 'Inter',
    ),
  ),
  
  chipTheme: ChipThemeData(
    backgroundColor: const Color(0xFF262640),
    labelStyle: const TextStyle(
      color: Color(0xFFF1F5F9),
      fontFamily: 'Inter',
      fontWeight: FontWeight.w500,
    ),
    secondaryLabelStyle: const TextStyle(
      color: Color(0xFF94A3B8),
      fontFamily: 'Inter',
    ),
    selectedColor: const Color(0xFF8B7CF6),
    disabledColor: const Color(0xFF374151),
    deleteIconColor: const Color(0xFF94A3B8),
    brightness: Brightness.dark,
    elevation: 2,
    pressElevation: 4,
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
  ),
  
  // Enhanced Button Themes
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF8B7CF6),
      foregroundColor: const Color(0xFF1A1A2E),
      elevation: 4,
      shadowColor: const Color(0xFF000000),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      textStyle: const TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 16,
        fontFamily: 'Inter',
      ),
    ),
  ),
  
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: const Color(0xFF8B7CF6),
      side: const BorderSide(color: Color(0xFF8B7CF6), width: 1.5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      textStyle: const TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 16,
        fontFamily: 'Inter',
      ),
    ),
  ),
  
  // Input Field Theme
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: const Color(0xFF262640),
    hintStyle: const TextStyle(
      color: Color(0xFF64748B),
      fontFamily: 'Inter',
    ),
    labelStyle: const TextStyle(
      color: Color(0xFF8B7CF6),
      fontFamily: 'Inter',
      fontWeight: FontWeight.w500,
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Color(0xFF475569)),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Color(0xFF475569)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Color(0xFF8B7CF6), width: 2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Color(0xFFEF4444)),
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
  ),
  
  textTheme: const TextTheme(
    displayLarge: TextStyle(
      color: Color(0xFFF1F5F9),
      fontFamily: 'Inter',
      fontWeight: FontWeight.w800,
      fontSize: 57,
      letterSpacing: -0.25,
    ),
    displayMedium: TextStyle(
      color: Color(0xFFF1F5F9),
      fontFamily: 'Inter',
      fontWeight: FontWeight.w700,
      fontSize: 45,
      letterSpacing: 0,
    ),
    displaySmall: TextStyle(
      color: Color(0xFFF1F5F9),
      fontFamily: 'Inter',
      fontWeight: FontWeight.w600,
      fontSize: 36,
      letterSpacing: 0,
    ),
    headlineLarge: TextStyle(
      color: Color(0xFFF1F5F9),
      fontFamily: 'Inter',
      fontWeight: FontWeight.w600,
      fontSize: 32,
      letterSpacing: 0,
    ),
    headlineMedium: TextStyle(
      color: Color(0xFFF1F5F9),
      fontFamily: 'Inter',
      fontWeight: FontWeight.w600,
      fontSize: 28,
      letterSpacing: 0,
    ),
    headlineSmall: TextStyle(
      color: Color(0xFFF1F5F9),
      fontFamily: 'Inter',
      fontWeight: FontWeight.w600,
      fontSize: 24,
      letterSpacing: 0,
    ),
    titleLarge: TextStyle(
      color: Color(0xFFF1F5F9),
      fontFamily: 'Inter',
      fontWeight: FontWeight.w600,
      fontSize: 22,
      letterSpacing: 0,
    ),
    titleMedium: TextStyle(
      color: Color(0xFFF1F5F9),
      fontFamily: 'Inter',
      fontWeight: FontWeight.w600,
      fontSize: 16,
      letterSpacing: 0.15,
    ),
    titleSmall: TextStyle(
      color: Color(0xFFCBD5E1),
      fontFamily: 'Inter',
      fontWeight: FontWeight.w500,
      fontSize: 14,
      letterSpacing: 0.1,
    ),
    bodyLarge: TextStyle(
      color: Color(0xFFF1F5F9),
      fontFamily: 'Inter',
      fontWeight: FontWeight.w400,
      fontSize: 16,
      letterSpacing: 0.5,
    ),
    bodyMedium: TextStyle(
      color: Color(0xFFCBD5E1),
      fontFamily: 'Inter',
      fontWeight: FontWeight.w400,
      fontSize: 14,
      letterSpacing: 0.25,
    ),
    bodySmall: TextStyle(
      color: Color(0xFF94A3B8),
      fontFamily: 'Inter',
      fontWeight: FontWeight.w400,
      fontSize: 12,
      letterSpacing: 0.4,
    ),
    labelLarge: TextStyle(
      color: Color(0xFF8B7CF6),
      fontFamily: 'Inter',
      fontWeight: FontWeight.w600,
      fontSize: 14,
      letterSpacing: 0.1,
    ),
    labelMedium: TextStyle(
      color: Color(0xFF8B7CF6),
      fontFamily: 'Inter',
      fontWeight: FontWeight.w500,
      fontSize: 12,
      letterSpacing: 0.5,
    ),
    labelSmall: TextStyle(
      color: Color(0xFF64748B),
      fontFamily: 'Inter',
      fontWeight: FontWeight.w500,
      fontSize: 11,
      letterSpacing: 0.5,
    ),
  ),
  
  fontFamily: 'Inter',
),
        themeMode: ThemeMode.system,
        home: const HomePage(),
      ),
    );
  }
}
