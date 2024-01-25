import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:newproject/networking/repository/messages_list_repository.dart';

import '../model/messages_model.dart';

class Params {
  late final String conversation_id;
  Params(this.conversation_id);
}

final ChatMessageNotifierProvider = StateNotifierProvider.family
<ChatMessageNotifier, AsyncValue<MessageResponseModel>,String>(
        (ref,paramss) {
      return ChatMessageNotifier(
          ref.watch(chatMessageRepositoryProvider),paramss
      );
    });

class ChatMessageNotifier
    extends StateNotifier<AsyncValue<MessageResponseModel>> {

  final ChatMessageRepository _repository;
  late final String bearerToken;
  Params? params;

  ChatMessageNotifier(this._repository,this.bearerToken)
      : super(const AsyncValue.loading()) {
    getMessages();
  }

  void setParams(Params p) {
    params = p;
  }

  Future<void> getMessages() async {
    try {
      state = const AsyncValue.loading();

      final response = await _repository.getMessages(bearerToken:bearerToken,conversation_id: params!.conversation_id);

      if (response.isSuccess) {
        state = AsyncValue.data(response.data!);
      } else {
        state = AsyncValue.error(response.errorMessage.toString(), StackTrace.current);
      }
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
}

  // Future<void> attemptToRegister() async {
  //   if (!mounted) return;  // Return early if not mounted
  //
  //   if (params == null) {
  //     state = AsyncValue.error('Params not set', StackTrace.current);
  //     return;
  //   }
  //
  //   try {
  //     state = const AsyncValue.loading();
  //
  //     final response = await _repository.getMessages(conversation_id: params!.conversation_id,);
  //
  //     if (mounted) {  // Check again before setting state
  //       if (response.isSuccess) {
  //         state = AsyncValue.data(response.data!);
  //       } else {
  //         state = AsyncValue.error(response.errorMessage.toString(), StackTrace.current);
  //       }
  //     }
  //   } catch (error, stackTrace) {
  //     if (mounted) {  // Check again before setting state
  //       state = AsyncValue.error(error, stackTrace);
  //     }
  //   }
  // }
}
