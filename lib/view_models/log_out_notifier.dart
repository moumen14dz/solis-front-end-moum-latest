import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:newproject/model/logout_model.dart';
import 'package:newproject/networking/repository/logout_repository.dart';

final logOutNotifierProvider = StateNotifierProvider.autoDispose
    .family<LogOutNotifier, AsyncValue<LogoutResponseModel>, String>(
        (ref, params) {
      return LogOutNotifier(
          ref.watch(logOutRepositoryProvider),
         params,
      );
    });


class LogOutNotifier
    extends StateNotifier<AsyncValue<LogoutResponseModel>> {

  final LogOutRepository _repository;
  late final String bearerToken;

  LogOutNotifier(this._repository,this.bearerToken)
      : super(const AsyncValue.loading()) {
    attemptToLogOut();
  }

  Future<void> attemptToLogOut() async {
    try {
      state = const AsyncValue.loading();

      final response = await _repository.attemptLogOut(bearerToken: bearerToken);

      if (response.isSuccess) {
        state = AsyncValue.data(response.data!);
      } else {
        state = AsyncValue.error(response.errorMessage.toString(), StackTrace.current);
      }
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
}