import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tada_chat/cubit/cubit/chat_cubit.dart';
import 'package:tada_chat/cubit/rooms/rooms_cubit.dart';
import 'package:tada_chat/ui/chat/chat_screen.dart';
import 'package:tada_chat/ui/room_list/room_list.dart';
import 'package:tada_chat/ui/splash.dart';
import 'package:tada_local_storage/models/room.dart';

import 'cubit/auth/auth_cubit.dart';
import 'cubit/socket/socket_cubit.dart';
import 'ui/create_chat_form.dart';

class App extends StatefulWidget {
  static const String routeName = 'app';
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  bool showFab = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "TADA CHAT",
        ),
        actions: [
          BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              if (state is Authenthicated) {
                return PopupMenuButton<String>(
                  onSelected: (value) {
                    if (value == 'Logout') {
                      context.read<AuthCubit>().unAuthUser();
                      context.read<SocketCubit>().closeSink();
                      Navigator.of(context)
                          .pushReplacementNamed(SplashScreen.routeName);
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.settings, color: Colors.grey),
                  ),
                  itemBuilder: (BuildContext context) {
                    return {
                      'Username: ${state.username}',
                      'Logout',
                    }.map((String choice) {
                      return PopupMenuItem<String>(
                        value: choice,
                        child: Text(choice),
                        enabled: choice == 'Logout',
                      );
                    }).toList();
                  },
                );
              }
              return Container();
            },
          ),
        ],
      ),
      body: SafeArea(
        child: RoomList(),
      ),
      floatingActionButton: showFab
          ? Builder(
              builder: (context) => FloatingActionButton(
                onPressed: () {
                  setState(() {
                    showFab = false;
                  });
                  showBottomSheet(
                      context: context,
                      builder: (context) {
                        return CreateNewChatForm(
                          onSendButtonPressed: (chatName) {
                            final room = Room(name: chatName);
                            context.read<RoomsCubit>().createRoom(room);
                            context.read<ChatCubit>().loadRoom(room.name);
                            Navigator.of(context).pop();
                            Navigator.of(context).pushNamed(
                                ChatScreen.routeName,
                                arguments: room.name);
                          },
                        );
                      }).closed.then((value) {
                    setState(() {
                      showFab = true;
                    });
                  });
                },
                child: Icon(
                  Icons.add,
                ),
              ),
            )
          : Container(),
    );
  }
}
