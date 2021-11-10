import 'dart:async';

import 'dart:developer';

class ErrorHandler {
  final StreamController<List<dynamic>> _controller =
      StreamController<List<dynamic>>.broadcast();

  Stream<List<dynamic>> get errorMsg async* {
    log('checking');
    // await Future<void>.delayed(const Duration(seconds: 1));
    yield [];
    yield* _controller.stream;
  }

  void setErrorMessage(List<dynamic> msg) {
    log('hndler msg: $msg');
    _controller.add(msg);
  }

  void dispose() {
    _controller.close();
  }
}
