import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  final Function? toggleView;
  SignUp({this.toggleView});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  late String email;
  late String password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: const Text("Sign up Brew Crew"),
        actions: [
          TextButton.icon(onPressed: (){
            widget.toggleView!();
          }, icon: Icon(Icons.person), label: Text("Sign in"))
        ],
      ),
      body: Container(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: Form(
            child: Column(
              children: [
                const SizedBox(
                  height: 20.0,
                ),
                TextFormField(onChanged: ((value) {
                  setState(() {
                    email = value;
                  });
                })),
                const SizedBox(
                  height: 20.0,
                ),
                TextFormField(
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
                  style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.brown[500])),
                  onPressed: () async {
                    print(email);
                    print(password);
                  },
                )
              ],
            ),
          )),
    );
  }
}