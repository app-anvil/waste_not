import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import 'state_status.dart';

@immutable
abstract class SuperBlocState extends Equatable {
  final String? errorMessage;
  final StateStatus status;

  const SuperBlocState({
    required this.status,
    required this.errorMessage,
  }) : assert(
          status == StateStatus.failure && errorMessage != null ||
              status != StateStatus.failure && errorMessage == null,
          'When status is failure, errorMessage must be not null and vice '
          'versa.',
        );

  const SuperBlocState.initial()
      : this(
          status: StateStatus.initial,
          errorMessage: null,
        );

  SuperBlocState copyWith({required StateStatus status});

  SuperBlocState copyWithError(String errorMessage);

  @override
  @mustCallSuper
  List<Object?> get props => [status, errorMessage];

  @override
  bool? get stringify => false;
}
