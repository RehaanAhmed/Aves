
import 'package:avesproj/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: Homepage(),
    );
  }
}
class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  Future<FirebaseApp> _initializerFirebase() async{
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _initializerFirebase(),
        builder: (context, snapshot){
          if(snapshot.connectionState==ConnectionState.done){
            return LoginPage();
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
