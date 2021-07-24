import 'package:flutter/material.dart';
import 'package:tada_chat/cubit/auth/auth_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tada_chat/ui/splash.dart';

class AuthScreen extends StatefulWidget {
  static final String routeName = 'auth';
  AuthScreen({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final TextEditingController _controller = TextEditingController();
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Hero(
                  tag: 'app_name',
                  child: Text(
                    'TADA CHAT',
                    style: Theme.of(context).textTheme.headline2,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      TextField(
                        controller: _controller,
                        obscureText: false,
                        decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            hintText: "Username",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(32.0))),
                        autofocus: true,
                        maxLines: 1,
                      ),
                      if (error.isNotEmpty)
                        Text(
                          error,
                          style: TextStyle(color: Colors.red),
                        ),
                      SizedBox(
                        height: 24,
                      ),
                      Material(
                        elevation: 5.0,
                        borderRadius: BorderRadius.circular(30.0),
                        color: Theme.of(context).accentColor,
                        child: MaterialButton(
                          minWidth: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          onPressed: () {
                            if (_controller.text.isNotEmpty) {
                              context
                                  .read<AuthCubit>()
                                  .auhtUser(_controller.text);
                              Navigator.of(context)
                                  .pushReplacementNamed(SplashScreen.routeName);
                            } else
                              setState(() {
                                error = 'Enter username';
                              });
                          },
                          child: Text("Login",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                        ),
                      )
                    ],
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
