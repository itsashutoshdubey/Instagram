import 'package:flutter/material.dart';
import 'package:insta/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Chat2 extends StatefulWidget {
  var to;
   Chat2({super.key, required this.to });

  @override
  State<Chat2> createState() => _Chat2State();
}

 class _Chat2State extends State<Chat2> {
  late DBService _dbService;
  final supabase = Supabase.instance.client;

  @override
  void initState() {
    _dbService = DBService();
    // TODO: implement initState
    super.initState();

  }


  TextEditingController message = TextEditingController();
  @override

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:  Scaffold(
       // backgroundColor: secondaryButtonColor,
       // appBar: AppBar(backgroundColor: Theme.of(context).primaryColor, title: Text('${widget.to}'),),
        body:  SingleChildScrollView(
          physics: const ScrollPhysics() ,
          child: Column(
            children: [
             // TextField(
               // controller: message,
              //),
          Container(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          height: 70.0,
          color: Colors.white,
          child: Row(
            children: <Widget>[
              TextButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(),));
              } , child: Icon(Icons.cancel)),
              IconButton(
                icon: Icon(Icons.photo),
                iconSize: 25.0,
                color: Colors.blueAccent,
                onPressed: (){},
              ),
              Expanded(
                child: TextField(
                  controller:  message,
                  onChanged: (value) {},
                  decoration: InputDecoration.collapsed(
                    hintText: 'Send a message...',
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.send),
                iconSize: 25.0,
                color: Colors.blueAccent,
                onPressed: ()async {
                  await supabase
                      .from('chat_insta')
                      .insert({'message': message.text, 'to': widget.to});
                  message.clear();
                },
              ),
            ],
          ),
        ),
              //ElevatedButton(onPressed: ()async{
          
                //await supabase
                  //  .from('chat_2')
                  //  .insert({'message': message.text, 'to':}, child: const Text('send')),
              StreamBuilder(stream: _dbService.getAllItems(), builder: (context, snapshot) {

                final User? user = supabase.auth.currentUser;
                if(snapshot.hasData && snapshot.data != null){
                  var data = snapshot.data ?? [];
                  return ListView.builder(itemBuilder: (context, index) {
                    if(data[index]["to"] == user!.id && data[index]["id"] == widget.to) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 8, bottom: 8, right: 200,),
                        child: Card(
                          color: Colors.white,
                          child:  Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(data[index]["message"],),
                          ),
                      ),
                      );
                    }
                    if(data[index]["id"] == user.id && data[index]["to"]== widget.to ) {
                      return  Padding(
                        padding: const EdgeInsets.only(top: 8, bottom: 8, left: 200,),
                        child: Card(
                          color: Colors.greenAccent,
                         // alignment:Alignment.centerLeft ,
                          child:  Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(data[index]["message"]),
                          ),
                        ),
                      );
                    } else {
                      return const SizedBox(height: 2,);
                    }
                  },
                    itemCount: data.length,
                    reverse: true,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                  );

                }
                return const Text('abhay');
              }
              ),
          ],
                ),
        ),
      )
      );

  }
}


class DBService {
  late SupabaseClient client;

  DBService() {
    client = Supabase.instance.client;
  }
  Stream getAllItems() {
    return client.from("chat_insta").stream(primaryKey: ["id"]);
  }
}

