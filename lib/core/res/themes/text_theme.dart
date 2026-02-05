// coverage:ignore-file

part of 'theme.dart';

/// text theme
TextTheme get _textTheme {
  // 1. We define the raw theme with your specific Dimens and Colors
  final baseTheme = const TextTheme(
    // Display
    displayLarge: TextStyle(
      fontSize: Dimens.s57,
      fontWeight: FontWeight.w700,
      color: AppColors.black000000,
    ),
    displayMedium: TextStyle(
      fontSize: Dimens.s45,
      fontWeight: FontWeight.w700,
      color: AppColors.black000000,
    ),
    displaySmall: TextStyle(
      fontSize: Dimens.s36,
      fontWeight: FontWeight.w600,
      color: AppColors.black000000,
    ),

    // Headline
    headlineLarge: TextStyle(
      fontSize: Dimens.s32,
      fontWeight: FontWeight.w600,
      color: AppColors.black000000,
    ),
    headlineMedium: TextStyle(
      fontSize: Dimens.s28,
      fontWeight: FontWeight.w600,
      color: AppColors.black000000,
    ),
    headlineSmall: TextStyle(
      fontSize: Dimens.s24,
      fontWeight: FontWeight.w600,
      color: AppColors.black000000,
    ),

    // Title
    titleLarge: TextStyle(
      fontSize: Dimens.s22,
      fontWeight: FontWeight.w600,
      color: AppColors.black000000,
    ),
    titleMedium: TextStyle(
      fontSize: Dimens.s16,
      fontWeight: FontWeight.w500,
      color: AppColors.black000000,
    ),
    titleSmall: TextStyle(
      fontSize: Dimens.s14,
      fontWeight: FontWeight.w500,
      color: AppColors.black000000,
    ),

    // Body
    bodyLarge: TextStyle(
      fontSize: Dimens.s16,
      fontWeight: FontWeight.w400,
      color: AppColors.black000000,
    ),
    bodyMedium: TextStyle(
      fontSize: Dimens.s14,
      fontWeight: FontWeight.w400,
      color: AppColors.black000000,
    ),
    bodySmall: TextStyle(
      fontSize: Dimens.s12,
      fontWeight: FontWeight.w400,
      color: AppColors.black000000,
    ),

    // Label
    labelLarge: TextStyle(
      fontSize: Dimens.s20,
      fontWeight: FontWeight.w500,
      color: AppColors.black000000,
    ),
    labelMedium: TextStyle(
      fontSize: Dimens.s14,
      fontWeight: FontWeight.w500,
      color: AppColors.black000000,
    ),
    labelSmall: TextStyle(
      fontSize: Dimens.s12,
      fontWeight: FontWeight.w500,
      color: AppColors.black000000,
    ),
  );

  // 2. We wrap that theme with Orbitron
  // This applies the font family while keeping your custom sizes/colors
  return GoogleFonts.orbitronTextTheme(baseTheme);
}