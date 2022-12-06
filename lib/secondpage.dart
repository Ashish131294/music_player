import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query_platform_interface/details/on_audio_query_helper.dart';

class secondpage extends StatefulWidget {
  List<SongModel> songs;
  int index;

  secondpage(this.songs, this.index);

  @override
  State<secondpage> createState() => _secondpageState();
}

class _secondpageState extends State<secondpage> {
  final player = AudioPlayer();
  double current_time = 0;
  bool play = false;

  @override
  void initState() {
    super.initState();
    print(widget.songs[widget.index]);
    player.onPositionChanged.listen((Duration p) {
      print('Current position: $p');
      setState(() {
        current_time = p.inMilliseconds.toDouble();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Song List"),
      ),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("${widget.songs[widget.index].title}"),
        ),
        Slider(
          min: 0,
          max: widget.songs[widget.index].duration!.toDouble(),
          value: current_time,
          onChanged: (value) async {
            await player.seek(Duration(milliseconds: value.toInt()));
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: () async {
                    if (play) {
                      await player.stop();
                    } else {
                      String path = widget.songs[widget.index].data;
                      await player.play(DeviceFileSource(path));
                    }
                    setState(() {
                      play = !play;
                      widget.index--;
                    });
                  },
                  child: Icon(Icons.arrow_back_ios)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: () async {
                    if (play) {
                      await player.pause();
                    } else {
                      String path = widget.songs[widget.index].data;
                      await player.play(DeviceFileSource(path));
                    }
                    setState(() {
                      play = !play;
                    });
                  },
                  child: play ? Icon(Icons.pause) : Icon(Icons.play_arrow)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: () async {
                    if (play) {
                      await player.stop();
                    } else {
                      String path = widget.songs[widget.index].data;
                      await player.play(DeviceFileSource(path));
                    }

                    setState(() {
                      play = !play;
                      widget.index++;
                    });
                  },
                  child: Icon(Icons.arrow_forward_ios)),
            ),
          ],
        )
      ]),
    );
  }
}
