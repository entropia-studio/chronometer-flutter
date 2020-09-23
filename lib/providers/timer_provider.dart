import 'dart:async';

class TimerChrono {
  final _chronoStreamController = StreamController<String>.broadcast();

  Stream<String> get timer => _chronoStreamController.stream;

  int totalSeconds = 0;
  Timer timerWatch;
  int hours, mins, secs, remain;
  String hoursString, minsString, secsString;

  play() {
    if (timerWatch == null || !timerWatch.isActive) {
      timerWatch = Timer.periodic(new Duration(seconds: 1), (timer) {
        totalSeconds++;
        remain = totalSeconds;
        hours = remain ~/ 3600;
        remain -= hours * 3600;
        mins = remain ~/ 60;
        remain -= mins * 60;
        secs = remain;

        hoursString = hours < 10 ? '0$hours' : hours.toString();
        minsString = mins < 10 ? '0$mins' : mins.toString();
        secsString = secs < 10 ? '0$secs' : secs.toString();

        final timeString = '$hoursString:$minsString:$secsString';
        _chronoStreamController.sink.add(timeString);
      });
    }
  }

  stop() {
    cancel();
    totalSeconds = 0;
    _chronoStreamController.sink.add('00:00:00');
  }

  pause() {    
    cancel();
  }

  cancel() {
    if (timerWatch != null) {
      timerWatch.cancel();
    }
  }

  dispose() {
    _chronoStreamController.close();
  }
}
