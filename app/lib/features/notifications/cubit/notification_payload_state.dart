part of 'notification_payload_cubit.dart';

final class NotificationPayloadState extends Equatable {
  const NotificationPayloadState._(this.payload);

  const NotificationPayloadState.initial() : payload = null;

  final NotificationPayload? payload;

  NotificationPayloadState copyWith({
    Optional<NotificationPayload?> payload = const Optional.absent(),
  }) {
    return NotificationPayloadState._(
      payload.orElseIfAbsent(this.payload),
    );
  }

  @override
  List<Object?> get props => [payload];
}
