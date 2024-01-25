import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:newproject/screens/frames/event_near_by_you_frame.dart';
import 'package:newproject/screens/setting/setting_screen.dart';
import 'package:newproject/utils/colors.dart';
import 'package:newproject/widgets/categories_row_widget.dart';
import 'package:newproject/widgets/home_grid_widget.dart';

import '../../../common/constant.dart';
import '../../../providers/global_providers.dart';
import '../../../utils/requestAPIController.dart';
import '../../../widgets/home_list_view_widget.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getWeekEvents();
  }

  Future<void> getWeekEvents() async {
    final service = ref.watch(sharedPreferencesServiceProvider);
    String token = await service.getString(authTokenIdentifier);
    //await APIRequests().allFutureEvents(token: token);

    await APIRequests().eventsOfCurrentWeek(token: token);
  }

  Future<void> refreshEvents() async {
    final service = ref.watch(sharedPreferencesServiceProvider);
    String token = await service.getString(authTokenIdentifier);
    await APIRequests().allFutureEvents(token: token);

    await APIRequests().eventsOfCurrentWeek(token: token);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (builder) => const SettingScreen()));
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              "assets/menu-04.png",
              width: 28,
              height: 28,
            ),
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SvgPicture.asset(
            "assets/Logo v.2.svg",
            width: 33,
            height: 40,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (builder) => const EventNearByYourFrame()));
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                "assets/search-01.png",
                width: 28,
                height: 28,
              ),
            ),
          )
        ],
        backgroundColor: mainColor,
      ),
      backgroundColor: mainColor,
      body: SafeArea(
        child: RefreshIndicator(
            onRefresh: refreshEvents,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const CategoriesRowWidget(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 10),
                          child: Text(
                            "Event Near By You".tr,
                            style: const TextStyle(
                                color: textColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        /*        Container(
                      margin: EdgeInsets.only(right: 10),
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (builder) =>
                                      EventNearByYourFrame()));
                        },
                        child: Text(
                          "See All".tr,
                          style: TextStyle(
                              fontSize: 12,
                              color: buttonColor,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
              */
                      ],
                    ),
                  ),
                  const HomeGridWidget(),
                  Container(
                    margin: const EdgeInsets.only(left: 10, bottom: 10),
                    child: Text(
                      "This Week's Event".tr,
                      style: const TextStyle(
                          color: textColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Container(
                      //      height: MediaQuery.of(context).size.height,
                      child: const HomeListView()),
                  const SizedBox(
                    height: 20,
                  )
                ],
              ),
            )),
      ),
    );
  }
}
