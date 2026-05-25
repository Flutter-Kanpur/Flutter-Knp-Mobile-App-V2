import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
class AppBarLogo extends StatelessWidget {
  const AppBarLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(

    decoration: BoxDecoration(
      border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(3)
    ),
      child: SvgPicture.asset("assets/flutter_knp_logo_with_bg.svg",   ),
    );
  }
}
