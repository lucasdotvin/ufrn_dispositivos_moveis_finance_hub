import 'package:finance_hub/domain/enum/tax.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ListSkeleton extends StatelessWidget {
  const ListSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    var skeletonCards = List<Widget>.empty(growable: true);
    var skeletonCardsCount = Tax.values.length;

    for (var i = 0; i < skeletonCardsCount; i++) {
      skeletonCards.add(
        const SizedBox(
          height: 60,
          width: 120,
          child: SizedBox(
            width: 320,
            height: 160,
            child: Card(),
          ),
        ),
      );
    }

    return Shimmer.fromColors(
      baseColor: Colors.grey.shade700,
      highlightColor: Colors.grey.shade800,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
            width: 200,
            child: Card(),
          ),
          SizedBox(
            height: 60,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: skeletonCards,
            ),
          ),
        ],
      ),
    );
  }
}
