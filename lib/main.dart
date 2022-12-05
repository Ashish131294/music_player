import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music_player/secondpage.dart';
import 'package:on_audio_query/on_audio_query.dart';

void main() {
  runApp(MaterialApp(
    home: demo(),
  ));
}

class demo extends StatefulWidget {
  const demo({Key? key}) : super(key: key);

  @override
  State<demo> createState() => _demoState();
}

class _demoState extends State<demo> {
  //List allsongs=[];

  OnAudioQuery _audioQuery = OnAudioQuery();

  Future<List<SongModel>> getallsongs() async {
    List<SongModel> allsongs = await _audioQuery.querySongs();
    return allsongs;

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Music Player"),
      ),
      body: FutureBuilder(future: getallsongs(),builder: (context, snapshot) {
        if(snapshot.connectionState==ConnectionState.done)
          {
        List<SongModel> songs=snapshot.data as List<SongModel>;
            return ListView.builder(itemCount: songs.length,itemBuilder: (context, index) {
              SongModel s=songs[index];
              return ListTile(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return secondpage(songs,index);
                  },));
                },
                title: Text("${s.title}"),
                subtitle: Text("${s.duration}"),
              );
            },);
          }
        else
          {
            return Center(child: CircularProgressIndicator(),);
          }
      },),
    );
  }
}
