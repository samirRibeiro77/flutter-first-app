import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class ExecMedia extends StatelessWidget {
  const ExecMedia({super.key});

  final title = "Executando midias";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: title,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: MyHomePage(title: title),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _audioPlayer = AudioPlayer();
  dynamic _source;
  var _firstPlay = true;
  var _playing = false;
  var _volume = 0.5;

  _playAudio() async {
    _audioPlayer.setVolume(_volume);
    setState(() {
      _playing = true;
    });

    if (_firstPlay) {
      // _source = UrlSource("https://www.soundhelix.com/examples/mp3/SoundHelix-Song-8.mp3");
      _source = AssetSource("audios/musica.mp3");
      await _audioPlayer.play(_source);
      _firstPlay = false;
    } else {
      _audioPlayer.resume();
    }
  }

  _pauseAudio() async {
    setState(() {
      _playing = false;
    });
    await _audioPlayer.pause();
  }

  _stopAudio() async {
    _firstPlay = true;
    setState(() {
      _playing = false;
    });
    await _audioPlayer.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        //Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title, style: TextStyle(color: Colors.white)),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              "Volume"
            ),
            Slider(
              min: 0,
              max: 1,
              divisions: 10,
              value: _volume,
              onChanged: (newVolume) {
                setState(() {
                  _volume = newVolume;
                });
                _audioPlayer.setVolume(newVolume);
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.all(16),
                  child: GestureDetector(
                    onTap: () {
                      if (_playing) {
                        _pauseAudio();
                      } else {
                        _playAudio();
                      }
                    },
                    child: _playing
                        ? Image.asset("assets/images/executandoMidia/pausar.png")
                        : Image.asset("assets/images/executandoMidia/executar.png"),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(16),
                  child: GestureDetector(
                    onTap: _stopAudio,
                    child: Image.asset("assets/images/executandoMidia/parar.png"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
