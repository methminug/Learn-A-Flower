import 'package:flutter/material.dart';
import 'package:learn_a_flower_app/helpers/colors.dart';
import 'package:learn_a_flower_app/routes/route_generator.dart';
import 'package:learn_a_flower_app/screens/home/my_home_page.dart';
import 'package:learn_a_flower_app/screens/login_screen.dart';
import 'package:learn_a_flower_app/screens/quiz/quiz_management/quiz_list.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  //TODO: check
  // await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Learn A Flower',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
        primaryColor: AppColors.primary,
      ),
      debugShowCheckedModeBanner: false,
      routes: RouteGenerator.getRoute(),
      //Should add auth logic to home:
      //home: MyHomePage(title: 'Learn A Flower'),
      home: const LoginScreen(),
    );
  }
}
