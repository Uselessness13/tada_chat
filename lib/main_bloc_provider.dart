import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tada_api/tada_api_helper.dart';
import 'package:tada_chat/cubit/auth/auth_cubit.dart';
import 'package:tada_local_storage/local_storage_helper.dart';

import 'app.dart';
import 'cubit/rooms/rooms_cubit.dart';

class MainBlocProvider extends StatelessWidget {
  const MainBlocProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => TadaApiHelper(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthCubit>(
              create: (context) => AuthCubit(
                  RepositoryProvider.of<TadaLocalStorageHelper>(context))
                ..checkAuth()),
          BlocProvider<RoomsCubit>(
              create: (context) =>
                  RoomsCubit(RepositoryProvider.of<TadaApiHelper>(context))
                    ..loadRooms()),
        ],
        child: App(),
      ),
    );
  }
}
