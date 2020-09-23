import 'package:chronometer/providers/timer_provider.dart';
import 'package:flutter/material.dart';

void main() => runApp(Chronometer());

class Chronometer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final timerChrono = new TimerChrono();
    final mainFontStyle = TextStyle(
      fontSize: 50
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chronometer App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Chronometer App'),
          centerTitle: true,
        ),
        body: Center(
          child: Container(
            child: StreamBuilder(
              stream: timerChrono.timer,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(snapshot.data.toString(), style: mainFontStyle,);
                } else {
                  return Text('00:00:00', style: mainFontStyle);
                }
              },
            ),
          ),
        ),
        floatingActionButton: _getButtons(timerChrono),
      ),
    );
  }

  Widget _getButtons(TimerChrono timerChrono) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FloatingActionButton(
          child: Icon(Icons.stop),
          onPressed: () {
            timerChrono.stop();
          },
        ),
        SizedBox(width: 30),
        FloatingActionButton(
          child: Icon(Icons.play_arrow),
          onPressed: () {
            print('play');
            timerChrono.play();
          },
        ),
        SizedBox(width: 30),
        FloatingActionButton(
          child: Icon(Icons.pause),
          onPressed: () {
            timerChrono.pause();
          },
        ),
      ],
    );
  }
}
