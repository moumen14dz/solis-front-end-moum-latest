import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newproject/utils/colors.dart';
import 'package:newproject/utils/controllers.dart';


class AccountFollowUnFollowWidget extends StatefulWidget {
  const AccountFollowUnFollowWidget({
    super.key,
  });

  @override
  State<AccountFollowUnFollowWidget> createState() =>
      _AccountFollowUnFollowWidgetState();
}

class _AccountFollowUnFollowWidgetState
    extends State<AccountFollowUnFollowWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    refreshPage();
  }

  refreshPage() async {
    // await APIRequests().getHostedEventsOfUser();
    const AccountFollowUnFollowWidget();
    setState(() {});
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
                hostedEventsOfUser.count != null
                    ? '${hostedEventsOfUser.count!}'
                    : "0",
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
                hostedEventsOfUser.count != null
                    ? hostedEventsOfUser.count.toString()
                    : "0",
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
                "0",
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
