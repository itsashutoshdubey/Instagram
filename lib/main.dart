import 'package:flutter/material.dart';
import 'package:insta/screens/edit.dart';
import 'package:insta/screens/feed.dart';
import 'package:insta/screens/login.dart';
import 'package:insta/screens/signup.dart';
import 'package:insta/screens/profile.dart';
import 'package:insta/screens/testing.dart';
import 'package:insta/screens/userlist.dart';
import 'package:insta/screens/userlist1.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://pntfcrbtdfajmqsquslg.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InBudGZjcmJ0ZGZham1xc3F1c2xnIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjE4ODg4NzUsImV4cCI6MjAzNzQ2NDg3NX0.--8ag0Js1mdMSze3LTsRHnsIjk7ANQ1tmSGivUCIi00',
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SignUp()
    );
  }
}


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var selectedindex = 0;
  final List = [
    Feed1(),
    Userlist1(),
    Edit(),
    Upload(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: List[selectedindex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedindex,
         // backgroundColor: Colors.amber,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home, color: Colors.black,), label: 'Home',),
           // BottomNavigationBarItem(icon: Icon(Icons.search, color: Colors.black), label: 'Search'),
            BottomNavigationBarItem(icon: Icon(Icons.chat, color: Colors.black), label: 'Chat'),
            BottomNavigationBarItem(icon: Icon(Icons.upload, color: Colors.black), label: 'Upload'),
            BottomNavigationBarItem(icon: Icon(Icons.person, color: Colors.black), label: 'Profile')
          ],
        onTap: (index) {
          setState(() {
            selectedindex = index;
          });
        },
      ),
    );
  }
}


