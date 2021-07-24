import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tada_api/tada_api.dart';
import 'package:tada_chat/app.dart';
import 'package:tada_chat/cubit/socket/socket_cubit.dart';
import 'package:tada_chat/ui/chat/chat_screen.dart';
import 'package:tada_local_storage/local_storage_helper.dart';

import 'cubit/auth/auth_cubit.dart';
import 'cubit/cubit/chat_cubit.dart';
import 'cubit/rooms/rooms_cubit.dart';

void main() async {
  await Hive.initFlutter();
  TadaLocalStorageHelper helper = TadaLocalStorageHelper();
  await helper.init();
  runApp(MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => helper,
        ),
        RepositoryProvider(
          create: (context) => TadaApiHelper(),
        ),
      ],
      child: MultiBlocProvider(
          providers: [
            BlocProvider<AuthCubit>(
                create: (context) => AuthCubit(
                      RepositoryProvider.of<TadaLocalStorageHelper>(context),
                    )..checkAuth()),
            BlocProvider<SocketCubit>(
                create: (context) => SocketCubit(
                      RepositoryProvider.of<TadaLocalStorageHelper>(context),
                    )),
            BlocProvider<RoomsCubit>(
                create: (context) => RoomsCubit(
                      RepositoryProvider.of<TadaApiHelper>(context),
                      RepositoryProvider.of<TadaLocalStorageHelper>(context),
                    )..loadRooms()),
            BlocProvider<ChatCubit>(
                create: (context) => ChatCubit(
                      RepositoryProvider.of<TadaApiHelper>(context),
                      RepositoryProvider.of<TadaLocalStorageHelper>(context),
                    )),
          ],
          child: MaterialApp(
            title: 'TADA CHAT',
            theme: ThemeData(
              primaryColor: Colors.white,
              accentColor: Colors.blue,
              appBarTheme: AppBarTheme(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
              ),
              iconTheme: IconThemeData(
                color: Colors.black
              )
            ),
            routes: {
              App.routeName: (context) => App(),
              ChatScreen.routeName: (context) => ChatScreen(),
            },
            home: App(),
          ))));
}
