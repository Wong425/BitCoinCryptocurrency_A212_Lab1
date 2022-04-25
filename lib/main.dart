import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'mainpage.dart';



void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BitCoin Cryptocurrency App',
      theme: ThemeData(
          // primarySwatch: Colors.blue,
          ),
      home: const SplashScreen(title: 'BitCoin Cryptocurrency'),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key, required String title}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 5),
        () => Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (content) => const MainPage())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
            Image.asset('assets/images/image1.png', scale: 2),
            SpinKitCubeGrid(
              size: 70,
              itemBuilder: (context, index) {
                final colors = [Colors.red, Colors.white, Colors.green,Colors.yellow];
                final color = colors[index % colors.length];
                return DecoratedBox(decoration: BoxDecoration(color: color));
              },
            ),
            const Text("WELCOME TO \n BITCION CRYPTOCURRENCY APP",textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ))
          ]),
        ));
  }
}
