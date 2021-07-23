import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tada_chat/cubit/cubit/chat_cubit.dart';
import 'package:tada_chat/cubit/rooms/rooms_cubit.dart';
import 'package:tada_chat/ui/auth/auth_screen.dart';
import 'package:tada_chat/ui/room_list/room_list.dart';

import 'cubit/auth/auth_cubit.dart';
import 'cubit/socket/socket_cubit.dart';

class App extends StatelessWidget {
  static const String routeName = 'app';
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TADA CHAT"),
        actions: [
          BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              if (state is Authenthicated)
                return IconButton(
                    onPressed: () {
                      context.read<AuthCubit>().unAuthUser();
                    },
                    icon: Icon(Icons.exit_to_app));
              return Container();
            },
          ),
        ],
      ),
      body: SafeArea(
        child: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, authState) {
            if (authState is Authenthicated) {
              context.read<SocketCubit>().initSocket(authState.username);
              return BlocListener<SocketCubit, SocketState>(
                listener: (context, state) {
                  if (state is NewMessageRecieved) {
                    context.read<RoomsCubit>().loadRooms();
                    ChatState chatState = context.read<ChatCubit>().state;
                    if (chatState is ChatLoaded) {
                      if (chatState.messages[0].room == state.message.room) {
                        context
                            .read<ChatCubit>()
                            .loadRoom(state.message.room, authState.username)();
                      }
                    }
                  }
                },
                child: RoomList(),
              );
            } else if (authState is Unauthenthicated) return AuthScreen();
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
