import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:newproject/screens/events/event_details.dart';
import 'package:newproject/utils/colors.dart';
import 'package:newproject/utils/controllers.dart';


class EventGridWidgetProfile extends StatefulWidget {
  const EventGridWidgetProfile({super.key});

  @override
  State<EventGridWidgetProfile> createState() => _EventGridWidgetProfileState();
}

class _EventGridWidgetProfileState extends State<EventGridWidgetProfile> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      width: 400,
      child: hostedEventsOfUser.count == 0
          ? const Padding(
              padding: EdgeInsets.only(bottom: 40.0),
              child: Center(
                child: Text(
                  'No Events Hosted Yet!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: textColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
              ))
          : GridView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: hostedEventsOfUser.data!.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: 10, mainAxisSpacing: 20,
                crossAxisCount: 1, // Set the number of items per row
              ),
              itemBuilder: (BuildContext context, int index) {
                // hostedEventsOfUser.data !=
                //     null ? hostedEventsOfUser.data!.sort((a, b) => DateFormat('dd MMM')
                //     .parse(a.startDate.toString())
                //     .compareTo(DateFormat('dd MMM').parse(b.startDate.toString()))):'';
                return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (builder) => EventDetails(
                                eventID: hostedEventsOfUser.data![index].id
                                    .toString(),
                                eventTitle: hostedEventsOfUser
                                    .data![index].title
                                    .toString())));
                  },
                  child: Container(
                    child: Stack(
                      children: [
                        CachedNetworkImage(
                          imageUrl: hostedEventsOfUser.data![index].image!,
                          imageBuilder: (context, imageProvider) => Container(
                            // height: 200,
                            //width: 400,
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(30)),
                              shape: BoxShape.rectangle,
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                                // colorFilter: ColorFilter.mode(
                                //   Colors.red, BlendMode.colorBurn)
                              ),
                            ),
                          ),
                          placeholder: (context, url) => Image.asset(
                            "assets/Masks.png",
                            //height: 400,
                            // width: 400,
                          ),
                          errorWidget: (context, url, error) => Image.asset(
                            "assets/Masks.png",
                            //   height: 400,
                            // width: 400,
                          ),
                        ),

                        /// Positioned Container to the right bottom:
                        Positioned(
                          right: 10,
                          top:
                              10, // This will position the container at the top
                          child: Container(
                            // height: 24,
                            // width: 60,
                            padding: const EdgeInsets.all(5.0),
                            decoration: BoxDecoration(
                                color: const Color(0xff1E4697).withOpacity(.7),
                                borderRadius: BorderRadius.circular(6)),
                            child: Center(
                              child: hostedEventsOfUser
                                          .data![index].startDate !=
                                      null
                                  ? Text(
                                      DateFormat('dd MMM').format(
                                              DateTime.parse(hostedEventsOfUser
                                                  .data![index].startDate!
                                                  .toString())) +
                                          " | " +
                                          '${hostedEventsOfUser.data![index].price == 0 ? 'Free' : hostedEventsOfUser.data![index].price}',
                                      // "${hostedEventsOfUser.data![index].startDate!.day}  | ${hostedEventsOfUser.data![index].price == 0 ? 'Free' : hostedEventsOfUser.data![index].price}",
                                      style: const TextStyle(color: textColor),
                                      textAlign: TextAlign.center,
                                    )
                                  : const Text("N/A | Free"),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 5,
                          left: 5,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color(0xff21252A).withOpacity(.5),
                            ),
                            width: MediaQuery.of(context).size.width / 1.56,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    hostedEventsOfUser.data![index].title!,
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
