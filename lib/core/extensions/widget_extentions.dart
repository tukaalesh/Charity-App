import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';


extension WidgetExtension on Widget {
  Widget get rtl =>
      Directionality(textDirection: TextDirection.rtl, child: this);

  //stagger list view animation
  Widget staggerListHorizontal(int index) =>
      AnimationConfiguration.staggeredList(
        position: index,
        duration: const Duration(seconds: 1),
        child: SlideAnimation(
          horizontalOffset: 50.0,
          child: FadeInAnimation(
            child: this,
          ),
        ),
      );

  Widget staggerListVertical(int index) => AnimationConfiguration.staggeredList(
        position: index,
        duration: const Duration(seconds: 1),
        child: SlideAnimation(
          verticalOffset: 50.0,
          child: FadeInAnimation(
            child: this,
          ),
        ),
      );
}