

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Feed extends StatefulWidget {
  const Feed({super.key});

  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  final supabase = Supabase.instance.client;
  @override
  void initState() {
    Getpost();
    // TODO: implement initState
    super.initState();
  }
  var data = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // appBar: AppBar(backgroundColor: Colors.white,
      //actions: [
        //Row(
          //children: [
           // Text('Instagram', style: TextStyle(color: Colors.black),),
           // Spacer(),
            //Icon(Icons.heart_broken_sharp, color: Colors.black,)
          //],
        //)
      //],),
      body: ListView.builder(itemBuilder: (context, index) {
        return Card(
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.grey,
                  ),
                  Text('${data[index]["id"]}'),
                  Spacer(),
                  Icon(Icons.more_horiz)
                ],
              ),
              Container(
                width: double.infinity,
                height: 400,
                color: Colors.amber,
                child: Image.network('${supabase
            .storage
            .from('image')
            .getPublicUrl('${data[0]["imagepath"].substring(6)}')}', fit: BoxFit.cover,
              ),
              ),
              Text('${data[index]["caption"]}'),
              Row(
                children: [
                  Icon(Icons.favorite_border),
                  Icon(Icons.chat),
                  Icon(Icons.share),
                  Spacer(),
                  Icon(Icons.bookmark_border)
                ],
              )
            ],
          ),
        );
          //Container(
          //width: 50,
          //height: 50,
          //color: Colors.amber,
          //child: Text('${data[index]["caption"]}'),
        //);

      },
        itemCount: data.length ,
      ) ,
    );
  }

  Future<void> Getpost() async{
    final supabase = Supabase.instance.client;

    final User? user = supabase.auth.currentUser;
    final data1 = await supabase
        .from('post')
        .select();
    setState(() {
      data = data1;
    });
    print('${data[0]["imagepath"].substring(6)}');
}}