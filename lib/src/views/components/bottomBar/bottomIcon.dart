import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomBarIcon extends StatelessWidget {
  final String assetName;
  final double size = 28;
  final bool active;

  BottomBarIcon(this.assetName, {this.active = false});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      this.assetName,
      color: this.active ? Colors.white : Colors.blueGrey[100],
      height: this.size,
      width: this.size,
    );
  }
}
