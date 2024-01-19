import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:http_learn/service/locale_storage.dart';
import 'my_app.dart';

String? token;

Future<void> checkStorage()async{
  token = await AppStorage.read(StorageKey.token);
  log("======= $token ========");
}

void setup(){
  WidgetsFlutterBinding.ensureInitialized();
  checkStorage().then((value) {
    runApp(const MyApp());
  });
}