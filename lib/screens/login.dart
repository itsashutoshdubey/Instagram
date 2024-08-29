import 'package:flutter/material.dart';
import 'package:insta/main.dart';
import 'package:insta/screens/chat2.dart';
import 'package:insta/screens/edit.dart';
import 'package:insta/screens/feed.dart';
import 'package:insta/screens/profile.dart';
import 'package:insta/screens/signup.dart';
import 'package:insta/screens/userlist.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final supabase = Supabase.instance.client;
  // text editing controllers
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

                    // welcome back, you've been missed!
                    Text(
                      'Welcome back you\'ve been missed!',
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
                            hintText: 'enter password',
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
                            "Don't have a account?",
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          ElevatedButton(onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp(),));
                          }, child: Text('Register')),
                        ],
                      ),
                    ),



                    const SizedBox(height: 25),

                    InkWell(
                      onTap: ()async{

                        final AuthResponse res = await supabase.auth.signInWithPassword(
                          email: emailcontroller.text,
                          password: passwordcontroller.text,
                        );
                        final Session? session = res.session;
                        final User? user = res.user;
                        print('logged in');
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> HomePage(),));
                      },
                      child: Container(
                        padding: const EdgeInsets.all(25),
                        margin: const EdgeInsets.symmetric(horizontal: 25),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Center(
                          child: Text(
                            "Sign In",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 50),
                  ],
                ),
              )),
        ));
  }
}
