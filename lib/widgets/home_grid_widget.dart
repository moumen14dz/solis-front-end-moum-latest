import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:newproject/model/eventsOfCurrentWeek.dart';
import 'package:newproject/screens/events/event_details.dart';
import 'package:newproject/utils/buttons.dart';
import 'package:newproject/utils/colors.dart';
import 'package:newproject/utils/controllers.dart';
import 'package:newproject/utils/requestAPIController.dart';

class HomeGridWidget extends StatefulWidget {
  const HomeGridWidget({super.key});

  @override
  State<HomeGridWidget> createState() => _HomeGridWidgetState();
}

class _HomeGridWidgetState extends State<HomeGridWidget> {
  bool noEvents = false;
  callFunction() async {
    List<Event> buffer = [];

    for (var i in allFutureEventsList.data!) {
      log(i.latitude!);
      log(i.longitude!);
      log(userLocation!.latitude.toString());
      log(userLocation!.longitude.toString());
      log(i.toJson().toString());
      if (i.latitude != null && i.longitude != null) {
        bool isClose = checkDistanceBetweenTwoPoints(
            double.parse(i.latitude!),
            double.parse(i.longitude!),
            userLocation!.latitude,
            userLocation!.longitude);

        if (isClose) {
          i.distance =   distanceBetweenPoints(   double.parse(i.latitude!),            double.parse(i.longitude!),
           userLocation!.latitude,            userLocation!.longitude);
           log('distqncedate ${i.startDate}');

log('distqnce ${i.distance}');
          buffer.add(i);
        }
      }
    }
   buffer. sort((a, b) =>
      (a.distance!).compareTo(b.distance!));
    eventsNearByMeOnly.data = buffer;
    if (buffer.isEmpty) {
      noEvents = true;
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    callFunction();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: noEvents == true ? 200 : 250,
      child: eventsNearByMeOnly.data == null
          ? customCentralCircularProgressLoader()
          : noEvents == true
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "No Events Near By".tr,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: textColor,
                              fontSize: 20,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ],
                )
              : GridView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: eventsNearByMeOnly.data!.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1, // Set the number of items per row
                  ),
                  itemBuilder: (BuildContext context, int index) {
                                        log('distqnce@dateee ${eventsNearByMeOnly.data![index].startDate}');

                    log('distqnce@ ${eventsNearByMeOnly.data![index].distance}');

                    double? price = 0;
                    if (eventsNearByMeOnly.data![index].tickets!.isNotEmpty) {
                      eventsNearByMeOnly.data![index].tickets
                          ?.forEach((element) {
                        price = element.price;
                      });
                    }
                    String url = '';
                    try {
                      print('Here');
                      if (eventsNearByMeOnly.data![index].image != null &&
                              eventsNearByMeOnly.data![index].image!
                                  .contains('http') ||
                          eventsNearByMeOnly.data![index].image!
                              .contains('https')) {
                        url = Uri.parse(eventsNearByMeOnly.data![index].image!)
                            .toString();
                      }
                    } catch (e) {
                      url =
                          'https://via.placeholder.com/640x480.png/0099cc?text=odit';
                    }
                    print(url);
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (builder) => EventDetails(
                                    eventID: eventsNearByMeOnly.data![index].id
                                        .toString(),
                                    eventTitle: eventsNearByMeOnly
                                        .data![index].title
                                        .toString())));
                      },
                      child: Container(
                        width: 200, // Set the width of the item
                        margin: const EdgeInsets.all(8.0),
                        padding: const EdgeInsets.all(8.0),

                        child: Stack(
                          children: [

                            CachedNetworkImage(
  imageUrl: url,
  imageBuilder: (context, imageProvider) => Container(
    decoration: BoxDecoration(
borderRadius: BorderRadius.all(Radius.circular(10)),
      image: DecorationImage(
        
          image: imageProvider,
          fit: BoxFit.cover,
         // colorFilter:
            //  ColorFilter.mode(Colors.red, BlendMode.colorBurn)
            ),
    ),
  ),
  placeholder: (context, url) =>    Image.asset(
                                    "assets/backimage.png",
                                    height: 200,
                                    fit: BoxFit.cover,
                                  ),
  errorWidget: (context, url, error) =>     Image.asset(
                                    "assets/backimage.png",
                                    height: 200,
                                    fit: BoxFit.cover,
                                  ),
),

/*                                                         Container(
                                                          decoration: BoxDecoration( 
                                                            image: DecorationImage(
                                                              
                                                              image: url == '' ?
                                                               NetworkImage( url):const AssetImage(''),
                                                               
                                 


                                     fit: BoxFit.contain,
 onError: (Object exception, StackTrace? stackTrace) {

          print('onError');
          print('Exception: $exception');
          print('Stack Trace:\n$stackTrace');
        },                          
                               
                         
                                                            
                                                            
                                                            
                                                            
                                                            )


                                                          ),
                                                        
                                                        ), */
                            Container(
                              margin: const EdgeInsets.only(top: 5),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.all(5),
                                    height: 67,
                                    width: 57,
                                    child: Card(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            Flexible(
                                              child: Text(
                                                eventsNearByMeOnly.data![index]
                                                            .startDate ==
                                                        null
                                                    ? ""
                                                    : DateFormat('dd').format(
                                                        DateTime.parse(
                                                            eventsNearByMeOnly
                                                                .data![index]
                                                                .startDate!
                                                                .toString())),
                                                style: const TextStyle(
                                                    color: Color(0xfff00000)),
                                              ),
                                            ),
                                            Text(
                                              eventsNearByMeOnly.data![index]
                                                          .startDate ==
                                                      null
                                                  ? ""
                                                  : DateFormat('MMM').format(
                                                      DateTime.parse(
                                                          eventsNearByMeOnly
                                                              .data![index]
                                                              .startDate!
                                                              .toString())),
                                              style: const TextStyle(
                                                  color: Color(0xf0000000)),
                                            ),
                                            // Text(
                                            //   "Jan",
                                            //   style: TextStyle(color: Color(0xff969B9D)),
                                            // )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    
                                    mainAxisAlignment: MainAxisAlignment.start,
                                     children: [ 
                                  
                                  
                                  
                                  Container(
                                      margin: const EdgeInsets.only(
                                          right: 10, bottom: 2),
                                      //height: 20,
                                      //width: 60,
                                      padding: const EdgeInsets.all(3),
                                      decoration: BoxDecoration(
                                          color: Colors.blue,
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: Text(
                                        price == 0
                                            ? "Free".tr
                                            : "${price!.toStringAsFixed(2)}\$",
                                        style: const TextStyle(color: Colors.white),
                                        textAlign: TextAlign.center,
                                      )),
                                      Container(
                                      margin: const EdgeInsets.only(
                                          right: 10, bottom: 2),
                                      //height: 20,
                                      //width: 60,
                                      padding: const EdgeInsets.all(3),
                                      decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(.7),
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: Text(
                                        "Participants - ${eventsNearByMeOnly.data![index].participants!.length ?? 0} ",
                                        style: const TextStyle(
                                          //  color: textColor,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500),
                                      
                                    )),],)
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(bottom: 30),
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.grey.withOpacity(.5)),
                                      margin: const EdgeInsets.only(left: 10),
                                      child: Text(
                                        eventsNearByMeOnly.data![index].title!,
                                        style: const TextStyle(
                                            color: textColor,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    /* Container(
                                      margin: const EdgeInsets.only(right: 10),
                                      child: Text(
                                        "Participants - ${eventsNearByMeOnly.data![index].participants!.length ?? 0} ",
                                        style: const TextStyle(
                                            color: textColor,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ), */
                                    // Container(
                                    //   margin: EdgeInsets.only(right: 10),
                                    //   child: Text(
                                    //     "2.8 Km",
                                    //     style: TextStyle(
                                    //         color: textColor,
                                    //         fontSize: 12,
                                    //         fontWeight: FontWeight.w500),
                                    //   ),
                                    // ),
                                  ],
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
