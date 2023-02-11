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

  String _curSugars='';
  String _curName='';
  int? _curStrength;

  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: loading?const Loading(): Container(
        child: Column(
          children: [
            Text("Update your brew settings"),
            const SizedBox(
              height: 20.0,
            ),
            TextFormField(
              decoration: textInputDecoration.copyWith(hintText: "Name"),
              validator: (value) => value!.isEmpty ? "Enter a name " : null,
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
            //slider
            ElevatedButton.icon(
              icon: const Icon(Icons.update),
              label: const Text("Update"),
              style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.brown[500])),
              onPressed: ()  {
                print(_curName);
                print(_curSugars);
                print(_curStrength);
              },
            ),
          ],
        ),
      ),
    );
  }
}
