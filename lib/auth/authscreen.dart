import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todoapp/auth/authFunctions.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formkey = GlobalKey<FormState>();
  var _email = '';
  var _password = '';
  bool isloginPage = false;
  bool istoggler = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: const Text("Authentication")
      //   ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 60,
              ),
              const Text(
                "Welcome",
                style: TextStyle(fontSize: 50, color: Colors.blue),
              ),
              const SizedBox(
                height: 30,
              ),
              Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter email';
                          }

                          return null;
                        },
                        onSaved: (value) {
                          setState(() {
                            _email = value!;
                          });
                        },
                        decoration: InputDecoration(
                            labelText: 'Email',
                            labelStyle: GoogleFonts.roboto(),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            )),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        obscuringCharacter: '*',
                        obscureText: (istoggler ? true : false),
                        keyboardType: TextInputType.visiblePassword,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter password';
                          }
                          if (value.length < 8) {
                            return "Minimum length should be 8";
                          }

                          return null;
                        },
                        onSaved: (value) {
                          setState(() {
                            _password = value!;
                          });
                        },
                        decoration: InputDecoration(
                            labelText: 'Password',
                            labelStyle: GoogleFonts.roboto(),
                            suffixIcon: IconButton(
                              icon: Icon(istoggler
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined),
                              onPressed: () {
                                setState(() {
                                  istoggler = !istoggler;
                                });
                              },
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            )),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 50,
                        width: double.maxFinite,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          onPressed: () {
                            if (_formkey.currentState!.validate()) {
                              _formkey.currentState!.save();
                            }
                            isloginPage
                                ? logIn(_email, _password, context)
                                : signUp(_email, _password, context);
                          },
                          child: isloginPage
                              ? const Text(
                                  "Login",
                                  style: TextStyle(fontSize: 20),
                                )
                              : const Text(
                                  "SignUp",
                                  style: TextStyle(fontSize: 20),
                                ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextButton(
                          onPressed: () {
                            setState(() {
                              isloginPage = !isloginPage;
                            });
                          },
                          child: isloginPage
                              ? const Text(
                                  "Create new account",
                                  style: TextStyle(fontSize: 20),
                                )
                              : const Text(
                                  "Already have an account ?",
                                  style: TextStyle(fontSize: 20),
                                ))
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
