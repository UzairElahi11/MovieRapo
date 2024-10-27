import 'dart:async';

class Debouncer {
  final Duration duration;
  Function? action;

  Debouncer(
    this.duration,
  );

  void run(Function action) {
    if (this.action != null) {
      clearTimeout();
    }
    this.action = action;
    Timer(duration, performAction);
  }

  void clearTimeout() {
    if (action != null) {
      (action as Timer).cancel();
      action = null;
    }
  }

  void performAction() {
    if (action != null) {
      action!();
      action = null;
    }
  }
}
