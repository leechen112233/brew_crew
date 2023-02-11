import 'package:flutter/material.dart';

import '../../shared/consts.dart';
import '../../shared/loading.dart';

class BrewForm extends StatefulWidget {
  const BrewForm({super.key});

  @override
  State<BrewForm> createState() => _BrewFormState();
}

class _BrewFormState extends State<BrewForm> {
  final _formKey = GlobalKey<FormState>();

  final List<int> sugarList = [0, 1, 2, 3, 4];

  String _curSugars = '';
  String _curName = '';
  int? _curStrength;

  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: loading
          ? const Loading()
          : Container(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 20.0, horizontal: 40.0),
                child: Column(
                  children: [
                    Text("Update your brew settings"),
                    const SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      decoration:
                          textInputDecoration.copyWith(hintText: "Name"),
                      validator: (value) =>
                          value!.isEmpty ? "Enter a name " : null,
                      onChanged: ((value) {
                        setState(() {
                          _curName = value;
                        });
                      }),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    //drop down
                    DropdownButtonFormField(
                        decoration:
                            textInputDecoration.copyWith(hintText: "Sugars"),
                        items: sugarList.map((e) {
                          return DropdownMenuItem(
                              value: e, child: Text('$e sugar(s)'));
                        }).toList(),
                        onChanged: ((value) {
                          setState(() {
                            _curSugars = '$value';
                          });
                        })),
                    //slider
                    Slider(
                        value: (_curStrength ?? 100).toDouble(),
                        activeColor: Colors.brown[_curStrength ?? 100], //the color of the left side of the slider(active)
                        inactiveColor: Colors.brown[_curStrength ?? 100],//the color of the right side of the slider(inactive)
                        min: 100,
                        max: 900,
                        divisions:8, //the division must be right to get hundreds
                        onChanged: ((value) {
                          setState(() {
                            _curStrength = value.round();
                          });
                        })),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.update),
                      label: const Text("Update"),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.brown[500])),
                      onPressed: () {
                        print(_curName);
                        print(_curSugars);
                        print(_curStrength);
                      },
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
