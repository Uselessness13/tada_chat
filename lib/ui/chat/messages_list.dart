import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tada_chat/cubit/auth/auth_cubit.dart';
import 'package:tada_chat/cubit/cubit/chat_cubit.dart';
import 'package:tada_local_storage/models/message.dart';

import 'message_container.dart';

class MessagesList extends StatefulWidget {
  MessagesList({
    Key? key,
  }) : super(key: key);

  @override
  _MessagesListState createState() => _MessagesListState();
}

class _MessagesListState extends State<MessagesList> {
  String username = '';

  @override
  void initState() {
    username = (context.read<AuthCubit>().state as Authenthicated).username;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<ChatCubit, ChatState>(
        builder: (context, state) {
          if (state is ChatLoaded) {
            final List messages = state.messages;
            return ListView.builder(
              reverse: true,
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              itemCount: messages.length,
              shrinkWrap: true,
              padding: EdgeInsets.only(top: 10, bottom: 10),
              itemBuilder: (context, index) {
                final Message message = messages[index];
                return MessageContainer(
                  message: message,
                  myMessage: message.sender.username == username,
                );
              },
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
