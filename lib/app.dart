import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
        elevation: 0,
        title: Text(
          "TADA CHAT",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              if (state is Authenthicated)
                return IconButton(
                    onPressed: () {
                      context.read<AuthCubit>().unAuthUser();
                      context.read<SocketCubit>().closeSink();
                    },
                    icon: Icon(
                      Icons.exit_to_app,
                      // color: Colors.black,
                    ));
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
              return RoomList();
            } else if (authState is Unauthenthicated) return AuthScreen();
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(
          Icons.add,
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
      ),
    );
  }
}
