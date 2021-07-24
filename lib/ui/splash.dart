import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tada_chat/app.dart';
import 'package:tada_chat/cubit/auth/auth_cubit.dart';
import 'package:tada_chat/cubit/socket/socket_cubit.dart';
import 'package:tada_chat/ui/auth/auth_screen.dart';

class SplashScreen extends StatelessWidget {
  static final String routeName = 'splash';
  SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance?.addPostFrameCallback((timeStamp) {
      Future.delayed(Duration(milliseconds: 300))
          .then((value) => context.read<AuthCubit>().checkAuth());
    });
    return Scaffold(
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is Authenthicated) {
            context.read<SocketCubit>().initSocket(state.username);
            Navigator.of(context).pushReplacementNamed(App.routeName);
          }
          if (state is Unauthenthicated) {
            Navigator.of(context).pushReplacementNamed(AuthScreen.routeName);
          }
        },
        child: Center(
          child: Hero(
            tag: 'app_name',
            child: Text(
              'TADA CHAT',
              style: Theme.of(context).textTheme.headline2,
            ),
          ),
        ),
      ),
    );
  }
}
