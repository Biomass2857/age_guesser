import 'package:age_guesser/main_page/main_page.dart';
import 'package:flutter/material.dart';

class ScaffoldWrapperWidget extends StatelessWidget {
  const ScaffoldWrapperWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: const Text("Age Guesser"),
      ),
      body: const MainPageWidget(),
    ));
  }
}
