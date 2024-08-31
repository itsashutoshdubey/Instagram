
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:insta/screens/edit.dart';
import 'package:insta/screens/feed.dart';
import 'package:insta/screens/uploadpost.dart';
import 'package:insta/screens/userlist.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Upload extends StatefulWidget {
  const Upload({super.key});

  @override
  State<Upload> createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  final supabase = Supabase.instance.client;
  @override


  void initState()  {

    super.initState();
    Fetch();
    Getpost();
  }
  String? personname;
  String? personbio;
  String? personpath;
  var data = [];


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
          body: Column(
                children:[  Row(
                  mainAxisAlignment:MainAxisAlignment.spaceAround,
                  children: [
                    const SizedBox(
                      width: 15,
                    ),
                    Column(
                      children: [
                   if(personpath!=null) CircleAvatar(
                      backgroundColor: Colors.grey,
                      radius: 60,
                       backgroundImage: NetworkImage('$personpath')
                    ) else CircleAvatar(
                       backgroundColor: Colors.grey,
                       radius: 60,
                   ),
                        Text('$personname'),
                        Text('$personbio'),
                      ]),
                    Spacer(),
                        Column(
                      children: [
                        Text('5'),
                        SizedBox(
                          height: 10,
                        ),
                        Text('Post')
                      ],
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      children: [
                        Text('120'),
                        SizedBox(
                          height: 10,
                        ),
                        Text('Followers')
                      ],
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      children: [
                        Text('50'),
                        SizedBox(
                          height: 10,
                        ),
                        Text('Following')
                      ],
                    ),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Edit(),));
                      },
                      child: Container(
                        width: double.infinity,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(50)
                        ),
                        child: const Center(child: Text('Edit Profile',
                        style: TextStyle(
                          fontSize: 20
                        ),)),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GridView.builder( shrinkWrap: true ,gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 160), itemBuilder: (context, index) {
                    final User? user = supabase.auth.currentUser;
                   if(data[index]["id"] == user!.id) return Image.network('${supabase
                       .storage
                       .from('image')
                       .getPublicUrl('${data[index]["imagepath"].substring(6)}')}', fit: BoxFit.cover,
                   );
                     else return SizedBox(height: 10,);
                  },
                  itemCount: data.length,),

                     ] ),

      ),
    );
  }

  Future<void> Fetch() async{
    final User? user = supabase.auth.currentUser;
    // List? person;

    final data = await supabase
        .from('userbio_insta')
        .select()
        .eq('id' , user!.id).single();
    print('fetched');



    setState(() {
      personname = data['name'];
      personbio = data['bio'];

     String? personpathe = 'public/${user.id}';
      final String publicUrl = supabase
          .storage
          .from('image')
          .getPublicUrl('$personpathe');
      personpath = publicUrl;
    });
    print('$personname');
  }

  Future<void> Getpost() async{
    final supabase = Supabase.instance.client;

    final User? user = supabase.auth.currentUser;
    final data1 = await supabase
        .from('post_insta')
        .select();
    setState(() {
      data = data1;
    });
    print('${data[0]["imagepath"].substring(6)}');
    print('${data[1]["imagepath"].substring(6)}');
    print('${data[2]["imagepath"].substring(6)}');
  }
  }

