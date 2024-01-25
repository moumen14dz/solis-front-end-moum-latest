import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:newproject/networking/rest_client/rest_client.dart';
import 'package:newproject/providers/global_providers.dart';
import 'package:newproject/utils/handler/network_response_handler.dart';

import '../../model/messages_model.dart';

abstract class ChatMessageRepository {
  Future<NetworkResponseHandler<MessageResponseModel>> getMessages({
    required String conversation_id,
    required String bearerToken,
  });
}

final chatMessageRepositoryProvider =
Provider<ChatMessageRepositoryImpl>((ref) {
  return ChatMessageRepositoryImpl(RestClient(ref.watch(dioProvider)));
});

class ChatMessageRepositoryImpl implements ChatMessageRepository {
  RestClient client;

  ChatMessageRepositoryImpl(this.client);

  @override
  Future<NetworkResponseHandler<MessageResponseModel>> getMessages(
      {required String conversation_id,
        required String bearerToken,
      }) async{
    try {
      final response = await client.getMessages(
        bearerToken,
          conversation_id,
      );
      print("INBOX_API: ${response.toString()}");

      if (response.code == 200) {
        return NetworkResponseHandler(

          isSuccess: true,
          data: response,
        );
      } else {
        return NetworkResponseHandler(
          isSuccess: false,
          errorMessage: response.message ?? 'Unknown error',
        );
      }
    } catch (e) {
      print("An exception was caught: $e");
      if (e is DioError) {
        // Handle Dio specific errors here
        return NetworkResponseHandler(
          isSuccess: false,
          errorMessage: e.message,
        );
      } else {
        // Handle other kinds of errors
        return NetworkResponseHandler(
          isSuccess: false,
          errorMessage: 'Message: ${e.toString()}',
        );
      }
    }
  }
}


//       if (response.code == 200) {
//         debugPrint("${TAG} : 100");
//         return NetworkResponseHandler(
//           isSuccess: true,
//           data: response,
//         );
//       } else {
//         debugPrint("${TAG} : 500 ${response.message ?? 'Unknown error'}");
//         return NetworkResponseHandler(
//           isSuccess: false,
//           errorMessage: response.message ?? 'Unknown error',
//         );
//       }
//     } catch (e) {
//       print("An exception was caught: $e");
//       debugPrint("${TAG} : 1000 ${e}");
//       if (e is DioError) {
//         debugPrint("${TAG} : 450 ${e}");
//         // Handle Dio specific errors here
//         return NetworkResponseHandler(
//           isSuccess: false,
//           errorMessage: e.message,
//         );
//       } else {
//         debugPrint("${TAG} : 250 ${e}");
//         // Handle other kinds of errors
//         return NetworkResponseHandler(
//           isSuccess: false,
//           errorMessage: 'Unknown error occurred',
//         );
//       }
//     }
//   }
// }
