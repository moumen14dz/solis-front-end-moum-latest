import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:newproject/model/log_in_model.dart';
import 'package:newproject/networking/repository/log_in_repository.dart';

class Params {
  late final String email;
  late final String password;
  late final String? device_token;

  Params(this.email, this.password,this.device_token);
}

final logInNotifierProvider = StateNotifierProvider.autoDispose
<LogInNotifier, AsyncValue<LoginResponseModel>>(
        (ref) {
      return LogInNotifier(
          ref.watch(logInRepositoryProvider)
      );
    });

class LogInNotifier
    extends StateNotifier<AsyncValue<LoginResponseModel>> {

  final LogInRepository _repository;
  Params? params;

  LogInNotifier(this._repository)
      : super(const AsyncValue.loading());

  void setParams(Params p) {
    params = p;
  }

  Future<void> attemptToRegister() async {
    if (!mounted) return;  // Return early if not mounted

    if (params == null) {
      state = AsyncValue.error('Params not set', StackTrace.current);
      return;
    }

    try {
      state = const AsyncValue.loading();

      final response = await _repository.attemptLogIn(email: params!.email, password: params!.password, device_token:params!.device_token!);

      if (mounted) {  // Check again before setting state
        if (response.isSuccess) {
          state = AsyncValue.data(response.data!);
        } else {
          state = AsyncValue.error(response.errorMessage.toString(), StackTrace.current);
        }
      }
    } catch (error, stackTrace) {
      if (mounted) {  // Check again before setting state
        state = AsyncValue.error(error, stackTrace);
      }
    }
  }
}
