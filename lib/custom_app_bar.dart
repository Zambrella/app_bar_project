import 'dart:math';

import 'package:app_bar_project/custom_icon.dart';
import 'package:app_bar_project/top_section.dart';
import 'package:flutter/material.dart';

import 'main.dart';

final image1 = 'https://liquipedia.net/commons/images/thumb/c/c0/Virtus.pro_2019_allmode.png/612px-Virtus.pro_2019_allmode.png';
final image2 = 'https://ggscore.com/media/logo/t1.png';

class MyCustomAppBar extends SliverPersistentHeaderDelegate {
  const MyCustomAppBar({required this.maxHeight, this.actionButtons});

  final double maxHeight;

  final List<CustomIcon>? actionButtons;
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    var topOpacity = max(0.0, (1 - shrinkOffset * 2 / (maxExtent)));
    // When fully expanded, value = 0. When fully closed, value = 1.0
    var animationCompletion = shrinkOffset / maxHeight;
    // When fully expanded, value = 0. When it appears it's fully closed (but techinically isn't), value = 1.0
    var partialAnimationCompletion = min(1.0, shrinkOffset / (maxHeight - kToolbarHeight));

    // print('Shrink Offset: $shrinkOffset');
    print('Top opacity: $topOpacity');
    // print('Animation completion: $animationCompletion');
    // print('Partial animation complete: $partialAnimationCompletion');

    return Container(
      color: Color(0xff303030),
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.antiAlias,
        fit: StackFit.expand,
        children: [
          //* Action buttons
          Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              height: kToolbarHeight,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back_outlined)),
                  Expanded(
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [...?actionButtons],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Opacity(
              opacity: topOpacity,
              child: Container(
                margin: const EdgeInsets.only(top: kToolbarHeight),
                height: double.infinity,
                width: 0.3,
                color: Colors.grey,
              ),
            ),
          ),
          //* Upper text
          Align(
            alignment: Alignment.topCenter,
            child: Opacity(
              opacity: topOpacity,
              child: const TopSection(
                bestOf: 3,
                round: 'LB Round 1',
              ),
            ),
          ),
          //* Team Info
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: kToolbarHeight * topOpacity,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          SizedBox(
                            width: 80 * partialAnimationCompletion,
                          ),
                          //* Left image
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(16.0 - partialAnimationCompletion * 4),
                              child: Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(image1),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          //* Score
                          Row(
                            children: [
                              Container(
                                height: 25,
                                width: 5 * partialAnimationCompletion,
                                color: raidantGreen,
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                                height: 30,
                                color: Colors.grey[100],
                                child: Center(
                                  child: Text(
                                    '12 - 32',
                                    style: TextStyle(
                                      color: Color(0xff303030),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                height: 25,
                                width: 5 * partialAnimationCompletion,
                                color: direRed,
                              ),
                            ],
                          ),
                          //* Right image
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(16.0 - partialAnimationCompletion * 4),
                              child: Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(image2),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 80 * partialAnimationCompletion,
                          ),
                        ],
                      ),
                    ),
                    //* Team names
                    Opacity(
                      opacity: topOpacity,
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 25 * topOpacity,
                              color: raidantGreen,
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Container(
                                  padding: EdgeInsets.all(4.0),
                                  child: Center(
                                    child: Text(
                                      'Virtus Pro',
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              height: 25 * topOpacity,
                              color: direRed,
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Container(
                                  padding: EdgeInsets.all(4.0),
                                  child: Center(
                                    child: Text(
                                      'Vici Gaming',
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 0.5,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
