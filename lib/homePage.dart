import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(tabs: [
              Tab(text: 'Cat'),
              Tab(text: 'Dogg'),
            ]),
          ),
          body: const TabBarView(
            children: <Widget>[
              Center(
                child: Text("It's cloudy here"),
              ),
              Center(
                child: Text("It's rainy here"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
