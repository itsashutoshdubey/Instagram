import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:insta/screens/chat2.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Userlist1 extends StatefulWidget {
  const Userlist1({super.key});

  @override
  State<Userlist1> createState() => _Userlist1State();
}

class _Userlist1State extends State<Userlist1> {
  final supabase = Supabase.instance.client;
  var data = [];

  @override
  void initState() {
    fetch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 50,
        title: Center(
          child: Text(
            "Users",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 24,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
          child: ListView.separated(
            itemBuilder: (context, index) {
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.grey,
                  child: Text(
                    '${index + 1}',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                trailing: Icon(Icons.verified_outlined, color: Colors.blue),
                tileColor: Color(0xFFCCFF90),
                title: Text(
                  "${data[index]['email']}",
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Chat2(to: data[index]['id']),
                    ),
                  );
                },
              );
            },
            itemCount: data.length,
            separatorBuilder: (context, index) => Divider(height: 10, thickness: 1),
          ),
        ),
      ),
    );
  }

  Future<void> fetch() async {
    final supabase = Supabase.instance.client;
    final User? user = supabase.auth.currentUser;
    final data1 = await supabase
        .from('users')
        .select()
        .neq('id', user!.id);
    setState(() {
      data = data1;
    });
  }
}
