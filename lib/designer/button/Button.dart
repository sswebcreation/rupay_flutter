import 'package:flutter/material.dart';
import 'package:rupay/size/WidgetSize.dart';

Widget standardButton({required BuildContext context, required Color backgroundColor, required Widget child, Color? borderColor, EdgeInsetsGeometry? margin, EdgeInsetsGeometry? padding}) {
  return Container(
    height: standardButtonHeight,
    width: standardButtonWidth,
    margin: margin,
    padding: padding,
    decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: borderColor??backgroundColor
        )
    ),
    child: child,
  );
}