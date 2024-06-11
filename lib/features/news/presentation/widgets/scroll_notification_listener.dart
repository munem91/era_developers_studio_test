// This file defines the ScrollNotificationListener widget, which listens for scroll events.
// It triggers the provided callbacks (onScrollUp and onScrollDown) based on the scroll position.
// This widget is used in the FeaturedCarousel to determine if the user has scrolled up or down.

import 'package:flutter/material.dart';

class ScrollNotificationListener extends StatelessWidget {
  final VoidCallback onScrollUp;
  final VoidCallback onScrollDown;
  final Widget child;

  const ScrollNotificationListener({
    Key? key,
    required this.onScrollUp,
    required this.onScrollDown,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (scrollNotification) {
        if (scrollNotification is ScrollUpdateNotification) {
          if (scrollNotification.metrics.axis == Axis.vertical &&
              scrollNotification.metrics.pixels > 100) {
            onScrollUp();
          } else if (scrollNotification.metrics.axis == Axis.vertical &&
              scrollNotification.metrics.pixels < 100) {
            onScrollDown();
          }
        }
        return false;
      },
      child: child,
    );
  }
}
