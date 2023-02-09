import 'package:brew_crew/shared/loading.dart';
import '../../shared/consts.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final Function? toggleView;
  SignIn({this.toggleView});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  late String email;
  late String password;
  String errorMsg = '';
  @override
  Widget build(BuildContext context) {
    return loading?const Loading(): Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: const Text("Sign in Brew Crew"),
        actions: [
          TextButton.icon(
              onPressed: () {
                widget.toggleView!();
              },
              icon: const Icon(Icons.person),
              label: const Text("Sign up"))
        ],
      ),
      body: Container(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: "Email"),
                    validator: (value) =>
                        value!.isEmpty ? "Enter an email" : null,
                    onChanged: ((value) {
                      setState(() {
                        email = value;
                      });
                    })),
                const SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: "Password"),
                  validator: (value) =>
                      value!.length < 6 ? "Enter a 6+ long password " : null,
                  onChanged: ((value) {
                    setState(() {
                      password = value;
                    });
                  }),
                  obscureText: true,
                ),
                const SizedBox(
                  height: 20.0,
                ),
                ElevatedButton.icon(
                  icon: const Icon(Icons.login),
                  label: const Text("Login"),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll(Colors.brown[500])),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        loading=true;
                      });
                      dynamic res = await _auth.signInWithEmailAndPassword(
                          email, password);
                      if (res == null) {
                        setState(() {
                          errorMsg = "Cannot sign in with those credentials";
                          loading=false;
                        });
                      }
                    }
                  },
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Text(
                  errorMsg,
                  style: const TextStyle(color: Colors.red, fontSize: 16.0),
                ),
              ],
            ),
          )),
    );
  }
}
