import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newproject/screens/frames/event_near_by_you_frame.dart';
import 'package:newproject/screens/frames/music_frame.dart';
import 'package:newproject/utils/colors.dart';
import 'package:newproject/utils/controllers.dart';

class CategoriesRowWidget extends StatefulWidget {
  const CategoriesRowWidget({super.key});

  @override
  State<CategoriesRowWidget> createState() => _CategoriesRowWidgetState();
}

class _CategoriesRowWidgetState extends State<CategoriesRowWidget> {
  int isActive = 0;
  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [];
    widgets.add(InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (builder) => const EventNearByYourFrame()));
      },
      child: Column(
        children: [
          Image.asset(
            "assets/all.png",
            height: 70,
            width: 70,
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
              width:
                  90, //This helps the text widget know what the maximum width is again! You may also opt to use an Expanded widget instead of a Container widget, if you want to use all remaining space.
              child: Center(
                  child: Text(
                "ALL".tr, textAlign: TextAlign.center, maxLines: 2,
                //"Music".tr,
                style: const TextStyle(color: textColor, fontSize: 9),
              )))
        ],
      ),
    ));

    widgets.addAll(getCategories.data!
        .map(
          (cat) => InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (builder) => MusicFrame(
                    categoryID: cat.id.toString(),
                    // categoryID: getCategories.data!
                    //     .firstWhere((element) =>
                    //         element.name!.contains('Music') ||
                    //         element.name!.contains('music') ||
                    //         element.name!.contains('Movie') ||
                    //         element.name!.contains('Entertainment') ||
                    //         element.name!.contains('FREESTYLE') ||
                    //         element.name!.contains('Concerts'))
                    //     .id
                    //     .toString(),
                  ),
                ),
              );
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                    height: 70,
                    width: 70,
                    child: CachedNetworkImage(
                      imageUrl: cat.image!,
                      imageBuilder: (context, imageProvider) => Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                            // colorFilter: ColorFilter.mode(
                            //   Colors.red, BlendMode.colorBurn)
                          ),
                        ),
                      ),
                      placeholder: (context, url) => Image.asset(
                        "assets/all.png",
                        height: 60,
                        width: 60,
                      ),
                      errorWidget: (context, url, error) => Image.asset(
                        "assets/all.png",
                        height: 60,
                        width: 60,
                      ),
                    )),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                    width:
                        110, //This helps the text widget know what the maximum width is again! You may also opt to use an Expanded widget instead of a Container widget, if you want to use all remaining space.
                    child: Center(
                        child: Text(
                      cat.name!, textAlign: TextAlign.center, maxLines: 2,
                      //"Music".tr,
                      style: const TextStyle(color: textColor, fontSize: 9),
                    )))
              ],
            ),
          ),
        )
        .toList());

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.start, children: widgets

              /*    [
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (builder) => EventNearByYourFrame()));
            },
            child: Column(
              children: [
                Image.asset(
                  "assets/all.png",
                  height: 52,
                  width: 52,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "All".tr,
                  style: TextStyle(color: textColor),
                )
              ],
            ),
          ),
          SizedBox(
            width: 10,
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (builder) => MusicFrame(
                    categoryID: "8",
                    // categoryID: getCategories.data!
                    //     .firstWhere((element) =>
                    //         element.name!.contains('Music') ||
                    //         element.name!.contains('music') ||
                    //         element.name!.contains('Movie') ||
                    //         element.name!.contains('Entertainment') ||
                    //         element.name!.contains('FREESTYLE') ||
                    //         element.name!.contains('Concerts'))
                    //     .id
                    //     .toString(),
                  ),
                ),
              );
            },
            child: Column(
              children: [
                Image.asset(
                  "assets/music.png",
                  height: 52,
                  width: 52,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Music".tr,
                  style: TextStyle(color: textColor),
                )
              ],
            ),
          ),
          SizedBox(
            width: 10,
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (builder) => MusicFrame(
                    categoryID: "4",
                    // categoryID: getCategories.data!
                    //     .firstWhere((element) =>
                    //         element.name!.contains('Cycling') ||
                    //         element.name!.contains('Movie') ||
                    //         element.name!.contains('Entertainment') ||
                    //         element.name!.contains('FREESTYLE') ||
                    //         element.name!.contains('Health'))
                    //     .id
                    //     .toString(),
                  ),
                ),
              );
            },
            child: Column(
              children: [
                Image.asset(
                  "assets/Icon.png",
                  height: 52,
                  width: 52,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Cycling".tr,
                  style: TextStyle(color: textColor),
                )
              ],
            ),
          ),
          SizedBox(
            width: 10,
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (builder) => MusicFrame(
                    categoryID: "8",
                    // categoryID: getCategories.data!
                    //     .firstWhere((element) =>
                    //         element.name!.contains('Movie') ||
                    //         element.name!.contains('Entertainment') ||
                    //         element.name!.contains('Movie') ||
                    //         element.name!.contains('Entertainment') ||
                    //         element.name!.contains('FREESTYLE') ||
                    //         element.name!.contains('FREESTYLE'))
                    //     .id
                    //     .toString(),
                  ),
                ),
              );
            },
            child: Column(
              children: [
                Image.asset(
                  "assets/Icon-1.png",
                  height: 52,
                  width: 52,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Movie".tr,
                  style: TextStyle(color: textColor),
                )
              ],
            ),
          ),
          SizedBox(
            width: 10,
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (builder) => MusicFrame(categoryID: "5"
                      // getCategories.data!
                      //     .firstWhere((element) =>
                      //         element.name!.contains('Art') ||
                      //         element.name!.contains('Movie') ||
                      //         element.name!.contains('Entertainment') ||
                      //         element.name!.contains('FREESTYLE') ||
                      //         element.name!.contains('Yoga'))
                      //     .id
                      //     .toString(),
                      ),
                ),
              );
            },
            child: Column(
              children: [
                Image.asset(
                  "assets/Icon-2.png",
                  height: 52,
                  width: 52,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Arts".tr,
                  style: TextStyle(color: textColor),
                )
              ],
            ),
          )
        ], */
              )),
    );
  }
}
