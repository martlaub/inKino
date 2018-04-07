import 'dart:math';

import 'package:flutter/material.dart';

class EventDetailsScrollEffects {
  EventDetailsScrollEffects() {
    updateScrollOffset(null, 0.0);
  }

  double _scrollOffset;

  double backdropHeight;
  double overlayOpacity;
  double backdropBlur;
  double headerOffset;

  double backButtonOpacity;
  double statusBarHeight;

  void updateScrollOffset(BuildContext context, double offset) {
    _scrollOffset = offset;

    _calculateBackdropValues();
    _calculateBackButtonValues();
    _calculateStatusBarValues(context);
  }

  void _calculateBackdropValues() {
    var unconstrainedBackdropHeight = 175.0 + (-_scrollOffset);
    var backdropOverscrollBlur = max(0.0, min(20.0, -_scrollOffset / 6));

    backdropHeight = max(80.0, unconstrainedBackdropHeight);
    overlayOpacity = max(
      0.0,
      min(1.0, 2.0 - (unconstrainedBackdropHeight / kToolbarHeight)),
    );

    backdropBlur =
        backdropOverscrollBlur == 0.0 ? overlayOpacity * 5.0 : backdropOverscrollBlur;

    if (_scrollOffset < 0) {
      overlayOpacity = max(
        0.0,
        min(1.0, -(_scrollOffset / 150)),
      );
    }

    headerOffset = 0.0;

    if (unconstrainedBackdropHeight < 80.0) {
      headerOffset = -(80.0 - unconstrainedBackdropHeight);
    }
  }

  void _calculateBackButtonValues() {
    var opacity = 1.0;

    if (_scrollOffset > 80.0) {
      opacity = max(0.0, min(1.0, 1.0 - ((_scrollOffset - 80.0) / 5)));
    } else if (_scrollOffset < 0.0) {
      opacity = max(0.0, min(1.0, 1.0 - (_scrollOffset / -40)));
    }

    backButtonOpacity = opacity;
  }

  void _calculateStatusBarValues(BuildContext context) {
    double statusBarMaxHeight = 0.0;

    if (context != null) {
      statusBarMaxHeight = MediaQuery.of(context).padding.top;
    }

    statusBarHeight = max(
      0.0,
      min(
        statusBarMaxHeight,
        _scrollOffset - 175.0 + (statusBarMaxHeight * 4),
      ),
    );
  }
}