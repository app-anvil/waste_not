import 'dart:async';

import 'package:a2f_sdk/a2f_sdk.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/models.dart';

part 'notification_payload_state.dart';

class NotificationPayloadCubit extends Cubit<NotificationPayloadState> {
  NotificationPayloadCubit(this._payloadMessanger)
      : super(const NotificationPayloadState.initial()) {
    _streamSubscription = _payloadMessanger.listen((message) {
      if (message != null) {
        final payload = NotificationPayload.fromJson(message);
        _emit(payload);
      }
    });
  }

  final StreamControllerHandler<Map<String, dynamic>> _payloadMessanger;

  late final StreamSubscription<Map<String, dynamic>?> _streamSubscription;

  void _emit(NotificationPayload? payload) {
    emit(state.copyWith(payload: Optional(payload)));
  }

  @override
  Future<void> close() {
    _streamSubscription.cancel();
    return super.close();
  }
}
