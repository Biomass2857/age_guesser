import 'dart:async';

import 'package:age_guesser/service/agify_service.dart';

class MainPageBloc {
  void formSubmitted(String name) {
    _nameInputStreamController.add(name);
  }

  Stream<String> get resultStream => _resultStreamController.stream;
  Stream<bool> get loadingStream => _showsLoadingIndicator.stream;

  final _resultStreamController = StreamController<String>();
  final _nameInputStreamController = StreamController<String>();
  final _showsLoadingIndicator = StreamController<bool>();

  MainPageBloc() {
    _nameInputStreamController.stream.listen((name) {
      _showsLoadingIndicator.sink.add(true);
      _executeAgifyRequest(name);
    });
  }

  void _executeAgifyRequest(String name) {
    AgifyApiService().getAgeForName(name).then((ageResult) {
      _resultStreamController.sink.add(
          'dein Alter wird aufgrund deines Namens auf ${ageResult.age} geschätzt');
      _showsLoadingIndicator.sink.add(false);
    });
  }
}
