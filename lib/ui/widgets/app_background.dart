import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo_app/ui/utils/assets_path_util.dart';

class AppBackground extends StatelessWidget {
  const AppBackground({super.key, required this.children});

  final List<Widget> children;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          SvgPicture.asset(
            AssetsPathUtil.backgroundSvg,
            width: double.maxFinite,
            height: double.maxFinite,
            fit: BoxFit.cover,
          ),
          ...children,
        ],
      ),
    );
  }
}
