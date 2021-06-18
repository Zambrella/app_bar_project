import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverPersistentHeader(
              pinned: true,
              delegate: MyCustomAppBar(maxHeight: 200.0, actionButtons: [
                CustomIcon(icon: Icons.share),
                CustomIcon(icon: Icons.notifications_active),
              ]),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                List.generate(
                  20,
                  (index) => ListTile(
                    title: Text('Number $index'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

final image1 = 'https://liquipedia.net/commons/images/thumb/c/c0/Virtus.pro_2019_allmode.png/612px-Virtus.pro_2019_allmode.png';
final image2 = 'https://ggscore.com/media/logo/t1.png';

class MyCustomAppBar extends SliverPersistentHeaderDelegate {
  const MyCustomAppBar({required this.maxHeight, this.actionButtons});

  final double maxHeight;

  final List<CustomIcon>? actionButtons;
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    var topOpacity = max(0.0, (1 - shrinkOffset * 2 / (maxExtent)));

    // print('Shrink Offset: $shrinkOffset');

    return Container(
      color: Colors.grey,
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.antiAlias,
        fit: StackFit.expand,
        children: [
          //* Action buttons
          Align(
            alignment: Alignment.topCenter,
            child: Row(
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
          //* Upper text
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Opacity(
                opacity: topOpacity,
                child: const TopSection(),
              ),
            ),
          ),
          //* Team Info
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                // color: Colors.blue,
                height: kToolbarHeight * topOpacity,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(image1),
                          ),
                        ),
                      ),
                    ),
                    Opacity(
                      opacity: topOpacity,
                      child: Container(
                        height: 30 * topOpacity,
                        color: Colors.green,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Container(
                            padding: EdgeInsets.all(4.0),
                            child: Center(
                              child: Text('Virtus Pro'),
                            ),
                          ),
                        ),
                      ),
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

class TeamInfo extends StatelessWidget {
  const TeamInfo({required this.teamName, required this.side, required this.image, required this.opacity, required this.offset, Key? key})
      : super(key: key);

  final String teamName;
  final String side;
  final String image;
  final double opacity;
  final double offset;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ConstrainedBox(
          constraints: BoxConstraints.tightFor(
            height: max(kToolbarHeight, 100 * opacity + offset),
          ),
          child: FittedBox(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Image(
                image: NetworkImage(image),
              ),
            ),
          ),
        ),
        // Padding(
        //   padding: const EdgeInsets.all(8.0),
        //   child: Container(
        //     decoration: BoxDecoration(
        //       image: DecorationImage(
        //         fit: BoxFit.contain,
        //         image: NetworkImage(image),
        //       ),
        //     ),
        //   ),
        // ),
        Flexible(
          child: Opacity(
            opacity: opacity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Text(
                    teamName,
                    style: TextStyle(fontSize: 12.0),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(2.0),
                  color: side == 'Radiant' ? Colors.green : Colors.red,
                  child: Center(
                    child: Text(
                      side,
                      style: TextStyle(fontSize: 12.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class TopSection extends StatelessWidget {
  const TopSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Live'),
        Text('Best of 3, LB Round 1'),
        Divider(
          thickness: 2,
        )
      ],
    );
  }
}

class CustomIcon extends StatelessWidget {
  const CustomIcon({required this.icon, this.onPressed, Key? key}) : super(key: key);

  final IconData icon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: const EdgeInsets.all(0),
      icon: Icon(icon),
      onPressed: onPressed,
    );
  }
}
