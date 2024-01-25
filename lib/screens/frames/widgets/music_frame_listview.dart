import 'package:flutter/material.dart';
import 'package:newproject/screens/events/event_details.dart';
import 'package:newproject/utils/colors.dart';
import 'package:newproject/utils/controllers.dart';
import 'package:intl/intl.dart';

class MusicFrameListWidget extends StatefulWidget {
  const MusicFrameListWidget({super.key});
  @override
  State<MusicFrameListWidget> createState() => _MusicFrameListWidgetState();
}

class _MusicFrameListWidgetState extends State<MusicFrameListWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 1.5,
      child: getEventsWithFiltersModel.data!.isEmpty
          ? Center(
              child: Column(children: [
              const Spacer(),
              Image.asset(
                "assets/EmptyState.png",
                fit: BoxFit.cover,
                height: 200,
              ),
              const Text(
                "No results found",
                style: TextStyle(
                    color: textColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Try adjusting your search\nto find what you are looking forr",
                style: TextStyle(
                    color: textColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              const Spacer()
            ]))
          : ListView.builder(
              itemCount: getEventsWithFiltersModel.data!.length,
              itemBuilder: (BuildContext context, int index) {
                // var countryData = getCountriesFromAPI.data!.firstWhere((element) {
                //   print(element.id);
                //   if (element.id ==
                //       (getEventsWithFiltersModel.data![index].countryId == 0
                //           ? 1
                //           : getEventsWithFiltersModel.data![index].countryId)) {
                //     return true;
                //   }
                //   return false;
                // });
                // String countryName = countryData.name!;
                return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: SizedBox(
                      height: 120,
                      child: Card(
                        color: const Color(0xff21252A),
                        child: Align(
                          alignment: Alignment.center,
                          child: ListTile(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (builder) => EventDetails(
                                          eventID: getEventsWithFiltersModel
                                              .data![index].id
                                              .toString(),
                                          eventTitle: getEventsWithFiltersModel
                                              .data![index].title
                                              .toString()))); //PASS REAL EVENT ID HERE
                            },
                            leading: Container(
                              width: 50,
                              height: 70,
                              color: const Color(0xff21252A),
                              child: getEventsWithFiltersModel
                                          .data![index].image !=
                                      null
                                  ? FadeInImage(
                                      image: NetworkImage(
                                          getEventsWithFiltersModel
                                              .data![index].image!),
                                      placeholder:
                                          const AssetImage("assets/small.png"),
                                      imageErrorBuilder:
                                          (context, error, stackTrace) {
                                        return Image.asset('assets/Masks.png',
                                            fit: BoxFit.fitWidth);
                                      },
                                      fit: BoxFit.fitWidth,
                                    )

                                  // Image.network(
                                  //   getEventsWithFiltersModel.data![index].image!   ,)
                                  : Image.asset("assets/Masks.png"),
                            ),
                            title: Text(
                              getEventsWithFiltersModel.data![index].title ==
                                      null
                                  ? ''
                                  : getEventsWithFiltersModel
                                      .data![index].title!,
                              style: const TextStyle(
                                  color: Color(0xffF9FAFB),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14),
                            ),
                            subtitle: Text(
                              getEventsWithFiltersModel.data![index].location ==
                                      null
                                  ? ''
                                  : getEventsWithFiltersModel
                                      .data![index].location
                                      .toString(),
                              style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xffA2A5AA)),
                            ),
                            trailing: Container(
                              margin: const EdgeInsets.only(right: 10, bottom: 10),
                              height: 50,
                              width: 120,
                              decoration: BoxDecoration(
                                  color: const Color(0xff1E4697),
                                  borderRadius: BorderRadius.circular(6)),
                              child: Center(
                                child: Text(
                                  "${getEventsWithFiltersModel.data![index].startDate == null ? '' : DateFormat('d EEE').format(DateTime.parse(getEventsWithFiltersModel.data![index].startDate!.toString()))} |  ${getEventsWithFiltersModel.data![index].price == null ? 'Free' : '\$' '${getEventsWithFiltersModel.data![index].price}'}",
                                  style: const TextStyle(color: textColor),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ));
              }),
    );
  }
}
