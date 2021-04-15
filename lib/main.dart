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
  // This widget is the root of your application.
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

  void getFiles() async { //asyn function to get list of files
    List<StorageInfo> storageInfo = await PathProviderEx.getStorageInfo();
    var root = storageInfo[0].rootDir; //storageInfo[1] for SD card, geting the root directory
    var fm = FileManager(root: Directory(root)); //
    files = await fm.filesTree(
        excludedPaths: ["/storage/emulated/0/Android"],
        extensions: ["mp3"] //optional, to filter files, list only mp3 files
    );
    setState(() {}); //update the UI
  }

  @override
  void initState() {
    getFiles(); //call getFiles() function on initial state.
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
          child: ListView.builder(  //if file/folder list is grabbed, then show here
            itemCount: files?.length ?? 0,
            itemBuilder: (context, index) {
              return Card(
                color: Colors.deepOrange,
                  child:ListTile(
                    title: Text(files[index].path.split('/').last,style: TextStyle(color: Colors.black),),
                    leading: CircleAvatar(backgroundImage: AssetImage("assets/headphone.png"),),
                    trailing: Icon(Icons.play_arrow, color: Colors.black,),
                    onTap: (){

                      Navigator.push(context, MaterialPageRoute(builder: (context) => MusicApp(song: files[index])));                      // you can add Play/push code over here
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