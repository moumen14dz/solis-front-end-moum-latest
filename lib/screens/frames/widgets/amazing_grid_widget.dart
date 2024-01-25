import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:newproject/screens/frames/music_frame.dart';
import 'package:newproject/utils/controllers.dart';


class AmazingGridWidget extends StatefulWidget {
  const AmazingGridWidget({super.key});

  @override
  State<AmazingGridWidget> createState() => _AmazingGridWidgetState();
}

class _AmazingGridWidgetState extends State<AmazingGridWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 25,
          ),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10.0, // Adjust the horizontal spacing
              mainAxisSpacing: 10.0, // Adjust the vertical spacing
            ),
            itemCount: getCategories.data == null
                ? 0
                : getCategories
                    .data!.length, // Assuming you have 6 items in total
            itemBuilder: (BuildContext context, int index) {
              String url = '';
              try {
                print('Here');
                url = Uri.parse(getCategories.data![index].image!).toString();
              } catch (e) {
                url =
                    'https://via.placeholder.com/640x480.png/0099cc?text=odit';
              }
              return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (builder) => MusicFrame(
                          categoryID: getCategories.data![index].id.toString(),
                        ),
                      ),
                    );
                  },
                  child: Column(
                    children: [
                      Text(
                        getCategories.data![index].name!,
                        style:
                            const TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      Flexible(
                          child: Container(
                              padding: const EdgeInsets.all(10),
                              width: 200,
                              height: 200,
                              decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                              ),
                              child: CachedNetworkImage(
                                imageUrl: url,
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                  // height: 60,
                                  // width: 60,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(30)),
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                      // colorFilter: ColorFilter.mode(
                                      //   Colors.red, BlendMode.colorBurn)
                                    ),
                                  ),
                                ),
                                placeholder: (context, url) => Image.asset(
                                  "assets/Mask.png",
                                  //  height: 60,
                                  //  width: 60,
                                ),
                                errorWidget: (context, url, error) =>
                                    Image.asset(
                                  "assets/Mask.png",
                                  //   height: 60,
                                  //  width: 60,
                                ),
                              )

                              /*   Image.network(
                              url.contains('http')
                                  ? url
                                  : 'https://via.placeholder.com/640x480.png/0099cc?text=odit',
                              fit: BoxFit.fill,
                            )), */
                              )),
                    ],
                    // ),
                  ));
            },
          )
        ],
      ),
    );
  }
}
