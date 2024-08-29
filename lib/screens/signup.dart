import 'package:flutter/material.dart';
import 'package:insta/main.dart';
import 'package:insta/screens/login.dart';
import 'package:insta/screens/userlist.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final supabase = Supabase.instance.client;
  final emailcontroller = TextEditingController();

  final passwordcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        body: SingleChildScrollView(
          child: SafeArea(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
          
                    const SizedBox(height: 50),
          
                    // logo
                    const Icon(
                      Icons.lock,
                      size: 100,
                    ),
          
                    const SizedBox(height: 50),
          
                    // welcome, you've been missed!
                    Text(
                      'Welcome, we were waiting for you',
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 16,
                      ),
                    ),
          
                    const SizedBox(height: 25),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: TextField(
                        controller: emailcontroller,
                        decoration: InputDecoration(
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey.shade400),
                            ),
                            fillColor: Colors.grey.shade200,
                            filled: true,
                            hintText: 'enter e-mail',
                            hintStyle: TextStyle(color: Colors.grey[500])),
                      ),
                    ),
          
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: TextField(
                        controller: passwordcontroller,
                        obscureText: true,
                        decoration: InputDecoration(
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey.shade400),
                            ),
                            fillColor: Colors.grey.shade200,
                            filled: true,
                            hintText: 'create password',
                            hintStyle: TextStyle(color: Colors.grey[500])),
                      ),
                    ),
          
                    const SizedBox(height: 10),
          
                    // forgot password?
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "already have a account?",
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          ElevatedButton(onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage(),));
                          }, child: Text('Login')),
                        ],
                      ),
                    ),
          
          
          
                    const SizedBox(height: 25),
          
                    InkWell(
                      onTap: ()async{

                        final AuthResponse response = await supabase.auth.signUp(
                          email: emailcontroller.text,
                          password: passwordcontroller.text,
                        );
                        final Session? session = response.session;
                        final User? user = response.user;
                        print('registered');
                      },
                      child: Container(
                        padding: const EdgeInsets.all(25),
                        margin: const EdgeInsets.symmetric(horizontal: 25),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child:  Center(
                          child: InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(),));
                            },
                            child: Text(
                              "Sign Up",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
          
                    const SizedBox(height: 50),
                  ],
                ),
              )),
        )
    );
  }
}
