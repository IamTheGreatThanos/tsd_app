import 'dart:async';

import 'package:flutter/material.dart';

///Custom timer widget
class CallTimer extends StatefulWidget {
  const CallTimer({Key? key}) : super(key: key);

  @override
  _CallTimerState createState() => _CallTimerState();
}

class _CallTimerState extends State<CallTimer> {
  Duration duration = Duration();
  Timer? timer;

  void initState() {
    startTimer();
    super.initState();
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) => addTime());
  }

  void addTime() {
    final addSeconds = 1;
    if (!mounted) return;
    setState(() {
      final seconds = duration.inSeconds + addSeconds;
      duration = Duration(seconds: seconds);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.38),
              borderRadius: BorderRadius.circular(10)),
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          child: Text(
            "${showTime(duration.inHours..remainder(24))}:${showTime(duration.inMinutes.remainder(60))}:${showTime(duration.inSeconds.remainder(60))}",
            style: const TextStyle(
                fontSize: 14, color: Colors.white, fontWeight: FontWeight.w400),
          ),
        )
      ],
    );
  }

  String showTime(int time) {
    return time.toString().padLeft(2, '0');
  }

  Widget buildTime(int time) {
    return Text(showTime(time));
    //     return Container(
    //       decoration: BoxDecoration(
    //           color: Colors.white.withOpacity(0.38),
    //           borderRadius: BorderRadius.circular(10)),
    //       padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
    //       child: Text(
    //         displayTime,
    //         style: const TextStyle(
    //             fontSize: 14,
    //             color: Colors.white,
    //             fontWeight: FontWeight.w400),
    //       ),
    //     );
  }
}
