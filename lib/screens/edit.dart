import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:insta/main.dart';
import 'package:insta/screens/profile.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Edit extends StatefulWidget {
  const Edit({super.key});

  @override
  State<Edit> createState() => _EditState();
}

class _EditState extends State<Edit> {
  final supabase = Supabase.instance.client;
  TextEditingController name = TextEditingController();
  TextEditingController bio = TextEditingController();
  File? file;
  String? profilepath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white70,
        title: Icon(Icons.edit),
        actions: [
          ElevatedButton(onPressed: ()async{
          //  await supabase
            //    .from('userbio')
              //  .insert({'name': name.text, 'bio': bio.text, 'profilepath': profilepath});

            await supabase
                .from('userbio_insta')
                .upsert({ 'name': name.text, 'bio': bio.text, 'profilepath': profilepath });

            print('added to table');
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage(),));
          }, child: Text('Apply')),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 25),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: TextField(
              controller: name,
              decoration: InputDecoration(
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade400),
                  ),
                  fillColor: Colors.grey.shade200,
                  filled: true,
                  hintText: 'enter name',
                  hintStyle: TextStyle(color: Colors.grey[500])),
            ),
          ),
          const SizedBox(height: 25),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: TextField(
              controller: bio,
              decoration: InputDecoration(
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade400),
                  ),
                  fillColor: Colors.grey.shade200,
                  filled: true,
                  hintText: 'enter bio',
                  hintStyle: TextStyle(color: Colors.grey[500])),
            ),
          ),
          file==null? TextButton(onPressed: ()async{
           XFile? photo = await ImagePicker().pickImage(source: ImageSource.gallery);
           if(photo!=null)
             {
               setState(() {
                 file = File(photo.path);
                 print('file');
               });
             }
           if(file!=null)
             {

               final User? user = supabase.auth.currentUser;
               final profilepic = File(file!.path);
               final String fullPath = await supabase.storage.from('image').upload(
                 'public/${user!.id}',
                 profilepic,
                 fileOptions: const FileOptions(upsert: true),
               );
               print('bucket');
               setState(() {
                 profilepath = fullPath;
               });
              print('$profilepath');
             }
          }, child: Text('upload image', style: TextStyle( color: Colors.blue),)): Image.file(File(file!.path)),
        ],
      ),
    );
  }
}
