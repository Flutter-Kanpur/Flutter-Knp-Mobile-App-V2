import 'package:flutter/material.dart';

RadialGradient backgroundGradiant() {
  return const RadialGradient(
    center: Alignment.center,
    radius: 0.7,
    colors: [
      Color(0xFF183B4D), // Center color (brighter)
      Color(0xFF03080B), // Edge color (darker)
    ],
    stops: [0.0, 0.8],
  );
}

List<Color> getBackgroundGradientColors() {
  return [
    const Color(0xFF183B4D),
    const Color(0xFF03080B),
  ];
}

List<Color> getGradientColors(double scrollOffset) {
  double t = (scrollOffset / 300).clamp(0.0, 1.0);
  final centerColor =
      Color.lerp(const Color(0xFF183B4D), const Color(0xFF183B4D), t)!;
  final edgeColor =
      Color.lerp(const Color(0xFF03080B), const Color(0xFF03080B), t)!;
  return [centerColor, edgeColor];
}

Alignment getGradientCenter(double scrollOffset, double scrollPosition) {
  // baseY decreases with scroll to move gradient upward
  double baseY = 0.6 - (scrollOffset / 300);

  return Alignment(0, baseY - 0.9);
}

LinearGradient buttonGradient() {
  return const LinearGradient(
    colors: [
      Color(0xFF00BFFF), // Sky blue
      Color(0xFF00BFFF), // Holds blue till mid
      Color(0xFF13131B), // Deep dark
    ],
    stops: [0.0, 0.5, 1.0], // Transition at mid-point
    begin: Alignment.centerLeft,
    end: Alignment.bottomCenter,
  );
}

// Gradient text utilities
LinearGradient titleGradient() {
  return const LinearGradient(
    colors: [
      Color(0xFFFFFFFF), // Sky blue// Light blue

      // Sky blue// Light blue
      Color(0xFF64A9DD), // Light green
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}

LinearGradient eventTitleGradient() {
  return const LinearGradient(
    colors: [
      Color(0xFF00BFFF), // Sky blue
      Color(0xFF4FC3F7), // Light blue
      Color(0xFF29B6F6), // Blue
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
}

// Widget for gradient text
class GradientText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final Gradient gradient;
  final TextAlign? textAlign;

  const GradientText(
    this.text, {
    super.key,
    this.style,
    this.gradient = const LinearGradient(
      colors: [Color(0xFFFFFFFF), Color(0xFF64A9DD)],
    ),
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(
        text,
        style: style,
        textAlign: textAlign,
      ),
    );
  }
}
