import 'package:common_components/src/core/bloc_state/bloc_state.dart';
import 'package:equatable/equatable.dart';

abstract class SuperBlocState extends Equatable {
  const SuperBlocState({
    required this.status,
    this.errorMessage,
  });

  const SuperBlocState.initial()
      : status = StateStatus.initial,
        errorMessage = null;

  final StateStatus status;
  final String? errorMessage;

  SuperBlocState copyWith({StateStatus? status});

  SuperBlocState copyWithError(String errorMessage);

  bool get hasError => errorMessage != null;

  @override
  List<Object?> get props => [status, errorMessage];
}
