import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:repository_module/repository_module.dart';

part 'exception_state.dart';

class ExceptionCubit extends Cubit<ExceptionState> {
  late StreamSubscription<List<dynamic>> _errorStreamSubscription;
  late StreamSubscription<bool> _formStatusStreamSubscription;

  final ErrorHandlerRepository _errorHandlerRepository;
  ExceptionCubit(ErrorHandlerRepository errorHandlerRepository)
      : _errorHandlerRepository = errorHandlerRepository,
        super(ExceptionInitial()) {
    _monitorErrorMsg();
    _monitorFormStatus();
  }

  StreamSubscription<List<dynamic>> _monitorErrorMsg() {
    return _errorStreamSubscription = _errorHandlerRepository.errorMsg.listen(
      (event) {
        emit(
          ExceptionMessage(event),
        );
      },
    );
  }

  StreamSubscription<bool> _monitorFormStatus() {
    return _formStatusStreamSubscription =
        _errorHandlerRepository.formStatus.listen(
      (status) {
        if (status) {
          emit(
            FormStatusState(status),
          );
        }
      },
    );
  }

  @override
  Future<void> close() {
    _errorStreamSubscription.cancel();
    _formStatusStreamSubscription.cancel();
    _errorHandlerRepository.dispose();

    return super.close();
  }
}
