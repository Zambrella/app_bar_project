import 'package:flutter/material.dart';

class TopSection extends StatelessWidget {
  const TopSection({required this.bestOf, required this.round, Key? key}) : super(key: key);

  final int bestOf;
  final String round;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: kToolbarHeight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(
            height: 2,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Live',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                'Best of $bestOf, $round',
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
          Container(
            width: double.infinity,
            height: 2,
            color: Colors.red,
          ),
        ],
      ),
    );
  }
}
