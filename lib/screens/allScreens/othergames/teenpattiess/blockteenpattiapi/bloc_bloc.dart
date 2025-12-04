import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sattagames/screens/allScreens/othergames/teenpattiess/blockteenpattiapi/user_repository.dart';

import 'bloc_event.dart';
import 'bloc_state.dart';


class UpdateUserBloc extends Bloc<UpdateUserEvent, UpdateUserState> {
  final UserRepository repository;

  UpdateUserBloc(this.repository) : super(UpdateInitial()) {
    on<SubmitUserStatus>(_onSubmit);
  }

  Future<void> _onSubmit(
      SubmitUserStatus event,
      Emitter<UpdateUserState> emit,
      ) async {
    emit(UpdateLoading());
    try {
      final message = await repository.updateUserStatus(
        token: event.token,
        roomId: event.roomId,
        userPhone: event.userPhone,
        userStatus: event.userStatus,
      );
      emit(UpdateSuccess(message));
    } catch (e) {
      emit(UpdateError(e.toString()));
    }
  }
}
