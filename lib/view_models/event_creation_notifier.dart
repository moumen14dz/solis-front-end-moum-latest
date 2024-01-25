import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:newproject/utils/requestAPIController.dart';

import '../model/eventcreationModel.dart';
import '../networking/repository/event_creation_list.dart';
import '../screens/dashboard/main_dashboard.dart';
import '../utils/buttons.dart';
import '../utils/colors.dart';

class Params1 {
  // late final int id;
  // late final String guid;
  late final int categoryId;
  late final int userId;
  late final int countryId;
  late final int neighborhoodId;
  late final int universityId;
  late final int programId;
  late final String title;
  late final String description;
  late final String image;
  late final String startDate;
  late final String startTime;
  late final String endDate;
  late final String endTime;
  late final String price;
  late final String ageMin;
  late final String ageMax;
  late final bool limitEntrance;
  late final String entranceLimitMin;
  late final String entranceLimitMax;
  // // late final  dynamic accountFollow;
  late final String location;
  late final int city;

  late final String latitude;
  late final String longitude;
  late final bool publicEvent;
  late final bool forFollowers;
  late final String freeTitle;
  late final String freeDescription;
  late final String freeQuantity;
  late final String paidTitle;
  late final String paidDescription;
  late final String paidQuantity;
  late final List<Map<String, dynamic>> tickets;
  late final String is_redirected;
  late final String ticketing_link;

  // late final int featured;
  // late final String status;
  // DateTime createdAt;
  // DateTime updatedAt;
  // late final  List<Ticket> tickets;

  Params1(
      // this.id,
      // this.guid,
      this.categoryId,
      this.userId,
      this.countryId,
      // this.neighborhoodId,
      this.universityId,
      this.programId,
      this.title,
      this.description,
      this.image,
      this.startDate,
      this.endDate,
      this.startTime,
      this.endTime,
      this.price,
      this.ageMin,
      this.ageMax,
      this.limitEntrance,
      this.entranceLimitMin,
      this.entranceLimitMax,
      // this.accountFollow,
      this.city,
      this.location,
      this.latitude,
      this.longitude,
      this.publicEvent,
      this.forFollowers,
      this.freeTitle,
      this.freeDescription,
      this.freeQuantity,
      this.paidTitle,
      this.paidDescription,
      this.paidQuantity,
      // this.featured,
      // this.status,
      //  this.createdAt,
      //  this.updatedAt,
      this.tickets,
      this.is_redirected,
      this.ticketing_link);
  // Params(
//     this.title,
//     this.description,
//     this.startDate,
//     this.categoryId,
//     this.location,
//     this.latitude,
//     this.longitude,
//     this.price,
//     this.image,
//     this.limitEntrance,
//     this.entranceLimitMin,
//     this.entranceLimitMax,
//     this.publicEvent,
//     this.forFollowers,
//     this.universityId,
//     this.programId,
//     this.ageMin,
//     this.ageMax,
//     this.countryId,

//     );
}

final eventcreationNotifierProvider = StateNotifierProvider.family<
    EventCreationNotifier,
    AsyncValue<EventResponseModel>,
    String>((ref, paramss) {
  return EventCreationNotifier(
    ref.watch(eventRepositoryProvider),
    paramss,
  );
});

class EventCreationNotifier
    extends StateNotifier<AsyncValue<EventResponseModel>> {
  final EventCreationRepository _repository;
  late final String bearerToken;
  Params1? params;

  EventCreationNotifier(this._repository, this.bearerToken)
      : super(const AsyncValue.loading());

  void setParams(Params1 p) {
    params = p;
  }

  Future<void> createEvents(context) async {
    if (params == null) {
      state = AsyncValue.error('Params not set', StackTrace.current);
      return;
    }

    state = const AsyncValue.loading();
    log("bearerToken$bearerToken");
    log("bearerTokenparam${params!.city.toString()}");

    try {
      final response = await _repository.createEvents(
          bearerToken: "bearer$bearerToken",
          userId: params!.userId,
          categoryId: params!.categoryId,
          countryId: params!.countryId,
          // neighborhoodId: params!.neighborhoodId,
          universityId: params!.universityId,
          programId: params!.programId,
          title: params!.title,
          description: params!.description,
          image: params!.image,
          startDate: params!.startDate,
          endDate: params!.endDate,
          startTime: params!.startTime,
          endTime: params!.endTime,
          price: params!.price,
          ageMin: params!.ageMin,
          ageMax: params!.ageMax,
          limitEntrance: params!.limitEntrance,
          minEntrance: params!.entranceLimitMin,
          maxEntrance: params!.entranceLimitMax,
          city: params!.city,
          location: params!.location,
          latitude: params!.latitude,
          longitude: params!.longitude,
          publicEvent: params!.publicEvent,
          forFollowers: params!.forFollowers,
          freeTitle: params!.freeTitle,
          freeDescription: params!.freeDescription,
          freeQunatity: params!.freeQuantity,
          paidTitle: params!.paidTitle,
          paidDescription: params!.paidDescription,
          paidQunatity: params!.paidQuantity,
          tickets: params!.tickets,
          is_redirected: params!.is_redirected,
          ticketing_link: params!.ticketing_link);

      if (response.isSuccess) {
        await APIRequests().getHostedEventsOfUser(token: bearerToken);
        await APIRequests().allFutureEvents(token: bearerToken);
        await APIRequests().eventsOfCurrentWeek(token: bearerToken);
        alert(context);

        print('Successfully Updated State!');
        state = AsyncValue.data(response.data!);
      } else {
        state = AsyncValue.error(
            response.errorMessage.toString(), StackTrace.current);
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              backgroundColor: const Color(0xff21252A),
              title: const Text(
                "Validation Error",
                style: TextStyle(
                    color: textColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w400),
                textAlign: TextAlign.center,
              ),
              content: SingleChildScrollView(
                child: Text(
                  response.errorMessage.toString(),
                  style: const TextStyle(
                      color: textColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w400),
                  textAlign: TextAlign.center,
                ),
              ),
              actions: <Widget>[
                SaveButton(
                    title: "OK",
                    onTap: () {
                      Navigator.pop(context);
                    })
              ],
            );
          },
        );
      }
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  void alert(context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xff21252A),
          title: const Text(
            'CONGRATULATIONS!',
            style: TextStyle(
                color: textColor, fontSize: 20, fontWeight: FontWeight.w400),
            textAlign: TextAlign.center,
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Image.asset('assets/Group.png'),
                const SizedBox(
                  height: 9,
                ),
                const Text(
                  'You have publish the event successfully!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: textColor,
                      fontWeight: FontWeight.w400,
                      fontSize: 12),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            SaveButton(
                title: "Close",
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MainScreen(
                              token: true,
                              currentIndexOfMainScreenBottomBar: 0)));
                  // Navigator.pop(context);
                })
          ],
        );
      },
    );
  }
}

//-----------------------------Alert-----------------------------

