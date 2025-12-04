sealed class UpdateUserEvent {}

final class SubmitUserStatus extends UpdateUserEvent {
  final String token;
  final String roomId;
  final String userPhone;
  final String userStatus;

  SubmitUserStatus({
    required this.token,
    required this.roomId,
    required this.userPhone,
    required this.userStatus,
  });
}
