import 'package:brew_crew/models/user.dart';
import 'package:brew_crew/services/databaseService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../shared/consts.dart';
import '../../shared/loading.dart';

class BrewForm extends StatefulWidget {
  const BrewForm({super.key});

  @override
  State<BrewForm> createState() => _BrewFormState();
}

class _BrewFormState extends State<BrewForm> {
  final _formKey = GlobalKey<FormState>();

  final List<String> sugarList = ['0', '1', '2', '3', '4'];

  String? _curSugars;
  String? _curName;
  int? _curStrength;

  bool loading = false;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return StreamBuilder<Object>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data as UserData;
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
                              initialValue: _curName ?? userData.name,
                              decoration: textInputDecoration.copyWith(
                                  hintText: "Name"),
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
                                value: _curSugars ?? userData.sugars,
                                decoration: textInputDecoration.copyWith(
                                    hintText: "Sugars"),
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

                            Row(
                              children: [
                                Container(width: 60, child: Text("Strength: ")),
                                Expanded(
                                  child: Slider(
                                      value: (_curStrength ?? userData.strength)
                                          .toDouble(),
                                      activeColor: Colors.brown[_curStrength ??
                                          userData
                                              .strength], //the color of the left side of the slider(active)
                                      inactiveColor: Colors.brown[_curStrength ??
                                          userData
                                              .strength], //the color of the right side of the slider(inactive)
                                      min: 100,
                                      max: 900,
                                      divisions:
                                          8, //the division must be right to get hundreds
                                      onChanged: ((value) {
                                        setState(() {
                                          _curStrength = value.round();
                                        });
                                      })),
                                ),
                              ],
                            ),
                            ElevatedButton.icon(
                              icon: const Icon(Icons.update),
                              label: const Text("Update"),
                              style: ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(
                                      Colors.brown[500])),
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  await DatabaseService(uid: user.uid)
                                      .updateUserData(
                                          _curSugars ?? userData.sugars, //use the current value if there is no new value
                                          _curName ?? userData.name,
                                          _curStrength ?? userData.strength);
                                  Navigator.pop(context);
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
            );
          } else {
            return Loading();
          }
        });
  }
}
