import 'package:flutter/material.dart';

import '../model/UsersListModel.dart';

class AccountEditProfileStackWidget extends StatefulWidget {
  Users? item;
  int? id;
  AccountEditProfileStackWidget({super.key, this.item,this.id});

  @override
  State<AccountEditProfileStackWidget> createState() => AccountEditProfileStackWidgetState();
}

class AccountEditProfileStackWidgetState extends State<AccountEditProfileStackWidget> {
  @override
  Widget build(BuildContext context) {
    String image = '';
    String coverImager = '';
    try {
      if (widget.item!.coverImage != null &&
          widget.item!.coverImage!.contains('http') ||
          widget.item!.coverImage!.contains('https')) {
        coverImager =
            Uri.parse(widget.item!.coverImage!).toString();
      }
      if (widget.item!.image != null &&
          widget.item!.image!.contains('http') ||
          widget.item!.image!.contains('https')) {
        image = Uri.parse(widget.item!.image!).toString();
      }
    } catch (e) {
      image = '';
      coverImager = '';
    }
    return SizedBox(
      height: 200,
      child: Stack(
        children: [
          coverImager == ''
              ? Image.asset(
            "assets/bg.png",
            height: 200,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          )
              : Image.network(
            widget.item!.coverImage!,
            height: 200,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),

          Positioned(
            bottom: 0,
            left: MediaQuery.of(context).size.width * 0.5 -
                60, // To center the CircleAvatar
            child: CircleAvatar(
                radius: 60,
                backgroundImage: image == ''
                    ? const NetworkImage('https://picsum.photos/id/237/200/300')
                    : NetworkImage(widget.item!.image!)
                as ImageProvider),
          ),
        ],
      ),
    );
  }
}
