import 'dart:async';

class Debounce {
  Debounce({
    this.duration,
  });
  Duration? duration;
  Timer? timer;
  void call(void Function()? callback) {
    timer?.cancel();
    if (duration == null) {
      callback?.call();
      return;
    }
    if (callback != null) {
      timer = Timer(duration!, callback);
    }
  }

  void cancel() {
    timer?.cancel();
  }
}
