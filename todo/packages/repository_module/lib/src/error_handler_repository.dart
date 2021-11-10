import 'dart:async';

class ErrorHandlerRepository {
  final _controller = StreamController<List<dynamic>>();
  final _formController = StreamController<bool>();

  Stream<List<dynamic>> get errorMsg async* {
    await Future.delayed(const Duration(milliseconds: 300));
    yield* _controller.stream;
  }

  Stream<bool> get formStatus async* {
    await Future.delayed(const Duration(milliseconds: 300));
    _formController.add(false);
    yield* _formController.stream;
  }

  void setErrorMessage(List<dynamic> msg) {
    _controller.add(msg);
  }

  void clearErrorMessage() {
    _controller.add(['']);
  }

  void setFormStatus() {
    _formController.add(true);
  }

  void dispose() {
    _controller.close();
    _formController.close();
  }
}
