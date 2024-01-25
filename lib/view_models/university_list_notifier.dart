import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:newproject/networking/repository/university_list_repository.dart';

import '../model/universities_model.dart';


const String TAG = "UniversityListNotifier";

final universityListNotifierProvider = StateNotifierProvider<UniversityListNotifier, AsyncValue<UniversitiesModel>>(
        (ref) {
      return UniversityListNotifier(
        ref.watch(universityListRepositoryProvider),
      );
    });


class UniversityListNotifier
    extends StateNotifier<AsyncValue<UniversitiesModel>> {

  final UniversityListRepository _repository;
  late final String email, password;

  UniversityListNotifier(this._repository)
      : super(const AsyncValue.loading()) {
    getListOfUniversities();
  }

  Future<void> getListOfUniversities() async {
    try {
      state = const AsyncValue.loading();

      final response = await _repository.getListOfUniversities();

      if (response.isSuccess) {
        state = AsyncValue.data(response.data!);
        debugPrint("$TAG : 01");
      } else {
        debugPrint("$TAG : 05");
        state = AsyncValue.error(response.errorMessage.toString(), StackTrace.current);
      }
    } catch (error, stackTrace) {
      debugPrint("$TAG : $error : 10");
      state = AsyncValue.error(error, stackTrace);
    }
  }
}