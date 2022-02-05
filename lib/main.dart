//ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, file_names
import 'package:flutter/material.dart';
import 'package:produlacmovil/pages/loginPage.dart';
import 'package:produlacmovil/routers/routes.dart' as route;

import 'components/app_theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: AppTheme.textTheme,
        platform: TargetPlatform.iOS,
      ),
      initialRoute: '/',
      onGenerateRoute: route.generateRoute,
      home: LoginPage(),
    );
  }
}
