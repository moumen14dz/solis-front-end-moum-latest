import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:newproject/common/constant.dart';
import 'package:newproject/utils/colors.dart';
import 'package:newproject/utils/controllers.dart';
import 'package:newproject/utils/requestAPIController.dart';
import 'package:newproject/utils/textformfield.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../model/UsersListModel.dart';
import '../../../model/message_response_model.dart';
import '../../../networking/repository/Chat_Service.dart';

class AccountChatPage extends ConsumerStatefulWidget {
  final List<User>? users;
  final List<Message>? messages;
  final Users? item;
  final String? convId;
  final String id;
  const AccountChatPage({
    super.key,
    this.users,
    this.messages,
    this.item,
    this.convId,
    required this.id,
  });

  @override
  ConsumerState<AccountChatPage> createState() => _AccountChatPageState();
}

class _AccountChatPageState extends ConsumerState<AccountChatPage> {
  List<dynamic> getallmessages = [];
  bool isLoading = false; // Add a loading flag
  String conversation_Id = '';
  List<MessagesResponseModel> obj = [];
  String universityName = '';

  @override
  void initState() {
    log(widget.item!.image!);
    // Timer.periodic(const Duration(seconds: 1), (timer) {
    getMessageThreads();

    super.initState();
    setState(() {});
    // });
  }

  getMessageThreads() async {
    setState(() {
      isLoading = true;
    });
    String token = await getToken();
    // APIRequests()
    SharedPreferences userpref = await SharedPreferences.getInstance();
    var myId = userpref.getInt("userId");
    await APIRequests().getAccountinbox(widget.item!.id.toString());
    try {
      conversation_Id = chatAccountInbox.data!
          .firstWhere(
            (element) {
              if (chatAccountInbox.data![0].messages![0].userId == myId) {
                return true;
              }
              return false;
            },
          )
          .messages![0]
          .conversationId!
          .toString();
    } catch (e) {
      // Handle the BadStateError here
      conversation_Id = "0";
    }
    print("object12$conversation_Id");
    await ChatMessageService()
        .getMessages(conversation_Id)
        .then((value) => setState(() {
              getallmessages = value;
              isLoading = false;
            }));
    _scrollToLastMessage();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    print("conv$obj");
    print("convv${widget.item!.id}");
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
                  backgroundImage: (!(widget.item!.image!.startsWith("http")) ||
                          (widget.item!.image!.startsWith("https")))
                      ? const NetworkImage(
                          "https://randomuser.me/api/portraits/men/5.jpg")
                      : NetworkImage(widget.item!.image!),
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
                        (widget.item != null)
                            ? widget.item!.firstName ?? 'No Name'
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
                      Text(
                        "Online",
                        style: TextStyle(
                            color: Colors.grey.shade600, fontSize: 13),
                      ),
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
          : (getallmessages == null)
              ? const Center(
                  child: Text("No messages to display."),
                )
              : Stack(
                  children: <Widget>[
                    Consumer(builder: (context, watch, child) {
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

                            return SingleChildScrollView(
                              child: ListTile(
                                  leading: isUser
                                      ? null
                                      : const CircleAvatar(
                                          // Replace with AI's profile image
                                          backgroundImage:
                                              AssetImage('assets/Mask.png'),
                                        ),
                                  trailing: isUser
                                      ? const CircleAvatar(
                                          // Replace with John's profile image
                                          backgroundImage:
                                              AssetImage('assets/Mask.png'),
                                        )
                                      : null,
                                  title: Container(
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
                                      child: Text(
                                        messageText, // Use the current message if it's the user's message
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
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
                            );
                          } else {
                            // This is the extra padding item
                            return const SizedBox(
                                height:
                                    45); // Add your desired amount of space here
                          }
                        },
                      );
                    }),
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
                                suIcon: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.asset(
                                    "assets/face-smile.png",
                                    height: 12,
                                    width: 12,
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
    print("john${widget.item!.id}");
    SharedPreferences userpref = await SharedPreferences.getInstance();
    var myId = userpref.getInt("userId");
    final message = chatController.text;
    await ChatMessageService()
        .sendMessage(myId.toString(), widget.item!.id.toString().toString(),
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

