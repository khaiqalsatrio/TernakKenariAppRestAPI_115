import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_115/data/model/request/auth/register_request_model.dart';
import 'package:project_115/data/repository/auth_repository.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthRepository authRepository;

  RegisterBloc({required this.authRepository}) : super(RegisterInitial()) {
    on<RegisterRequested>(_onRegisterRequested);
  }

  Future<void> _onRegisterRequested(
    RegisterRequested event,
    Emitter<RegisterState> emit,
  ) async {
    emit(RegisterLoading());
    final result = await authRepository.register(event.requestModel);

    result.fold(
      (l) {
        if (kDebugMode) {
          print("Register Failed: $l");
        }
        emit(RegisterFailure(error: l));
      },
      (r) {
        if (kDebugMode) {
          print("Register Success: $r");
        }
        emit(RegisterSuccess(message: r));
      },
    );
  }
}
