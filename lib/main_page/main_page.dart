import 'package:flutter/material.dart';

class MainPageWidget extends StatefulWidget {
  const MainPageWidget({super.key});

  @override
  State<MainPageWidget> createState() => _MainPageWidgetState();
}

class _MainPageWidgetState extends State<MainPageWidget> {
  String? _resultString;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(
                border: OutlineInputBorder(), labelText: 'Vorname'),
            onChanged: (value) => print("input $value"),
            onSubmitted: (value) {
              print("input submitted $value");
            },
          ),
          TextButton(
              onPressed: () {
                print("submit");
                setState(() {
                  _resultString = "dein name ";
                });
              },
              child: Text('Alter herausfinden')),
          AnimatedSwitcher(
            duration: Duration(seconds: 2),
            child:
                _resultString == null ? Container() : Text(_resultString ?? ""),
          )
        ],
      ),
    );
  }
}
