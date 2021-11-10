part of 'exception_cubit.dart';

abstract class ExceptionState extends Equatable {}

class ExceptionInitial extends ExceptionState {
  @override
  List<Object?> get props => [];
}

class ExceptionMessage extends ExceptionState {
  final List<dynamic> message;

  ExceptionMessage(this.message);

  @override
  List<Object> get props => [message];
}

class FormStatusState extends ExceptionState {
  final bool status;

  FormStatusState(this.status);

  @override
  List<Object?> get props => [status];
}
