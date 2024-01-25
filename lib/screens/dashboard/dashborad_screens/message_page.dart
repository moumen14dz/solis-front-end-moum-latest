import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:newproject/screens/chat/chat_page.dart';
import 'package:newproject/utils/colors.dart';
import 'package:newproject/utils/controllers.dart';

import '../../../model/message_response_model.dart';
import '../../../utils/requestAPIController.dart';
import 'chatFriendsList.dart';

class MessagePage extends ConsumerStatefulWidget {
  const MessagePage({super.key});

  @override
  ConsumerState<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends ConsumerState<MessagePage> {
  List<dynamic> getallmessagethreads = [];
  bool isLoading = true; // Add a loading flag
  TextEditingController searchController = TextEditingController();
  void filterThreads(String query) {
    setState(() {
      getFilterThreads = chatInbox.data!.where((thread) {
        List<User> users = thread.users!;
        if (users.isNotEmpty) {
          String firstName = users[0].firstName ?? '';
          return firstName.toLowerCase().contains(query.toLowerCase());
        }
        return false;
      }).toList();
    });
  }

  @override
  void initState() {
    super.initState();
    getMessages();
  }

  getMessages() async {
    isLoading = true;
    await APIRequests().getinbox();
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    print("mes$getallmessagethreads");
    return Scaffold(
      backgroundColor: mainColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 40,
          ),
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
            child: TextFormField(
              controller: searchController,
              onChanged: filterThreads,
              style: const TextStyle(color: Colors.white, fontSize: 14),
              decoration: InputDecoration(
                  filled: true,
                  fillColor: mainColor,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: const BorderSide(color: mainTextFormColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: mainTextFormColor),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: mainTextFormColor),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: mainTextFormColor),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: mainTextFormColor),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  border: InputBorder.none,
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      "assets/search-01.png",
                      height: 12,
                    ),
                  ),
                  hintText: "Search Chat".tr,
                  hintStyle:
                      TextStyle(color: const Color(0xffFFFFFF).withOpacity(.3))),
            ),
          ),
          Expanded(
            child: isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : buildMessageList(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (builder) => const ChatEmogiPage()));
          //
        },
        shape: const CircleBorder(),
        backgroundColor: Colors.white,
        child: Image.asset(
          "assets/edit.png",
          height: 30,
          width: 40,
        ), // You can change the FAB icon
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget buildMessageList() {
    if (searchController.text.isNotEmpty && getFilterThreads!.isEmpty) {
      return Center(
        child: Column(children: [
          const Spacer(),
          Image.asset(
            "assets/EmptyState.png",
            fit: BoxFit.cover,
            height: 200,
          ),
          const Text(
            "No Results Found",
            style: TextStyle(
                color: textColor, fontSize: 20, fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 10,
          ),
          const Spacer(),
          const Spacer(),
        ]),
      );
    } else {
      List<DataThreads> sortedThreads = searchController.text.isNotEmpty
          ? getFilterThreads!
          : List.from(chatInbox.data!);
      // Display the list of message threads
      sortedThreads.sort((a, b) {
        // Compare the timestamps of the last messages in threads a and b
        DateTime? timestampA =
            a.messages!.isNotEmpty ? a.messages!.last.createdAt : DateTime(0);
        DateTime? timestampB =
            b.messages!.isNotEmpty ? b.messages!.last.createdAt : DateTime(0);
        return timestampB!.compareTo(timestampA!);
      });

      return SizedBox(
        height: MediaQuery.of(context).size.height / 1.4,
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: searchController.text.isNotEmpty
                ? getFilterThreads!.length
                : chatInbox.data!.length,
            itemBuilder: (BuildContext context, int index) {
           

              final item = searchController.text.isNotEmpty

                  ? getFilterThreads![index]
                  : chatInbox.data![index];
                                              log('imqgggge${item.toJson()}');

              List<User> users = item.users!;
              List<Message> messages = item.messages!;
                                          log('imqggggeddddd${users.length}');
                                         // log('imqggggeddddd${users.first.image}');
                                             String image = '';
                                             if (users.isNotEmpty) {
              if (users.first.image != null &&
                  (users.first.image!.contains('http') ||
                      users.first.image!.contains('https'))) {
                image = Uri.parse(users.first.image!).toString();}}
               
                           // log('imqggggedccccc${userslist.data?.first.toJson()}');
                           // log('imqggggeddddd$image');


              // List<dynamic> conversId = messages[1]['converstation_id'];
              int? isRead = item.messages != null &&
                      index >= 0 
                      && item.messages!.isNotEmpty
                      //index < 
                  ? item.messages![0].isRead  
                  : 1;

                  isRead = item.unreadMessagesCount == 0 ? 1:0;
                             //   log('imqggggeddd${item.users!.first.toJson()}');

 
              return Padding(
                padding: const EdgeInsets.all(4.0),
                child: ListTile(
                  onTap: () {
               //     print("sesss${users[0].pivot!.conversationId}");
                    if (item.messages != null) {
                      print("Index: $index");
                      print("Messages Length: ${item.messages!.length}");
                      if (item.messages!.isNotEmpty) {
                        // Mark the message as "read" when the user opens it
                        setState(() {
                          isRead = 1;
                          item.messages?.clear();
                         // item.messages![index].isRead = 1;
                        });
                      } else {
                        print("Index out of bounds: $index");
                      }
                    }
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (builder) => ChatPage(
                                users: users,
                                messages: messages,
                                convId: users[0]
                                    .pivot!
                                    .conversationId
                                    .toString())));
                  },
                  leading: CircleAvatar(
                      // ignore: unnecessary_null_comparison
                      backgroundImage: image != null && image != ''
                          ? NetworkImage(image) as ImageProvider
                          : const AssetImage("assets/profileblue.png")),
                  title: Text(
                    users.isNotEmpty
                        ? users[0].firstName ?? 'No Name'
                        : 'No User',
                    style: const TextStyle(
                        color: Color(0xffF9FAFB),
                        fontWeight: FontWeight.w600,
                        fontSize: 18),
                  ),
                  subtitle: Text(
                    (messages.isNotEmpty)
                        ? messages.last.message!
                        : 'No Message',
                    style: const TextStyle(
                        fontWeight: FontWeight.w400, color: Color(0xffA2A5AA)),
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      // if (isRead!=0)
                      Visibility(
                        visible:
                            isRead == 0, // Show the circle if isRead is not 0
                        child: Container(
                          width: 12,
                          height: 12,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: buttonColor,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        messages.isNotEmpty
                            ? DateFormat('hh:mm a').format(DateTime.parse(
                                messages.last.createdAt.toString()))
                            : "",
                        style: const TextStyle(color: timeColor),
                      )
                    ],
                  ),
                ),
              );
            }),
      );
    }
  }
}
// class MessagePage extends ConsumerStatefulWidget {
//   const MessagePage({super.key});
//
//   @override
//   ConsumerState<MessagePage> createState() => _MessagePageState();
// }
//
// class _MessagePageState extends ConsumerState<MessagePage> {
//   MessageResponseModel? messages; // List to hold chat messages
//
//   @override
//   Widget build(BuildContext context) {
//     final observemessagesList = ref.watch(chatMessageRepositoryProvider);
//
//
//     return Scaffold(
//       backgroundColor: mainColor,
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const SizedBox(
//             height: 40,
//           ),
//           Container(
//             margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
//             child: TextFormField(
//               onTap: () {
//                 Navigator.push(context,
//                     MaterialPageRoute(builder: (builder) => EmptyMessage()));
//               },
//               style: TextStyle(color: Colors.white, fontSize: 14),
//               decoration: InputDecoration(
//                   filled: true,
//                   fillColor: mainColor,
//                   enabledBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(6),
//
//                     borderSide: BorderSide(color: mainTextFormColor),
// //<-- SEE HERE
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderSide: BorderSide(color: mainTextFormColor),
//                     borderRadius: BorderRadius.circular(6),
//                   ),
//                   disabledBorder: OutlineInputBorder(
//                     borderSide: BorderSide(color: mainTextFormColor),
//                     borderRadius: BorderRadius.circular(6),
//                   ),
//                   focusedErrorBorder: OutlineInputBorder(
//                     borderSide: BorderSide(color: mainTextFormColor),
//                     borderRadius: BorderRadius.circular(6),
//                   ),
//                   errorBorder: OutlineInputBorder(
//                     borderSide: BorderSide(color: mainTextFormColor),
//                     borderRadius: BorderRadius.circular(6),
//                   ),
//                   border: InputBorder.none,
//                   prefixIcon: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Image.asset(
//                       "assets/search-01.png",
//                       height: 12,
//                     ),
//                   ),
//                   hintText: "Search Chat",
//                   hintStyle:
//                       TextStyle(color: Color(0xffFFFFFF).withOpacity(.3))),
//             ),
//           ),
//           SizedBox(
//             height: MediaQuery.of(context).size.height / 1.4,
//             child: ListView.builder(
//                 itemCount: 6,
//                 itemBuilder: (BuildContext context, int index) {
//                   return Padding(
//                     padding: const EdgeInsets.all(4.0),
//                     child: ListTile(
//                       onTap: () {
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (builder) => ChatPage()));
//                       },
//                       leading: CircleAvatar(
//                           backgroundImage: AssetImage("assets/Image.png")),
//                       title: Text(
//                         "Alfredo Calzoni",
//                         style: TextStyle(
//                             color: Color(0xffF9FAFB),
//                             fontWeight: FontWeight.w600,
//                             fontSize: 18),
//                       ),
//                       subtitle: Text(
//                         "Hi How are you",
//                         style: TextStyle(
//                             fontWeight: FontWeight.w400,
//                             color: Color(0xffA2A5AA)),
//                       ),
//                       trailing: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Container(
//                             width: 12,
//                             height: 12,
//                             decoration: BoxDecoration(
//                                 shape: BoxShape.circle, color: buttonColor),
//                           ),
//                           const SizedBox(
//                             height: 10,
//                           ),
//                           Text(
//                             "09:18",
//                             style: TextStyle(color: timeColor),
//                           )
//                         ],
//                       ),
//                     ),
//                   );
//                 }),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class MessagePage extends StatefulWidget {
//   // final String token;
//   MessagePage({
//     Key? key,
//     // required this.token,
//     // required this.messages,
//   }) : super(key: key);
//
//   @override
//   State<MessagePage> createState() => _MessagePageState();
// }
//
// class _MessagePageState extends State<MessagePage> {
//   List<dynamic> getallmessagethreads = [];
//
//   void initState() {
//     getMessageThreads();
//   }
//   getMessageThreads() async {
//     String token = await getToken();
//     await ChatMessageService().getMessageThreads(token).then((value) => setState(() {
//       getallmessagethreads = value;
//     }));
//     setState(() {});
//   }
//   TextEditingController searchController = TextEditingController();
//
//   List<dynamic> filteredThreads = [];
//
//   void filterThreads(String query) {
//     setState(() {
//       filteredThreads = getallmessagethreads
//           .where((thread) {
//         List<dynamic> users = thread['users'];
//         if (users.isNotEmpty) {
//           String firstName = users[0]['first_name'] ?? '';
//           return firstName.toLowerCase().contains(query.toLowerCase());
//         }
//         return false;
//       })
//           .toList();
//     });
//   }
//   @override
//   Widget build(BuildContext context) {
//
//     return Scaffold(
//       backgroundColor: mainColor,
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const SizedBox(
//             height: 40,
//           ),
//           Container(
//             margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
//             child: TextFormField(
//               // onTap: () {
//               //   Navigator.push(context,
//               //       MaterialPageRoute(builder: (builder) => EmptyMessage()));
//               // },
//               controller: searchController,
//               onChanged: filterThreads,
//               style: TextStyle(color: Colors.white, fontSize: 14),
//               decoration: InputDecoration(
//                   filled: true,
//                   fillColor: mainColor,
//                   enabledBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(6),
//
//                     borderSide: BorderSide(color: mainTextFormColor),
// //<-- SEE HERE
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderSide: BorderSide(color: mainTextFormColor),
//                     borderRadius: BorderRadius.circular(6),
//                   ),
//                   disabledBorder: OutlineInputBorder(
//                     borderSide: BorderSide(color: mainTextFormColor),
//                     borderRadius: BorderRadius.circular(6),
//                   ),
//                   focusedErrorBorder: OutlineInputBorder(
//                     borderSide: BorderSide(color: mainTextFormColor),
//                     borderRadius: BorderRadius.circular(6),
//                   ),
//                   errorBorder: OutlineInputBorder(
//                     borderSide: BorderSide(color: mainTextFormColor),
//                     borderRadius: BorderRadius.circular(6),
//                   ),
//                   border: InputBorder.none,
//                   prefixIcon: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Image.asset(
//                       "assets/search-01.png",
//                       height: 12,
//                     ),
//                   ),
//                   hintText: "Search Chat",
//                   hintStyle:
//                   TextStyle(color: Color(0xffFFFFFF).withOpacity(.3))),
//             ),
//           ),
//           Expanded(
//             child: buildMessageList(),
//           ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//
//         },
//         child: Image.asset("assets/edit.png",height: 30,
//           width: 40 ,),shape: CircleBorder(),
//         backgroundColor: Colors.white,// You can change the FAB icon
//       ),
//
//       floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
//     );
//   }
//   Widget buildMessageList(){
//     if (searchController.text.isNotEmpty && filteredThreads.isEmpty) {
//       // Display an empty screen when search results do not match
//       return Center(
//         child: Column(
//             children:[
//               Spacer(),
//               Image.asset(
//                 "assets/EmptyState.png",
//                 fit: BoxFit.cover,
//                 height: 200,
//               ),
//               Text(
//                 "No Results Found",
//                 style: TextStyle(
//                     color: textColor, fontSize: 20, fontWeight: FontWeight.w500),
//                 textAlign: TextAlign.center,
//               ),
//               const SizedBox(
//                 height: 10,
//               ),
//               // Text(
//               //   "All incoming requests will be listed \nin this folder",
//               //   style: TextStyle(
//               //       color: textColor, fontSize: 16, fontWeight: FontWeight.w400),
//               //   textAlign: TextAlign.center,
//               // ),
//               Spacer(),
//               Spacer(),
//             ]
//         ),
//       );
//     } else {
//       // Display the list of message threads
//       return SizedBox(
//         height: MediaQuery
//             .of(context)
//             .size
//             .height / 1.4,
//         child: ListView.builder(
//             itemCount: searchController.text.isNotEmpty
//                 ? filteredThreads.length
//                 : getallmessagethreads.length,
//             itemBuilder: (BuildContext context, int index) {
//               if (getallmessagethreads.isEmpty) {
//                 // Display an empty screen with a message
//                 return Center(
//                   child: Column(
//                       children:[
//                         Spacer(),
//                         Image.asset(
//                           "assets/EmptyState.png",
//                           fit: BoxFit.cover,
//                           height: 200,
//                         ),
//                         Text(
//                           "Your inbox is empty",
//                           style: TextStyle(
//                               color: textColor, fontSize: 20, fontWeight: FontWeight.w500),
//                           textAlign: TextAlign.center,
//                         ),
//                         const SizedBox(
//                           height: 10,
//                         ),
//                         Text(
//                           "All incoming requests will be listed \nin this folder",
//                           style: TextStyle(
//                               color: textColor, fontSize: 16, fontWeight: FontWeight.w400),
//                           textAlign: TextAlign.center,
//                         ),
//                         Spacer(),
//                         Spacer(),
//                       ]
//                   ),
//                 );
//               }
//               final item = searchController.text.isNotEmpty
//                   ? filteredThreads[index]
//                   : getallmessagethreads[index];
//               List<dynamic> users = item['users'];
//               List<dynamic> messages = item['messages'];
//               bool isRead = item['is_read'] ?? false;
//               return Padding(
//                 padding: const EdgeInsets.all(4.0),
//                 child: ListTile(
//                   onTap: () {
//                     setState(() {
//                       item['is_read'] = true;
//                     });
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (builder) => ChatPage( users: users,
//                               messages: messages)));
//
//                   },
//                   leading: const CircleAvatar(
//                       backgroundImage: AssetImage("assets/Image.png")),
//                   title: Text(
//                     users.isNotEmpty
//                         ? users[0]['first_name'] ?? 'No Name'
//                         : 'No User', style: const TextStyle(
//                       color: Color(0xffF9FAFB),
//                       fontWeight: FontWeight.w600,
//                       fontSize: 18),
//                   ),
//                   subtitle: Text(
//                     messages.isNotEmpty ? messages[0]['message'] : 'No Message',
//                     style: const TextStyle(
//                         fontWeight: FontWeight.w400,
//                         color: Color(0xffA2A5AA)),
//                   ),
//                   trailing: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       if (!isRead)
//                         Container(
//                           width: 12,
//                           height: 12,
//                           decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                             color: buttonColor,
//                           ),
//                         ),
//                       const SizedBox(
//                         height: 10,
//                       ),
//                       Text(
//                         messages.isNotEmpty ? DateFormat('hh:mm a').format(
//                             DateTime.parse(messages[0]['created_at'])) : "",
//                         style: TextStyle(color: timeColor),
//                       )
//                     ],
//                   ),
//                 ),
//               );
//             }),
//       );
//     }
//   }
// }
