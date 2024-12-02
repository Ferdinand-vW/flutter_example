// import 'dart:ffi' as ffi;

import 'package:easy_isolate/easy_isolate.dart';
import 'package:flutter/material.dart';
import 'package:flutterviz/NewScreen.dart';
import 'package:gif_view/gif_view.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';
// import 'package:window_size/window_size.dart';

void main() async {
    WidgetsFlutterBinding.ensureInitialized();
    // setWindowMaxSize(const Size(400, 1000));
    await windowManager.ensureInitialized();
    WindowOptions windowOptions = WindowOptions(
    size: Size(346, 580),
  );

  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.setResizable(false);
    await windowManager.show();
    await windowManager.focus();
  });

    var worker = Worker();
    var myAppState = MyAppState(worker);
    await worker.init(myAppState.progressHandler, MyAppState.newPoemHandler, errorHandler:print);

  runApp(ChangeNotifierProvider(
      create: (context) => myAppState,
      child: MyApp(),
    ),);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlutterViz Demo',

      /// TODO Replace with your first screen class name
      home: NewScreen(),
    );
  }
}
