import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:newproject/utils/colors.dart';
import 'package:newproject/utils/controllers.dart';

import '../common/constant.dart';
import '../providers/global_providers.dart';
import '../screens/dashboard/dashborad_screens/AccountsProfilePage.dart';
import '../utils/requestAPIController.dart';

class UserAccountFollowUnFollowWidget extends ConsumerStatefulWidget {
  final String id;
  int index;
   UserAccountFollowUnFollowWidget({super.key, required this.id,required this.index});

  @override
  ConsumerState<UserAccountFollowUnFollowWidget> createState() =>
      _UserAccountFollowUnFollowWidgetState();

}

class _UserAccountFollowUnFollowWidgetState
    extends ConsumerState<UserAccountFollowUnFollowWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    refreshPage();
  }
  refreshPage()async{
    final service = ref.watch(sharedPreferencesServiceProvider);
    String token = await service.getString(authTokenIdentifier);

    await APIRequests().getHostedEventsOfotherUser(widget.id, token: token);
    AccountsProfilePage(index: widget.index,);
    setState(() {
    });
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              Text(
                "Total".tr,
                style: TextStyle(
                    color: const Color(0xffFFFFFF).withOpacity(.6),
                    fontWeight: FontWeight.w400,
                    fontSize: 14),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                hostedEventsOfotherUser.count!= null ?'${hostedEventsOfotherUser.count!+20}':"0",
                style: const TextStyle(
                    color: textColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
              )
            ],
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            children: [
              Text(
                "Hosted".tr,
                style: TextStyle(
                    color: const Color(0xffFFFFFF).withOpacity(.6),
                    fontWeight: FontWeight.w400,
                    fontSize: 14),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                hostedEventsOfotherUser.count!= null ?hostedEventsOfotherUser.count.toString():"0",
                style: const TextStyle(
                    color: textColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
              )
            ],
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            children: [
              Text(
                "Attending".tr,
                style: TextStyle(
                    color: const Color(0xffFFFFFF).withOpacity(.6),
                    fontWeight: FontWeight.w400,
                    fontSize: 14),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "20",
                style: TextStyle(
                    color: textColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
              )
            ],
          ),
        ],
      ),
    );
  }
}
