import 'package:flutter/material.dart';

class AppLoginTheme extends ThemeExtension<AppLoginTheme> {
  final Gradient loginGradient;
  final Gradient loginButtonGradient;
  final Gradient logoGradient;

  final Color glassColor;
  final Color glassBorderColor;

  final Color inputLineColor;
  final Color inputLineFocusedColor;
  final Color inputTextColor;
  final Color labelColor;

  final Color linkColor;

  const AppLoginTheme({
    required this.loginGradient,
    required this.loginButtonGradient,
    required this.logoGradient,
    required this.glassColor,
    required this.glassBorderColor,
    required this.inputLineColor,
    required this.inputLineFocusedColor,
    required this.inputTextColor,
    required this.labelColor,
    required this.linkColor,
  });

  @override
  AppLoginTheme copyWith({
    Gradient? loginGradient,
    Gradient? loginButtonGradient,
    Gradient? logoGradient,
    Color? glassColor,
    Color? glassBorderColor,
    Color? inputLineColor,
    Color? inputLineFocusedColor,
    Color? inputTextColor,
    Color? labelColor,
    Color? linkColor,
  }) {
    return AppLoginTheme(
      loginGradient: loginGradient ?? this.loginGradient,
      loginButtonGradient: loginButtonGradient ?? this.loginButtonGradient,
      logoGradient: logoGradient ?? this.logoGradient,
      glassColor: glassColor ?? this.glassColor,
      glassBorderColor: glassBorderColor ?? this.glassBorderColor,
      inputLineColor: inputLineColor ?? this.inputLineColor,
      inputLineFocusedColor: inputLineFocusedColor ?? this.inputLineFocusedColor,
      inputTextColor: inputTextColor ?? this.inputTextColor,
      labelColor: labelColor ?? this.labelColor,
      linkColor: linkColor ?? this.linkColor,
    );
  }

  @override
  ThemeExtension<AppLoginTheme> lerp(
      covariant ThemeExtension<AppLoginTheme>? other, double t) {
    if (other is! AppLoginTheme) return this;

    return AppLoginTheme(
      loginGradient: Gradient.lerp(loginGradient, other.loginGradient, t)!,
      loginButtonGradient:
          Gradient.lerp(loginButtonGradient, other.loginButtonGradient, t)!,
      logoGradient: Gradient.lerp(logoGradient, other.logoGradient, t)!,
      glassColor: Color.lerp(glassColor, other.glassColor, t)!,
      glassBorderColor: Color.lerp(glassBorderColor, other.glassBorderColor, t)!,
      inputLineColor: Color.lerp(inputLineColor, other.inputLineColor, t)!,
      inputLineFocusedColor:
          Color.lerp(inputLineFocusedColor, other.inputLineFocusedColor, t)!,
      inputTextColor: Color.lerp(inputTextColor, other.inputTextColor, t)!,
      labelColor: Color.lerp(labelColor, other.labelColor, t)!,
      linkColor: Color.lerp(linkColor, other.linkColor, t)!,
    );
  }
}

class AppTheme {
  static ThemeData get theme {
    return ThemeData(
      scaffoldBackgroundColor: const Color(0xFFF5F5F5),
      primaryColor: const Color(0xFF0D1B2A),
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF0D1B2A),
        primary: const Color(0xFF0D1B2A),
        secondary: const Color(0xFFFFD700),
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: Color(0xFF0D1B2A)),
        bodyMedium: TextStyle(color: Color(0xFF0D1B2A)),
      ),
      extensions: [
        AppLoginTheme(
          loginGradient: const LinearGradient(
            colors: [
              Color(0xFF6A11CB),
              Color(0xFF2575FC),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          loginButtonGradient: const LinearGradient(
            colors: [
              Color(0xFFFC466B),
              Color(0xFF3F5EFB),
            ],
          ),
          logoGradient: const LinearGradient(
            colors: [
              Colors.white,
              Colors.white54,
            ],
          ),
          glassColor: Colors.white12,
          glassBorderColor: Colors.white24,

          inputLineColor: Colors.white54,
          inputLineFocusedColor: Colors.white,
          inputTextColor: Colors.white,
          labelColor: Colors.white70,
          linkColor: Colors.white70,
        ),
      ],
    );
  }
}
