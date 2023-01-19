import 'package:flutter/material.dart';
import 'package:flash/flash.dart';
class CustomFlashBar extends StatelessWidget {
  const CustomFlashBar({
    Key? key,
    required this.controller, required this.contentMessage, required this.titleMessage, this.colors =const [Colors.redAccent, Colors.red],
  }) : super(key: key);

  final FlashController controller;
  final String contentMessage;
  final String titleMessage;
  final List<Color> colors;
  @override
  Widget build(BuildContext context) {
    return Flash.bar(
      controller: controller,
      backgroundGradient: LinearGradient(
        colors: colors,
      ),
      // Position is only available for the "bar" named constructor and can be bottom/top.
      position: FlashPosition.top,
      // Allow dismissal by dragging down.
      enableVerticalDrag: true,
      // Allow dismissal by dragging to the side (and specify direction).
      horizontalDismissDirection: HorizontalDismissDirection.startToEnd,
      margin: const EdgeInsets.all(8),
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      // Make the animation lively by experimenting with different curves.
      forwardAnimationCurve: Curves.easeOutBack,
      reverseAnimationCurve: Curves.slowMiddle,
      // While it's possible to use any widget you like as the child,
      // the FlashBar widget looks good without any effort on your side.
      child: FlashBar(
        content: Text(contentMessage),
        title: Text(
          titleMessage,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        // shouldIconPulse: false,
        // showProgressIndicator: true,
      ),
    );
  }
}