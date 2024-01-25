import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:newproject/common/constant.dart';
import 'package:newproject/model/myFollowingListMidel.dart';
import 'package:newproject/utils/colors.dart';
import 'package:newproject/utils/controllers.dart';
import 'package:newproject/utils/textformfield.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/message_response_model.dart';
import '../../networking/repository/Chat_Service.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/foundation.dart' as foundation;

class ChatPage extends ConsumerStatefulWidget {
  final List<User>? users;
  final List<Message>? messages;
  final DataFollowing? item;
  final String? convId;
  const ChatPage({
    super.key,
    this.users,
    this.messages,
    this.item,
    this.convId,
  });

  @override
  ConsumerState<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends ConsumerState<ChatPage> {
  List<dynamic> getallmessages = [];
    List<dynamic> getallmessages2 = [];

  bool isLoading = true; // Add a loading flag

  @override
  void initState() {
    super.initState();
    log(widget.users!.length.toString());
    log(widget.users!.first.toJson().toString());

    // Timer.periodic(const Duration(seconds: 1), (timer) {
    getMessageThreads();
    setState(() {});
    // });
  }

  getMessageThreads() async {
    String token = await getToken();
    await ChatMessageService()
        .getMessages(widget.convId!)
        .then((value) => setState(() {
               getallmessages2 = value;
               getallmessages2.forEach((obj) {
             log(   DateFormat('dd/MM/yyyy').format(DateTime.parse(
                                obj['created_at'])));
    log(obj['created_at']);
  });
    setState(() {

       getallmessages =   List.from(getallmessages2.reversed);
              /*   getallmessages.sort((b, a) =>DateFormat('dd/MM/yyyy').format(DateTime.parse(
                                b['created_at'])) .compareTo(DateFormat('dd/MM/yyyy').format(DateTime.parse(
                                a['created_at']))));
   */
  });
              isLoading = false;
            }));
    _scrollToLastMessage();
  }

  bool emojiShowing = false;

  @override
  Widget build(BuildContext context) {
    log("ffffff${userProfileDetails.data?.user?.image}");
    if (widget.messages != null && widget.messages!.isNotEmpty) {
      print("msg${widget.messages![0].conversationId}");
    }
    return Scaffold(
      backgroundColor: mainColor,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: mainColor,
        elevation: 0,
        automaticallyImplyLeading: false,
        flexibleSpace: SafeArea(
          child: Container(
            padding: const EdgeInsets.only(right: 16),
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  width: 2,
                ),
                CircleAvatar(
                  backgroundImage: NetworkImage(widget.users?.first.image ??
                      "https://randomuser.me/api/portraits/men/5.jpg"),
                  maxRadius: 20,
                ),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        (widget.users != null && widget.users!.isNotEmpty)
                            ? widget.users![0].firstName ?? 'No Name'
                            : 'No User',
                        // "",
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: textColor),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                     /*  Text(
                      //  "Online",
                        style: TextStyle(
                            color: Colors.grey.shade600, fontSize: 13),
                      ), */
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Stack(
              children: <Widget>[
               Padding(padding: EdgeInsets.only(bottom: 50),child: Consumer(builder: (context, watch, child) {
                  final getall = ref.watch(currentMessageProvider);
                  return ListView.builder(
                    itemCount: getallmessages.length + 1,
                    controller: _scrollController,
                    itemBuilder: (context, index) {
                      if (index < getallmessages.length) {
                        final item = getallmessages[index];
                        final isUser = widget.messages != null &&
                            item['user_id'] != widget.users![0].id;

                        final messageText = item['message'];
                        final imageUrl = item['image'];
                        final timestamp = item.isNotEmpty
                            ? DateFormat('hh:mm a')
                                .format(DateTime.parse(item['created_at']))
                            : "";
                        final dateChat = item.isNotEmpty
                            ? DateFormat('dd/MM/yyyy')
                                .format(DateTime.parse(item['created_at']))
                            : "";

                        var d = index != 0
                            ? DateFormat('dd/MM/yyyy').format(DateTime.parse(
                                getallmessages[index - 1]['created_at']))
                            : DateFormat('dd/MM/yyyy').format(DateTime.parse(
                                getallmessages.first['created_at']));

                        return SingleChildScrollView(
                            child: Column(
                          children: [
                            /*  Text(
                              dateChat.toString(),
                              style: TextStyle(color: textColor),
                            ),
                            Text(
                              d,
                              style: TextStyle(color: textColor),
                            ), */
                            index != 0
                                ? d != dateChat
                                    ? Text(
                                        dateChat.toString(),
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(color: Colors.yellow),
                                      )
                                    : const SizedBox()
                                : Text(
                                    dateChat.toString(),
                                    style: const TextStyle(color: Colors.yellow),
                                  ),
                            ListTile(
                                leading: isUser
                                    ? null
                                    : CachedNetworkImage(
                                        imageUrl:
                                            widget.users!.first.image != null
                                                ? widget.users!.first.image!
                                                : "",
                                        imageBuilder:
                                            (context, imageProvider) =>
                                                Container(
                                          height: 42,
                                          width: 42,
                                          decoration: BoxDecoration(
                                            borderRadius: const BorderRadius.all(
                                                Radius.circular(30)),
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.cover,
                                              // colorFilter: ColorFilter.mode(
                                              //   Colors.red, BlendMode.colorBurn)
                                            ),
                                          ),
                                        ),
                                        placeholder: (context, url) =>
                                            const CircleAvatar(
                                          // Replace with John's profile image
                                          backgroundImage:
                                              AssetImage('assets/Mask.png'),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            const CircleAvatar(
                                          // Replace with John's profile image
                                          backgroundImage:
                                              AssetImage('assets/Mask.png'),
                                        ),
                                      ),
                                // Replace with AI's profile image

                                trailing: isUser
                                    ? CachedNetworkImage(
                                        height: 42,
                                        width: 42,
                                        imageUrl: userProfileDetails
                                                .data?.user?.image ??
                                            "",
                                        imageBuilder:
                                            (context, imageProvider) =>
                                                Container(
                                          height: 42,
                                          width: 42,
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
                                        placeholder: (context, url) =>
                                            const CircleAvatar(
                                          // Replace with John's profile image
                                          backgroundImage:
                                              AssetImage('assets/Mask.png'),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            const CircleAvatar(
                                          // Replace with John's profile image
                                          backgroundImage:
                                              AssetImage('assets/Mask.png'),
                                        ),
                                      )
                                    : null,
                                titleAlignment: ListTileTitleAlignment.center,
                                title: Container(
                                  padding: const EdgeInsets.all(5),
                                  height: 50,
                                  width: 248,
                                  decoration: const BoxDecoration(
                                      color: buttonColor,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(12),
                                          bottomLeft: Radius.circular(12),
                                          bottomRight: Radius.circular(0),
                                          topRight: Radius.circular(12))),
                                  child: Center(
                                      child: Align(
                                          alignment: isUser
                                              ? Alignment.centerRight
                                              : Alignment.centerLeft,
                                          child: Text(
                                            messageText, // Use the current message if it's the user's message
                                          ))),
                                ),
                                subtitle: imageUrl == null
                                    ? Text(
                                        timestamp,
                                        textAlign: TextAlign.right,
                                        style: const TextStyle(color: textColor),
                                      )
                                    : Text(
                                        timestamp,
                                        style: const TextStyle(color: textColor),
                                      )

                                //  styling here...
                                ),
                          ],
                        ));
                      } else {
                        // This is the extra padding item
                        return const SizedBox(
                            height:
                                45); // Add your desired amount of space here
                      }
                    },
                  );
                })),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      children: <Widget>[
                        const SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: TextFormInputField(
                            suIcon: InkWell(
                              onTap: () {
                                log("rr");
                                setState(() {
                                  emojiShowing = !emojiShowing;
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset(
                                  "assets/face-smile.png",
                                  height: 12,
                                  width: 12,
                                ),
                              ),
                            ),
                            hintText: "Type Your Message",
                            textInputType: TextInputType.text,
                            controller: chatController,
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Container(
                          margin: const EdgeInsets.only(right: 10),
                          child: GestureDetector(
                            child: Image.asset(
                              "assets/Group 23.png",
                              width: 42,
                              height: 42,
                            ),
                            onTap: () {
                              // setState(() {
                              //   isSending = true;
                              // });
                              _scrollToLastMessage();
                              sendMessage();
                              // chatController.clear();
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Offstage(
                  offstage: !emojiShowing,
                  child: SizedBox(
                      height: 300,
                      child: EmojiPicker(
                        textEditingController: chatController,
                        onBackspacePressed: _onBackspacePressed,
                        config: Config(
                          columns: 7,
                          // Issue: https://github.com/flutter/flutter/issues/28894
                          emojiSizeMax: 32 *
                              (foundation.defaultTargetPlatform ==
                                      TargetPlatform.iOS
                                  ? 1.30
                                  : 1.0),
                          verticalSpacing: 0,
                          horizontalSpacing: 0,
                          gridPadding: EdgeInsets.zero,
                          initCategory: Category.RECENT,
                          bgColor: const Color(0xFFF2F2F2),
                          indicatorColor: Colors.blue,
                          iconColor: Colors.grey,
                          iconColorSelected: Colors.blue,
                          backspaceColor: Colors.blue,
                          skinToneDialogBgColor: Colors.white,
                          skinToneIndicatorColor: Colors.grey,
                          enableSkinTones: true,
                          recentTabBehavior: RecentTabBehavior.RECENT,
                          recentsLimit: 28,
                          replaceEmojiOnLimitExceed: false,
                          noRecents: const Text(
                            'No Recents',
                            style:
                                TextStyle(fontSize: 20, color: Colors.black26),
                            textAlign: TextAlign.center,
                          ),
                          loadingIndicator: const SizedBox.shrink(),
                          tabIndicatorAnimDuration: kTabScrollDuration,
                          categoryIcons: const CategoryIcons(),
                          buttonMode: ButtonMode.MATERIAL,
                          checkPlatformCompatibility: true,
                        ),
                      )),
                ),
              ],
            ),
    );
  }

  bool isSending = false;
  final ScrollController _scrollController = ScrollController();

  final currentMessageProvider = StateProvider<String>((ref) => '');
  void _scrollToLastMessage() {
    // Ensure that the scroll controller has attached to the ListView.
    // It is safer to perform the scroll only when the widget is built.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void sendMessage() async {
    print("john${widget.users![0].id}");
    SharedPreferences userpref = await SharedPreferences.getInstance();
    var myId = userpref.getInt("userId");
    final message = chatController.text;
    await ChatMessageService()
        .sendMessage(myId.toString(), widget.users![0].id.toString().toString(),
            chatController.text)
        .then((_) async {
      // ref.read(currentMessageProvider.notifier).state = message; // Update the current message
      chatController.clear();
      isSending = false;
      await getMessageThreads();
      setState(() {});
      print("succssfully sent");
    });
  }

  _onBackspacePressed() {
    chatController
      ..text = chatController.text.characters.toString()
      ..selection = TextSelection.fromPosition(
          TextPosition(offset: chatController.text.length));
  }
}







// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:intl/intl.dart';
// import 'package:newproject/common/constant.dart';
// import 'package:newproject/model/myFollowingListMidel.dart';
// import 'package:newproject/screens/models/chat_message_model.dart';
// import 'package:newproject/utils/colors.dart';
// import 'package:newproject/utils/controllers.dart';
// import 'package:newproject/utils/textformfield.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../../model/chatmessageModel.dart';
// import '../../model/message_response_model.dart';
// import '../../networking/repository/Chat_Service.dart';
// import '../../utils/requestAPIController.dart';
//
// class ChatPage extends ConsumerStatefulWidget {
//   final List<User>? users;
//   final List<Message>? messages;
//   final DataFollowing? item;
//   final String? convId;
//   ChatPage({
//     super.key,
//     this.users,
//     this.messages, this.item, this.convId,
//   });
//
//   @override
//   ConsumerState<ChatPage> createState() => _ChatPageState();
// }
//
// // class _ChatPageState extends ConsumerState<ChatPage> {
// //   List<dynamic> getallmessages = [];
// //   bool isLoading = true; // Add a loading flag
// //
// //   void initState() {
// //     super.initState();
// //     // Timer.periodic(const Duration(seconds: 1), (timer) {
// //     getMessageThreads();
// //     setState(() {});
// //     // });
// //   }
// //
// //   getMessageThreads() async {
// //     String token = await getToken();
// //     await ChatMessageService().getMessages(widget.convId!).then((value) => setState(() {
// //           getallmessages = value;
// //           isLoading = false;
// //         }));
// //     _scrollToLastMessage();
// //     setState(() {});
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     if (widget.messages != null && widget.messages!.isNotEmpty) {
// //       print("msg" + widget.messages![0].conversationId.toString());
// //     }
// //     return Scaffold(
// //       backgroundColor: mainColor,
// //       appBar: AppBar(
// //         iconTheme: IconThemeData(color: Colors.white),
// //         backgroundColor: mainColor,
// //         elevation: 0,
// //         automaticallyImplyLeading: false,
// //         flexibleSpace: SafeArea(
// //           child: Container(
// //             padding: EdgeInsets.only(right: 16),
// //             child: Row(
// //               children: <Widget>[
// //                 IconButton(
// //                   onPressed: () {
// //                     Navigator.pop(context);
// //                   },
// //                   icon: Icon(
// //                     Icons.arrow_back,
// //                     color: Colors.white,
// //                   ),
// //                 ),
// //                 SizedBox(
// //                   width: 2,
// //                 ),
// //                 CircleAvatar(
// //                   backgroundImage: NetworkImage(
// //                       "<https://randomuser.me/api/portraits/men/5.jpg>"),
// //                   maxRadius: 20,
// //                 ),
// //                 SizedBox(
// //                   width: 12,
// //                 ),
// //                 Expanded(
// //                   child: Column(
// //                     crossAxisAlignment: CrossAxisAlignment.start,
// //                     mainAxisAlignment: MainAxisAlignment.center,
// //                     children: <Widget>[
// //                       Text(
// //                         (widget.users != null && widget.users!.isNotEmpty)
// //                             ? widget.users![0].firstName ?? 'No Name'
// //                             : 'No User',
// //                         // "",
// //                         style: TextStyle(
// //                             fontSize: 16,
// //                             fontWeight: FontWeight.w600,
// //                             color: textColor),
// //                       ),
// //                       SizedBox(
// //                         height: 6,
// //                       ),
// //                       Text(
// //                         "Online",
// //                         style: TextStyle(
// //                             color: Colors.grey.shade600, fontSize: 13),
// //                       ),
// //                     ],
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ),
// //         ),
// //       ),
// //       body: isLoading
// //           ? Center(
// //               child: CircularProgressIndicator(),
// //             )
// //           : Stack(
// //               children: <Widget>[
// //                 Consumer(builder: (context, watch, child) {
// //                   final getall = ref.watch(currentMessageProvider);
// //                   return ListView.builder(
// //                     itemCount: getallmessages.length + 1,
// //                     controller: _scrollController,
// //                     itemBuilder: (context, index) {
// //                       if (index < getallmessages.length) {
// //                         final item = getallmessages[index];
// //                         final isUser = widget.messages != null &&
// //                             item['user_id'] != widget.users![0].id;
// //
// //                         final messageText = item['message'];
// //                         final imageUrl = item['image'];
// //                         final timestamp = item.isNotEmpty
// //                             ? DateFormat('hh:mm a')
// //                                 .format(DateTime.parse(item['created_at']))
// //                             : "";
// //
// //                         return SingleChildScrollView(
// //                           child: ListTile(
// //                               leading: isUser
// //                                   ? null
// //                                   : CircleAvatar(
// //                                       // Replace with AI's profile image
// //                                       backgroundImage:
// //                                           AssetImage('assets/Mask.png'),
// //                                     ),
// //                               trailing: isUser
// //                                   ? CircleAvatar(
// //                                       // Replace with John's profile image
// //                                       backgroundImage:
// //                                           AssetImage('assets/Mask.png'),
// //                                     )
// //                                   : null,
// //                               title: Container(
// //                                 height: 50,
// //                                 width: 248,
// //                                 decoration: BoxDecoration(
// //                                     color: buttonColor,
// //                                     borderRadius: BorderRadius.only(
// //                                         topLeft: Radius.circular(12),
// //                                         bottomLeft: Radius.circular(12),
// //                                         bottomRight: Radius.circular(0),
// //                                         topRight: Radius.circular(12))),
// //                                 child: Center(
// //                                   child: Text(
// //                                     messageText, // Use the current message if it's the user's message
// //                                     textAlign: TextAlign.left,
// //                                   ),
// //                                 ),
// //                               ),
// //                               subtitle: imageUrl == null
// //                                   ? Text(
// //                                       timestamp,
// //                                       textAlign: TextAlign.right,
// //                                       style: TextStyle(color: textColor),
// //                                     )
// //                                   : Text(
// //                                       timestamp,
// //                                       style: TextStyle(color: textColor),
// //                                     )
// //
// //                               //  styling here...
// //                               ),
// //                         );
// //                       } else {
// //                         // This is the extra padding item
// //                         return SizedBox(
// //                             height:
// //                                 45); // Add your desired amount of space here
// //                       }
// //                     },
// //                   );
// //                 }),
// //                 Align(
// //                   alignment: Alignment.bottomLeft,
// //                   child: Container(
// //                     margin: EdgeInsets.only(bottom: 10),
// //                     child: Row(
// //                       children: <Widget>[
// //                         SizedBox(
// //                           width: 15,
// //                         ),
// //                         Expanded(
// //                           child: TextFormInputField(
// //                             suIcon: Padding(
// //                               padding: const EdgeInsets.all(8.0),
// //                               child: Image.asset(
// //                                 "assets/face-smile.png",
// //                                 height: 12,
// //                                 width: 12,
// //                               ),
// //                             ),
// //                             hintText: "Type Your Message",
// //                             textInputType: TextInputType.text,
// //                             controller: chatController,
// //                           ),
// //                         ),
// //                         SizedBox(
// //                           width: 15,
// //                         ),
// //                         Container(
// //                           margin: EdgeInsets.only(right: 10),
// //                           child: GestureDetector(
// //                             child: Image.asset(
// //                               "assets/Group 23.png",
// //                               width: 42,
// //                               height: 42,
// //                             ),
// //                             onTap:  () {
// //                                     // setState(() {
// //                                     //   isSending = true;
// //                                     // });
// //                                     _scrollToLastMessage();
// //                                     sendMessage();
// //                                     // chatController.clear();
// //                                   },
// //                           ),
// //                         )
// //                       ],
// //                     ),
// //                   ),
// //                 ),
// //               ],
// //             ),
// //     );
// //   }
// class _ChatPageState extends ConsumerState<ChatPage> {
//   // List<dynamic> getallmessages = [];
//   bool isLoading = true; // Add a loading flag
//
//   void initState() {
//     super.initState();
//     // Timer.periodic(const Duration(seconds: 1), (timer) {
//     // getMessageThreads();
//     getMessages();
//
//     setState(() {});
//     // });
//   }
//   getMessages()async{
//     isLoading = true;
//     await APIRequests().getMessages();
//     isLoading = false;
//     setState(() {
//
//     });
//   }
//   getMessageThreads() async {
//     String token = await getToken();
//     await ChatMessageService().getMessages(widget.convId!).then((value) => setState(() {
//       // getallmessages = value;
//       isLoading = false;
//     }));
//     _scrollToLastMessage();
//     setState(() {});
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     if (widget.messages != null && widget.messages!.isNotEmpty) {
//       print("msg" + widget.messages![0].conversationId.toString());
//     }
//     return Scaffold(
//       backgroundColor: mainColor,
//       appBar: AppBar(
//         iconTheme: IconThemeData(color: Colors.white),
//         backgroundColor: mainColor,
//         elevation: 0,
//         automaticallyImplyLeading: false,
//         flexibleSpace: SafeArea(
//           child: Container(
//             padding: EdgeInsets.only(right: 16),
//             child: Row(
//               children: <Widget>[
//                 IconButton(
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                   icon: Icon(
//                     Icons.arrow_back,
//                     color: Colors.white,
//                   ),
//                 ),
//                 SizedBox(
//                   width: 2,
//                 ),
//                 CircleAvatar(
//                   backgroundImage: NetworkImage(
//                       "<https://randomuser.me/api/portraits/men/5.jpg>"),
//                   maxRadius: 20,
//                 ),
//                 SizedBox(
//                   width: 12,
//                 ),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: <Widget>[
//                       Text(
//                         (widget.users != null && widget.users!.isNotEmpty)
//                             ? widget.users![0].firstName ?? 'No Name'
//                             : 'No User',
//                         // "",
//                         style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.w600,
//                             color: textColor),
//                       ),
//                       SizedBox(
//                         height: 6,
//                       ),
//                       Text(
//                         "Online",
//                         style: TextStyle(
//                             color: Colors.grey.shade600, fontSize: 13),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//       body: isLoading
//           ? Center(
//         child: CircularProgressIndicator(),
//       )
//           : Stack(
//         children: <Widget>[
//           Consumer(builder: (context, watch, child) {
//             final getall = ref.watch(currentMessageProvider);
//             return ListView.builder(
//               // itemCount: getallmessages.length + 1,
//               itemCount: chatMessages.data!.length + 1,
//               controller: _scrollController,
//               itemBuilder: (context, index) {
//                 if (index < chatMessages.data!.length) {
//                   final item = chatMessages.data![index];
//                   final isUser = widget.messages != null &&
//                       // item['user_id'] != widget.users![0].id;
//                       item.userId != widget.users![0].id;
//
//                   // final messageText = item['message'];
//                   final messageText = item.message;
//                   // final imageUrl = item['image'];
//                   final timestamp = item.createdAt != null
//                       ? DateFormat('hh:mm a')
//                       .format(DateTime.parse(item.createdAt.toString()))
//                       : "";
//
//                   return SingleChildScrollView(
//                     child: ListTile(
//                         leading: isUser
//                             ? null
//                             : CircleAvatar(
//                           // Replace with AI's profile image
//                           backgroundImage:
//                           AssetImage('assets/Mask.png'),
//                         ),
//                         trailing: isUser
//                             ? CircleAvatar(
//                           // Replace with John's profile image
//                           backgroundImage:
//                           AssetImage('assets/Mask.png'),
//                         )
//                             : null,
//                         title: Container(
//                           height: 50,
//                           width: 248,
//                           decoration: BoxDecoration(
//                               color: buttonColor,
//                               borderRadius: BorderRadius.only(
//                                   topLeft: Radius.circular(12),
//                                   bottomLeft: Radius.circular(12),
//                                   bottomRight: Radius.circular(0),
//                                   topRight: Radius.circular(12))),
//                           child: Center(
//                             child: Text(
//                               messageText!, // Use the current message if it's the user's message
//                               textAlign: TextAlign.left,
//                             ),
//                           ),
//                         ),
//                         subtitle: Text(
//                           timestamp,
//                           textAlign: TextAlign.right,
//                           style: TextStyle(color: textColor),
//                         )
//                       //     : Text(
//                       //   timestamp,
//                       //   style: TextStyle(color: textColor),
//                       // )
//
//                       //  styling here...
//                     ),
//                   );
//                 } else {
//                   // This is the extra padding item
//                   return SizedBox(
//                       height:
//                       45); // Add your desired amount of space here
//                 }
//               },
//             );
//           }),
//           Align(
//             alignment: Alignment.bottomLeft,
//             child: Container(
//               margin: EdgeInsets.only(bottom: 10),
//               child: Row(
//                 children: <Widget>[
//                   SizedBox(
//                     width: 15,
//                   ),
//                   Expanded(
//                     child: TextFormInputField(
//                       suIcon: Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Image.asset(
//                           "assets/face-smile.png",
//                           height: 12,
//                           width: 12,
//                         ),
//                       ),
//                       hintText: "Type Your Message",
//                       textInputType: TextInputType.text,
//                       controller: chatController,
//                     ),
//                   ),
//                   SizedBox(
//                     width: 15,
//                   ),
//                   Container(
//                     margin: EdgeInsets.only(right: 10),
//                     child: GestureDetector(
//                       child: Image.asset(
//                         "assets/Group 23.png",
//                         width: 42,
//                         height: 42,
//                       ),
//                       onTap:  () {
//                         // setState(() {
//                         //   isSending = true;
//                         // });
//                         _scrollToLastMessage();
//                         sendMessage();
//                         // chatController.clear();
//                       },
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//   bool isSending = false;
//   ScrollController _scrollController = ScrollController();
//
//   final currentMessageProvider = StateProvider<String>((ref) => '');
//   void _scrollToLastMessage() {
//     // Ensure that the scroll controller has attached to the ListView.
//     // It is safer to perform the scroll only when the widget is built.
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       if (_scrollController.hasClients) {
//         _scrollController.animateTo(
//           _scrollController.position.maxScrollExtent,
//           duration: Duration(milliseconds: 300),
//           curve: Curves.easeOut,
//         );
//       }
//     });
//   }
//
//   void sendMessage() async {
//     print("john"+widget.users![0].id.toString());
//     SharedPreferences userpref = await SharedPreferences.getInstance();
//     var myId = userpref.getInt("userId");
//     final message = chatController.text;
//     await ChatMessageService()
//         .sendMessage(myId.toString(), widget.users![0].id.toString().toString(), chatController.text)
//         .then((_) async {
//       // ref.read(currentMessageProvider.notifier).state = message; // Update the current message
//       chatController.clear();
//       isSending = false;
//       await getMessages();
//       setState(() {});
//       print("succssfully sent");
//     });
//   }
// }

