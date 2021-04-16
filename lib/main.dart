import 'dart:io';
import 'package:beatz/song_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_file_manager/flutter_file_manager.dart';
import 'package:path_provider_ex/path_provider_ex.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ChooseTrack(),
      // home: MusicApp(),
    );
  }
}

class ChooseTrack extends StatefulWidget {
  @override
  _ChooseTrackState createState() => _ChooseTrackState();
}

class _ChooseTrackState extends State<ChooseTrack> {
  var files;

  void getFiles() async { 
    List<StorageInfo> storageInfo = await PathProviderEx.getStorageInfo();
    var root = storageInfo[0].rootDir; 
    var fm = FileManager(root: Directory(root)); 
    files = await fm.filesTree(
        excludedPaths: ["/storage/emulated/0/Android"],
        extensions: ["mp3"] 
    );
    setState(() {}); 
  }

  @override
  void initState() {
    getFiles();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title:Center(child: Text("Tracks",style: TextStyle(color: Colors.deepOrange),)),
            backgroundColor: Colors.black
        ),
        body:files == null? Container(color: Colors.black,child: Center(child: Text("No Files Found",style: TextStyle(color: Colors.white)))):
        Container(
          color: Colors.black,
          child: ListView.builder( 
            itemCount: files?.length ?? 0,
            itemBuilder: (context, index) {
              return Card(
                color: Colors.deepOrange,
                  child:ListTile(
                    title: Text(files[index].path.split('/').last,style: TextStyle(color: Colors.black),),
                    leading: CircleAvatar(backgroundImage: AssetImage("assets/headphone.png"),),
                    trailing: Icon(Icons.play_arrow, color: Colors.black,),
                    onTap: (){

                      Navigator.push(context, MaterialPageRoute(builder: (context) => MusicApp(song: files[index])));                    
                    },
                  )
              );
            },
          ),
        )
    );
  }
}

// void lol(){
//   print("hello");
// }
