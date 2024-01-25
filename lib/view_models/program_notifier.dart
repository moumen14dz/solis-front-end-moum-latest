import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:newproject/model/programs_model.dart';
import 'package:newproject/networking/repository/program_repository.dart';


final programNotifierProvider = StateNotifierProvider<ProgramNotifier, AsyncValue<ProgramsModel>>(
        (ref) {
      return ProgramNotifier(
        ref.watch(programsRepositoryProvider),
      );
    });


class ProgramNotifier
    extends StateNotifier<AsyncValue<ProgramsModel>> {

  final ProgramsRepository _repository;
  late final String email, password;

  ProgramNotifier(this._repository)
      : super(const AsyncValue.loading()) {
    getListOfCountries();
  }

  Future<void> getListOfCountries() async {
    try {
      state = const AsyncValue.loading();

      final response = await _repository.getListOfPrograms();

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