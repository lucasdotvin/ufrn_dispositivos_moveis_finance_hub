import 'package:finance_hub/component/bitcoin/list.dart';
import 'package:finance_hub/provider/finance.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Carousel extends StatelessWidget {
  const Carousel({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _Title(),
        SizedBox(
          height: 126,
          child: CarouselList(),
        ),
      ],
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<FinanceDataProvider>(
      builder: (context, financeDataProvider, _) {
        return Padding(
          padding:
              const EdgeInsets.only(left: 12, right: 12, top: 10, bottom: 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Bitcoin nas Principais Corretoras',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              if (financeDataProvider.isLoading)
                SizedBox(
                  width: 14,
                  height: 14,
                  child: CircularProgressIndicator(
                    color: Colors.teal.shade700,
                    strokeWidth: 2,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
