import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tada_chat/main_bloc_provider.dart';
import 'package:tada_local_storage/local_storage_helper.dart';

void main() async {
  await Hive.initFlutter();
  TadaLocalStorageHelper helper = TadaLocalStorageHelper();
  await helper.init();
  runApp(MaterialApp(
    title: 'TADA CHAT',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: RepositoryProvider(
      create: (context) => helper,
      child: MainBlocProvider(),
    ),
  ));
}
