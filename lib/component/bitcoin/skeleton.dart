import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ListSkeleton extends StatelessWidget {
  const ListSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    var skeletonCards = List<Widget>.empty(growable: true);
    var skeletonCardsCount = 5;

    for (var i = 0; i < skeletonCardsCount; i++) {
      var isFirst = i == 0;
      var isLast = i == skeletonCardsCount - 1;

      EdgeInsetsGeometry padding;

      if (isFirst) {
        padding = const EdgeInsets.only(left: 10);
      } else if (isLast) {
        padding = const EdgeInsets.only(right: 10);
      } else {
        padding = EdgeInsets.zero;
      }

      skeletonCards.add(
        Padding(
          padding: padding,
          child: const SizedBox(
            width: 256,
            height: 118,
            child: Card(),
          ),
        ),
      );
    }

    return Shimmer.fromColors(
      baseColor: Colors.grey.shade700,
      highlightColor: Colors.grey.shade800,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: skeletonCards,
      ),
    );
  }
}
