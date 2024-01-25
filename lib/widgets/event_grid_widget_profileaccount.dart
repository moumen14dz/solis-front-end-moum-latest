import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:newproject/screens/events/event_details.dart';
import 'package:newproject/utils/colors.dart';
import 'package:newproject/utils/controllers.dart';

import '../common/constant.dart';
import '../providers/global_providers.dart';
import '../utils/requestAPIController.dart';

class EventGridWidgetAccountProfile extends ConsumerStatefulWidget {
  final String id;
  const EventGridWidgetAccountProfile({super.key, required this.id});

  @override
  ConsumerState<EventGridWidgetAccountProfile> createState() =>
      _EventGridWidgetAccountProfileState();
}

class _EventGridWidgetAccountProfileState
    extends ConsumerState<EventGridWidgetAccountProfile> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getHotestedevents();
  }

  getHotestedevents() async {
    final service = ref.watch(sharedPreferencesServiceProvider);
    String token = await service.getString(authTokenIdentifier);
    await APIRequests().getHostedEventsOfotherUser(widget.id, token: token);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      width: 400,
      child: hostedEventsOfUser.count == 0
          ? const Padding(
              padding: EdgeInsets.only(top: 18.0),
              child: Text(
                'No Events Hosted Yet!',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: textColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
            )
          : GridView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: hostedEventsOfotherUser.data != null
                  ? hostedEventsOfotherUser.data!.length
                  : 0,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1, // Set the number of items per row
              ),
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (builder) => EventDetails(
                                eventID: hostedEventsOfotherUser.data![index].id
                                    .toString(),
                                eventTitle: hostedEventsOfotherUser
                                    .data![index].title
                                    .toString())));
                  },
                  child: Container(
                    child: Stack(
                      children: [
                        Container(
                          width: 400,
                          height: 200,
                          color: const Color(0xff21252A),
                          child: Card(
                            child: Container(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: hostedEventsOfotherUser
                                            .data![index].image !=
                                        null
                                    ? Image.network(hostedEventsOfotherUser
                                        .data![index].image!)
                                    : Image.asset("assets/Masks.png"),
                              ),
                            ),
                          ),
                        ),

                        /// Positioned Container to the right bottom:
                        Positioned(
                          right: 25,
                          top:
                              10, // This will position the container at the top
                          child: Container(
                            // height: 24,
                            // width: 60,
                            padding: const EdgeInsets.all(5.0),
                            decoration: BoxDecoration(
                                color: const Color(0xff1E4697),
                                borderRadius: BorderRadius.circular(6)),
                            child: Center(
                              child: hostedEventsOfotherUser
                                          .data![index].startDate !=
                                      null
                                  ? Text(
                                      DateFormat('dd MMM').format(
                                              DateTime.parse(
                                                  hostedEventsOfotherUser
                                                      .data![index].startDate!
                                                      .toString())) +
                                          " | " +
                                          '${hostedEventsOfotherUser.data![index].price == 0 ? 'Free' : hostedEventsOfUser.data![index].price}',
                                      // "${hostedEventsOfUser.data![index].startDate!.day}  | ${hostedEventsOfUser.data![index].price == 0 ? 'Free' : hostedEventsOfUser.data![index].price}",
                                      style: const TextStyle(color: textColor),
                                      textAlign: TextAlign.center,
                                    )
                                  : const Text("N/A | Free"),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 135,
                          left: 5,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color(0xff21252A),
                            ),
                            width: MediaQuery.of(context).size.width / 1.56,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    hostedEventsOfotherUser.data![index].title!,
                                    style: const TextStyle(
                                        color: textColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
