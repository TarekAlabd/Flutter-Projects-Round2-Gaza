import 'package:chat_app/core/route/app_routes.dart';
import 'package:chat_app/features/auth/auth_cubit/auth_cubit.dart';
import 'package:chat_app/features/chat/chat_cubit/chat_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final chatCubit = BlocProvider.of<ChatCubit>(context);
    final authCubit = BlocProvider.of<AuthCubit>(context);

    return Scaffold(
      appBar: AppBar(
        leading: null,
        title: const Text('Chat'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await authCubit.logout();
            },
          ),
        ],
      ),
      body: BlocListener<AuthCubit, AuthState>(
        bloc: authCubit,
        listenWhen: (previous, current) => current is AuthLoggedOut,
        listener: (context, state) {
          if (state is AuthLoggedOut) {
            Navigator.of(context).pushReplacementNamed(AppRoutes.auth);
          }
        },
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                Expanded(
                  child: BlocBuilder<ChatCubit, ChatState>(
                    bloc: chatCubit,
                    buildWhen: (previous, current) =>
                        current is ChatLoaded || current is ChatError,
                    builder: (context, state) {
                      if (state is ChatLoaded) {
                        final messages = state.messages;
                        if (messages.isEmpty) {
                          return const Center(
                            child: Text('No messages yet'),
                          );
                        }
                        return ListView.builder(
                          itemCount: messages.length,
                          itemBuilder: (_, index) {
                            final message = messages[index];
                            return Directionality(
                              textDirection: message.isMine
                                  ? TextDirection.ltr
                                  : TextDirection.rtl,
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                    message.senderPhotoUrl,
                                  ),
                                  radius: 40,
                                ),
                                title: Text(message.message),
                                subtitle: Text(
                                  message.senderName,
                                  style: TextStyle(
                                    color: message.isMine
                                        ? Colors.orange
                                        : Colors.blue,
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      } else if (state is ChatLoading) {
                        return const Center(
                          child: CircularProgressIndicator.adaptive(),
                        );
                      } else if (state is ChatError) {
                        return Center(
                          child: Text(state.message),
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator.adaptive(),
                        );
                      }
                    },
                  ),
                ),
                TextField(
                  controller: _messageController,
                  decoration: InputDecoration(
                    hintText: 'Type a message',
                    border: const OutlineInputBorder(),
                    suffixIcon: BlocConsumer<ChatCubit, ChatState>(
                      bloc: chatCubit,
                      listenWhen: (previous, current) =>
                          current is ChatMessageSent ||
                          current is ChatMessageSendError,
                      listener: (context, state) {
                        if (state is ChatMessageSendError) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(state.message),
                            ),
                          );
                        } else if (state is ChatMessageSent) {
                          _messageController.clear();
                        }
                      },
                      buildWhen: (previous, current) =>
                          current is ChatMessageSending ||
                          current is ChatMessageSendError ||
                          current is ChatMessageSent,
                      builder: (context, state) {
                        if (state is ChatMessageSending) {
                          return const CircularProgressIndicator.adaptive();
                        }
                        return IconButton(
                          icon: const Icon(Icons.send),
                          onPressed: () async {
                            await chatCubit
                                .sendMessage(_messageController.text);
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
