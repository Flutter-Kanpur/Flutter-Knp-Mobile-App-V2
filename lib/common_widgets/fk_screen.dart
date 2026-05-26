import 'package:flutter/material.dart';
import 'package:flutter_knp_mobile_app_v2/common_widgets/gradiant_background.dart';

class FkScreen extends StatelessWidget {
  const FkScreen({
    super.key,
    required this.children,
    this.padding = const EdgeInsets.fromLTRB(20, 18, 20, 24),
  });

  final List<Widget> children;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: SafeArea(
        child: ListView(padding: padding, children: children),
      ),
    );
  }
}
