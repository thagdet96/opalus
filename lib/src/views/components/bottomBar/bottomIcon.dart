import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:opalus/src/utils/myTheme.dart';

class BottomBarIcon extends StatelessWidget {
  final String assetName;
  final double size = 28;
  final bool active;

  BottomBarIcon(this.assetName, {this.active = false});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      this.assetName,
      color:
          this.active ? MyTheme.secondaryColor() : MyTheme.secondaryColorDark(),
      height: this.size,
      width: this.size,
    );
  }
}
