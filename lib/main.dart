import 'package:chronometer/providers/timer_provider.dart';
import 'package:flutter/material.dart';

void main() => runApp(Chronometer());

class Chronometer extends StatefulWidget {
  @override
  _ChronometerState createState() => _ChronometerState();
}

class _ChronometerState extends State<Chronometer> {
  bool isRunning = false;
  final timerChrono = new TimerChrono();

  @override
  Widget build(BuildContext context) {
    final mainFontStyle = TextStyle(fontSize: 50);

    if (isRunning) {
      timerChrono.play();
    } else {
      timerChrono.pause();
    }

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
                  return Text(
                    snapshot.data.toString(),
                    style: mainFontStyle,
                  );
                } else {
                  return Text('00:00:00', style: mainFontStyle);
                }
              },
            ),
          ),
        ),
        floatingActionButton: _getButtons(),
      ),
    );
  }

  Widget _getButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FloatingActionButton(
          backgroundColor: Colors.redAccent,
          child: Icon(Icons.stop),
          onPressed: () {
            timerChrono.stop();
            setState(() {
              isRunning = false;
            });
          },
        ),
        SizedBox(width: 30),
        isRunning
            ? FloatingActionButton(                
                child: Icon(Icons.pause),
                onPressed: () {
                  setState(() {
                    isRunning = false;
                  });
                },
              )
            : FloatingActionButton(
                child: Icon(Icons.play_arrow),
                onPressed: () {
                  setState(() {
                    isRunning = true;
                  });
                },
              )
      ],
    );
  }
}
