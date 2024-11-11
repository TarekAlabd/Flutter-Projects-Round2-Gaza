import 'package:chat_app/core/services/firestore_services.dart';
import 'package:chat_app/core/utils/api_paths.dart';
import 'package:chat_app/features/auth/services/auth_services.dart';
import 'package:chat_app/features/chat/models/message_model.dart';

class ChatServices {
  final firestoreServices = FirestoreService.instance;
  final authServices = AuthServicesImpl();

  Future<void> sendMessage(MessageModel message) async {
    try {
      await firestoreServices.setData(
        path: ApiPaths.message(message.id),
        data: message.toMap(),
      );
    } catch (e) {
      rethrow;
    }
  }

  Stream<List<MessageModel>> getMessages() {
    try {
      return firestoreServices.collectionStream(
        path: ApiPaths.messages(),
        builder: (data, documentId) {
          final user = authServices.getUserInit();
          var message = MessageModel.fromMap(data);
          if (message.senderId == user?.uid) {
            message = message.copyWith(isMine: true);
          }
          return message;
        },
      );
    } catch (e) {
      rethrow;
    }
  }
}
