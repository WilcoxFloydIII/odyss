import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AppColors {
  static Color primaryPink = Color(0xFFF5008B);
  static Color primaryBlack = Color(0xFF000000);
  static Color darkText = Color(0xFF000000);
  static Color whiteText = Color(0xFFFFFFFF);
  static Color lightBackground = Color(0xFFFFFFFF);
  static Color darkBackground = Color(0xFF000000);
}

@immutable
class MyColors extends ThemeExtension<MyColors> {
  final Color primary;
  final Color backgound;

  const MyColors({
    required this.primary,
    required this.backgound,
  });

  @override
  MyColors copyWith({Color? light, Color? dark}) {
    return MyColors(
      primary: light ?? this.primary,
      backgound: dark ?? this.backgound,
    );
  }

  @override
  MyColors lerp(ThemeExtension<MyColors>? other, double t) {
    if (other is! MyColors) return this;
    return MyColors(
      primary: Color.lerp(primary, other.primary, t)!,
      backgound: Color.lerp(backgound, other.backgound, t)!,
    );
  }
}
