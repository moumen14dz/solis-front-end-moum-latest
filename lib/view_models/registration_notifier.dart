import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:newproject/model/registration_model.dart';
import 'package:newproject/networking/repository/registration_repository.dart';


class Params {
  late final String username;

  late final String firstName;
  late final String lastName;
  late final String bio;
  late final String email;
  late final String password;
  late final String userType;
  late final String age;
  late final String countryId;
  late final String stateId;
  late final String universityId;
  late final String programId;
  late final String associationName;
  late final String businessName;
  late final String businessAddress;
  late final String city;
  late final String postalCode;
  late final String device_token;

  Params(
      this.username,
      this.firstName,
      this.lastName,
      this.bio,
      this.email,
      this.password,
      this.userType,
      this.age,
      this.countryId,
      this.stateId,
      this.universityId,
      this.programId,
      this.associationName,
      this.businessName,
      this.businessAddress,
      this.city,
      this.postalCode,
      this.device_token);
}

// final regNotifierProvider = StateNotifierProvider
//     .family<RegistrationNotifier, AsyncValue<RegistrationModel>, Params>(
//         (ref, params) {
//       return RegistrationNotifier(
//           ref.watch(regRepositoryProvider),
//           params.firstName,
//           params.lastName,
//           params.bio,
//           params.email,
//           params.password,
//           params.userType,
//           params.age,
//           params.countryId,
//           params.stateId,
//           params.universityId,
//           params.programId,
//           params.associationName,
//           params.businessName,
//           params.businessAddress,
//           params.city,
//           params.postalCode
//       );
//     });
//
//
// class RegistrationNotifier
//     extends StateNotifier<AsyncValue<RegistrationModel>> {
//
//   final RegistrationRepository _repository;
//   late final String firstName;
//   late final String lastName;
//   late final String bio;
//   late final String email;
//   late final String password;
//   late final String userType;
//   late final String age;
//   late final String countryId;
//   late final String stateId;
//   late final String universityId;
//   late final String programId;
//   late final String associationName;
//   late final String businessName;
//   late final String businessAddress;
//   late final String city;
//   late final String postalCode;
//
//   RegistrationNotifier(this._repository, this.firstName, this.lastName,
//       this.bio, this.email, this.password, this.userType, this.age,
//       this.countryId, this.stateId, this.universityId, this.programId,
//       this.associationName, this.businessName, this.businessAddress, this.city, this.postalCode)
//       : super(const AsyncValue.loading()) {
//     attemptToRegister();
//   }
//
//   Future<void> attemptToRegister() async {
//     try {
//       state = const AsyncValue.loading();
//
//       final response = await _repository.attemptRegister(
//           firstName: firstName, lastName: lastName, bio: bio,
//           email: email, password: password, userType: userType, age: age, countryId: countryId, stateId: stateId, universityId: universityId, programId: programId,
//           associationName: associationName, businessName: businessName,
//           businessAddress: businessAddress, city: city, postalCode: postalCode);
//
//       if (mounted) {
//         if (response.isSuccess) {
//           state = AsyncValue.data(response.data!);
//         } else {
//           state = AsyncValue.error(response.errorMessage.toString(), StackTrace.current);
//         }
//       } else {
//         debugPrint("NOT_MOUNTED");
//       }
//
//     } catch (error, stackTrace) {
//       if (mounted) {
//         state = AsyncValue.error(error, stackTrace);
//       } else {
//         debugPrint("NOT_MOUNTED");
//       }
//
//     }
//   }
// }

final regNotifierProvider =
    StateNotifierProvider<RegistrationNotifier, AsyncValue<RegistrationModel>>(
        (ref) {
  return RegistrationNotifier(ref.watch(regRepositoryProvider));
});

class RegistrationNotifier
    extends StateNotifier<AsyncValue<RegistrationModel>> {
  final RegistrationRepository _repository;

  Params? params;

  RegistrationNotifier(this._repository) : super(const AsyncValue.loading());

  void setParams(Params p) {
    params = p;
  }

  Future<void> attemptToRegister() async {
    if (params == null) {
      state = AsyncValue.error('Params not set', StackTrace.current);
      return;
    }

    state = const AsyncValue.loading();

    try {
      final response = await _repository.attemptRegister(
          username: params!.username,
          firstName: params!.firstName,
          lastName: params!.lastName,
          bio: params!.bio,
          email: params!.email,
          password: params!.password,
          userType: params!.userType,
          age: params!.age,
          countryId: params!.countryId,
          stateId: params!.stateId,
          universityId: params!.universityId,
          programId: params!.programId,
          associationName: params!.associationName,
          businessName: params!.businessName,
          businessAddress: params!.businessAddress,
          city: params!.city,
          postalCode: params!.postalCode,
          device_token: params!.device_token);

      if (response.isSuccess) {
        state = AsyncValue.data(response.data!);
      } else {
        state = AsyncValue.error(
            response.errorMessage.toString(), StackTrace.current);
      }
    } catch (error, stackTrace) {
      log("dddd$error.toString()");
      state = AsyncValue.error(error, stackTrace);
    }
  }
}
