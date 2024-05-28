import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:phenikaa_campus/constants/assets_constants.dart';
import 'package:phenikaa_campus/theme/theme.dart';

class BottomAppBarIcon extends StatelessWidget {
  final int page;
  final SvgPicture icon;
  final double right;
  final double left;

  const BottomAppBarIcon({
    Key? key,
    required this.page,
    required this.icon,
    required this.right,
    required this.left,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return page == 0
        ? Padding(
            padding: EdgeInsets.only(right: right, left: left),
            child: icon,
          )
        : icon;
  }
}
