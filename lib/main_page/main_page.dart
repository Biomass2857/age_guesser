import 'package:age_guesser/service/agify_service.dart';
import 'package:flutter/material.dart';

class MainPageWidget extends StatefulWidget {
  const MainPageWidget({super.key});

  @override
  State<MainPageWidget> createState() => _MainPageWidgetState();
}

class _MainPageWidgetState extends State<MainPageWidget> {
  String? _resultString;
  String currentName = '';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            decoration: const InputDecoration(
                border: OutlineInputBorder(), labelText: 'Vorname'),
            onChanged: (value) => currentName = value,
          ),
          TextButton(
              onPressed: () {
                AgifyApiService().getAgeForName(currentName).then((ageResult) {
                  setState(() {
                    _resultString =
                        'dein Alter wird aufgrund deines Namens auf ${ageResult.age} geschätzt';
                  });
                });
              },
              child: const Text('Alter herausfinden')),
          AnimatedSwitcher(
            duration: const Duration(seconds: 2),
            child:
                _resultString == null ? Container() : Text(_resultString ?? ""),
          )
        ],
      ),
    );
  }
}
