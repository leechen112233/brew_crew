import 'package:brew_crew/shared/loading.dart';
import '../../shared/consts.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  final Function? toggleView;
  SignUp({this.toggleView});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  late String email;
  late String password;
  String errorMsg = '';
  @override
  Widget build(BuildContext context) {
    return loading
        ? const Loading()
        : Scaffold(
            backgroundColor: Colors.brown[100],
            appBar: AppBar(
              backgroundColor: Colors.brown[400],
              elevation: 0.0,
              title: const Text("Sign up Brew Crew"),
              actions: [
                TextButton.icon(
                    onPressed: () {
                      widget.toggleView!();
                    },
                    icon: Icon(Icons.person),
                    label: Text("Sign in"))
              ],
            ),
            body: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                        image: AssetImage('assets/coffee_bg.png'))),
                padding: const EdgeInsets.symmetric(
                    vertical: 20.0, horizontal: 50.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                          decoration:
                              textInputDecoration.copyWith(hintText: "Email"),
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
                        decoration:
                            textInputDecoration.copyWith(hintText: "Password"),
                        validator: (value) => value!.length < 6
                            ? "Enter a 6+ long password "
                            : null,
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
                        icon: const Icon(Icons.add),
                        label: const Text("Signup"),
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.brown[500])),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              loading = true;
                            });
                            dynamic res = await _auth
                                .signUpWithEmailAndPassword(email, password);
                            if (res == null) {
                              setState(() {
                                errorMsg = "Cannot sign up";
                                loading = false;
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
                        style:
                            const TextStyle(color: Colors.red, fontSize: 16.0),
                      ),
                    ],
                  ),
                )),
          );
  }
}
