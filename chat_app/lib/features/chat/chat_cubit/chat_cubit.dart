import 'package:chat_app/features/auth/services/auth_services.dart';
import 'package:chat_app/features/chat/services/chat_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat_app/features/chat/models/message_model.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());

  final chatServices = ChatServices();
  final authServices = AuthServicesImpl();

  Future<void> sendMessage(String text) async {
    emit(ChatMessageSending());
    try {
      final sender = await authServices.getUserData();
      final message = MessageModel(
        id: DateTime.now().toIso8601String(),
        message: text,
        senderId: sender.uid,
        senderName: sender.name ?? 'Default',
        senderPhotoUrl: sender.photoUrl,
        dateTime: DateTime.now(),
      );

      await chatServices.sendMessage(message);
      emit(ChatMessageSent());
    } catch (e) {
      emit(ChatMessageSendError(e.toString()));
    }
  }

  Future<void> getMessages() async {
    emit(ChatLoading());
    try {
      final messageStream = chatServices.getMessages();

      messageStream.listen((messages) {
        emit(ChatLoaded(messages));
      });
    } catch (e) {
      emit(ChatError(e.toString()));
    }
  }
}
