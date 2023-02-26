import 'dart:async';

import 'package:age_guesser/service/agify_service.dart';

class MainPageBloc {
  void formSubmitted(String name) {
    _nameInputStreamController.add(name);
  }

  Stream<String?> get resultStream => _resultStreamController.stream;
  Stream<bool> get loadingStream => _showsLoadingIndicator.stream;
  Stream<String> get textFieldValueModifyStream =>
      _textFieldValueModifyStreamController.stream;
  Stream<String?> get errorStream => _errorStreamController.stream;

  final _resultStreamController = StreamController<String?>();
  final _nameInputStreamController = StreamController<String>();
  final _textFieldValueModifyStreamController = StreamController<String>();
  final _errorStreamController = StreamController<String?>();
  final _showsLoadingIndicator = StreamController<bool>();

  MainPageBloc() {
    _nameInputStreamController.stream.listen((name) {
      _showsLoadingIndicator.sink.add(true);
      _resetOutput();
      _executeAgifyRequest(name)
          .whenComplete(() => _showsLoadingIndicator.sink.add(false));
    });
  }

  void _clearText() {
    _textFieldValueModifyStreamController.sink.add("");
  }

  void _resetOutput() {
    _errorStreamController.sink.add(null);
    _resultStreamController.sink.add(null);
  }

  Future<void> _executeAgifyRequest(String name) {
    return AgifyApiService().getAgeForName(name).then((ageResult) {
      _resultStreamController.sink.add(
          '${ageResult.name}: dein Alter wird auf ${ageResult.age} Jahre geschätzt.');
    }).catchError((error) {
      _handleAgifyApiError(error);
    }, test: (error) => error is AgifyApiError).catchError((unknownError) {
      _handleUnkownError();
    }).whenComplete(() => _clearText());
  }

  void _handleAgifyApiError(AgifyApiError error) {
    var message = '';
    switch (error) {
      case AgifyApiError.nameNotInDatabase:
        message = "Der Name konnte nicht gefunden werden.";
        break;
      case AgifyApiError.tooManyRequests:
        message =
            "Zu viele Anfragen an die Agify Datenbank für heute. - Probier es morgen nochmal";
        break;
      case AgifyApiError.unknownError:
        message = "Ein unbekannter Agify Fehler ist aufgetreten.";
        break;
    }

    _errorStreamController.sink.add(message);
  }

  void _handleUnkownError() {
    _errorStreamController.sink.add("Ein unbekannter Fehler ist aufgetreten.");
  }
}
