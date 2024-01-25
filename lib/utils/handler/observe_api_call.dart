import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:newproject/screens/privacy/privacy_policy.dart';
import 'package:newproject/utils/start_activity.dart';
import 'package:newproject/view_models/log_in_notifier.dart';
import 'package:newproject/view_models/registration_notifier.dart';

class ObserveApiCall extends ConsumerWidget {
  const ObserveApiCall({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      title: const Text('Processing...'),
      content: ref.watch(regNotifierProvider).when(
        data: (model) {
          log("modal${model.toJson()}");
          if (model.code == 200) {
            // Navigate to PrivacyPolicy screen
            Future.delayed(const Duration(seconds: 3), () {
              Navigator.of(context).pop(); // Close the dialog
              StartActivity().start(context, const PrivacyPolicy());
            });
            return Text(model.message);
          } else {
            // Show error message
            return Text('Error: ${model.data}');
          }
        },
        error: (error, stackTrace) {
          // Show error message
          return Text('An error occurred: ${error.toString()}');
        },
        loading: () {
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

// class ObserveLogIn extends ConsumerWidget {
//   const ObserveLogIn({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return Dialog(
//       child: Container(
//         height: 200,
//         child: Consumer(
//           builder: (context, watch, child) {
//             final observeLogInResponse = ref.watch(logInNotifierProvider);
//
//             return observeLogInResponse.when(
//                 data: (data) {
//                   debugPrint("SUCCESS");
//                   Future.microtask(() => Navigator.pop(context, data));
//                   return const Center(child: Text("Success"),);
//                 },
//                 error: (error, s){
//                   return Center(child: Text(error.toString()),);
//                 },
//                 loading: () {
//                   return const Center(child: CircularProgressIndicator(),);
//                 });
//           },
//         ),
//       ),
//     );
//   }
// }

class ObserveLogIn extends ConsumerWidget {
  const ObserveLogIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dialog(
      child: SizedBox(
        height: 200,
        child: Consumer(
          builder: (context, watch, child) {
            final observeLogInResponse = ref.watch(logInNotifierProvider);

            return observeLogInResponse.when(data: (data) {
              debugPrint("DIALOG_CHECK: SUCCESS}");
              Future.microtask(() => Navigator.pop(context, data));
              return const Center(
                child: Text("Success"),
              );
            }, error: (error, s) {
              debugPrint("DIALOG_CHECK: ERROR ${error.toString()}");
              return Center(
                child: Text(error.toString()),
              );
            }, loading: () {
              debugPrint("DIALOG_CHECK: LOADING}");
              return const Center(
                child: CircularProgressIndicator(),
              );
            });
          },
        ),
      ),
    );
  }
}
