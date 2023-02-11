import 'package:flutter/material.dart';

class BrewForm extends StatefulWidget {
  const BrewForm({super.key});

  @override
  State<BrewForm> createState() => _BrewFormState();
}

class _BrewFormState extends State<BrewForm> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key:_formKey,
      child: Container(
        child: Column(
          children: [
            Text("Update your brew settings")
          ],
        ),
      ),
    );
  }
}