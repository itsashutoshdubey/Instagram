import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Feed1 extends StatefulWidget {
  const Feed1({super.key});

  @override
  State<Feed1> createState() => _Feed1State();
}

class _Feed1State extends State<Feed1> {
  final supabase = Supabase.instance.client;

  @override
  void initState() {
    Getpost();
    super.initState();
  }

  var data = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Instagram',
          style: TextStyle(color: Colors.black, fontFamily: 'Billabong', fontSize: 32),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite_border, color: Colors.black),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.send, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  leading: CircleAvatar(
                      backgroundColor: Colors.grey,
                      backgroundImage: NetworkImage('${supabase.storage.from('image').getPublicUrl('${data[index]["profile_image"]}')}')
                  ),
                  title: Text('${data[index]["id"]}', style: TextStyle(fontWeight: FontWeight.bold)),
                  trailing: Icon(Icons.more_horiz),
                ),
                Container(
                  width: double.infinity,
                  height: 400,
                  child: Image.network(
                    '${supabase.storage.from('image').getPublicUrl('${data[index]["imagepath"].substring(6)}')}',
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('${data[index]["caption"]}', style: TextStyle(fontSize: 16)),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.favorite_border),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: Icon(Icons.chat_bubble_outline),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: Icon(Icons.send),
                        onPressed: () {},
                      ),
                      Spacer(),
                      IconButton(
                        icon: Icon(Icons.bookmark_border),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> Getpost() async {
    final supabase = Supabase.instance.client;
    final data1 = await supabase.from('post_insta').select();
    setState(() {
      data = data1;
    });
    print('${data[0]["imagepath"].substring(6)}');
  }
}
