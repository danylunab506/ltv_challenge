import 'package:flutter/material.dart';

import 'widgets/articles_list.dart';
import 'widgets/map_widget.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.newspaper)),
                Tab(icon: Icon(Icons.map_sharp)),
              ],
            ),
            title: const Text(
              'LTV Challenge',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
          body: const TabBarView(
            children: [
              ArticlesList(),
              MapWidget(),
            ],
          ),
        ),
      ),
    );
  }
}