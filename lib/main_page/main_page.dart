import 'package:age_guesser/main_page/main_page_bloc.dart';
import 'package:flutter/material.dart';

class MainPageWidget extends StatefulWidget {
  const MainPageWidget({super.key});

  @override
  State<MainPageWidget> createState() => _MainPageWidgetState();
}

class _MainPageWidgetState extends State<MainPageWidget> {
  final MainPageBloc bloc = MainPageBloc();
  final editingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    bloc.textFieldValueModifyStream.listen((newContent) {
      editingController.text = newContent;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            decoration: const InputDecoration(
                border: OutlineInputBorder(), labelText: 'Vorname'),
            controller: editingController,
          ),
          Row(
            children: [
              TextButton(
                  onPressed: () {
                    bloc.formSubmitted(editingController.text);
                  },
                  child: const Text('Alter herausfinden')),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: StreamBuilder(
                    builder: (context, snapshot) => snapshot.data == true
                        ? const CircularProgressIndicator()
                        : Container(),
                    stream: bloc.loadingStream,
                  ),
                ),
              )
            ],
          ),
          AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: StreamBuilder(
                builder: (context, snapshot) {
                  var text = snapshot.data;
                  if (text != null) {
                    return Text(
                      text,
                      style: const TextStyle(fontSize: 20),
                    );
                  } else {
                    return Container();
                  }
                },
                stream: bloc.resultStream,
                initialData: null,
              )),
          AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: StreamBuilder(
                builder: (context, snapshot) {
                  var text = snapshot.data;
                  if (text != null) {
                    return Text(
                      text,
                      style: const TextStyle(color: Colors.red, fontSize: 20),
                    );
                  } else {
                    return Container();
                  }
                },
                stream: bloc.errorStream,
                initialData: null,
              ))
        ],
      ),
    );
  }
}
