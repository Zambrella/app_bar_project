import 'package:app_bar_project/custom_app_bar.dart';
import 'package:app_bar_project/custom_icon.dart';
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
        brightness: Brightness.dark,
        primarySwatch: Colors.red,
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
