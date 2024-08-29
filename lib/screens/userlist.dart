import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:insta/screens/chat2.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Userlist extends StatefulWidget {
  const Userlist({super.key});

  @override
  State<Userlist> createState() => _UserlistState();
}

class _UserlistState extends State<Userlist> {
  final supabase = Supabase.instance.client;
  var data = [];
  @override
  void initState() {
    fetch();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // backgroundColor: Colors.black,
        appBar: AppBar(backgroundColor: Colors.white, toolbarHeight: 20, title: Container(child: Center(child: Text("User", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black), )))),
      body:
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(30))
            ),

            child: ListView.separated(itemBuilder: (context, index) {
              return ListTile(
                leading: Text('${index+1}'),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),),
                trailing: Icon(Icons.verified_outlined),
                tileColor:  Color(0xFFCCFF90),
                title: Text("${data[index]['email']}", style: TextStyle(color: Colors.black),),
                onTap: (){
                 Navigator.push(context, MaterialPageRoute(builder: (context) => Chat2(to: data[index]['id']),));
                },
              );

                 }, itemCount: data.length ,
              separatorBuilder: (context, index) => Divider(height: 10, thickness: 5,),
            ),
                  ),
          ),
    );
  }


Future<void>fetch () async{
  final supabase = Supabase.instance.client;

  final User? user = supabase.auth.currentUser;
  final data1 = await supabase
      .from('users')
      .select().neq('id', user!.id );
  setState(() {
    data = data1;
  });

}
}

