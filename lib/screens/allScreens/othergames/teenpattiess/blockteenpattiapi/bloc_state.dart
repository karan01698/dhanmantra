sealed class UpdateUserState {}

final class UpdateInitial extends UpdateUserState {}

final class UpdateLoading extends UpdateUserState {}

final class UpdateSuccess extends UpdateUserState {
  final String message;
  UpdateSuccess(this.message);
}

final class UpdateError extends UpdateUserState {
  final String error;
  UpdateError(this.error);
}
