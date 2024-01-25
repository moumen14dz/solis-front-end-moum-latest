import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:newproject/networking/repository/state_list_repository.dart';

import '../model/state_list_model.dart';

final stateListNotifierProvider = StateNotifierProvider.autoDispose
    .family<StateListNotifier, AsyncValue<StateListModel>, int>(
        (ref, countryId) {
      return StateListNotifier(
        ref.watch(stateListRepositoryProvider),
        countryId,
      );
    });


class StateListNotifier
    extends StateNotifier<AsyncValue<StateListModel>> {

  final StateListRepository _repository;
  late final int countryId;

  StateListNotifier(this._repository,this.countryId)
      : super(const AsyncValue.loading()) {
    fetchStateList();
  }

  Future<void> fetchStateList() async {
    try {
      state = const AsyncValue.loading();

      final response = await _repository.getListOfStateByCountryId(countryId: countryId);

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