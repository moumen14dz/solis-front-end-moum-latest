import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:newproject/model/countries_model.dart';
import 'package:newproject/networking/repository/country_list_repository.dart';


final countryListNotifierProvider = StateNotifierProvider<CountryListNotifier, AsyncValue<CountriesModel>>(
        (ref) {
      return CountryListNotifier(
          ref.watch(countryListRepositoryProvider),
      );
    });


class CountryListNotifier
    extends StateNotifier<AsyncValue<CountriesModel>> {

  final CountryListRepository _repository;
  late final String email, password;

  CountryListNotifier(this._repository)
      : super(const AsyncValue.loading()) {
    getListOfCountries();
  }

  Future<void> getListOfCountries() async {
    try {
      state = const AsyncValue.loading();

      final response = await _repository.getListOfCountries();

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