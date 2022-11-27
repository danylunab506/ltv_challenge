import 'package:flutter/material.dart';
import 'screens/main_screen/main_screen.dart';

 
void main() => runApp(const AppState());

class AppState extends StatelessWidget{
  const AppState({super.key});
  @override
  Widget build(BuildContext context) {
    return const MyApp();
  }
}
 
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: MainScreen(),
    );
  }
}