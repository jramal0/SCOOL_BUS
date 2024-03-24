import "package:firebase_core/firebase_core.dart";
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

 
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey:  "AIzaSyCQZHFrank5aRkScOHsqgD2XWZpreWIlhg", // paste your api key here
      appId: "1:485871613569:android:c3ecc3dbf37afe83d5ff80", //paste your app id here
      messagingSenderId: "485871613569", //paste your messagingSenderId here
      projectId: "new1-26233", //paste your project id here
    ),
  );
  runApp(const MyApp());
}
 
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
 
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: RelTimeData(),
    );
  }
}
class RelTimeData extends StatelessWidget {
   RelTimeData({super.key});
  final ref =FirebaseDatabase.instance.ref('attendence');

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
       backgroundColor: Color.fromARGB(255, 233, 233, 233),
      appBar:AppBar(title: Text("RealTime Database"),backgroundColor: Colors.blue
    ),
    body:Column(
      children: [
        Expanded(
          child:FirebaseAnimatedList(query:ref ,itemBuilder:(context,snapshot,animation,index){
            return ListTile(
              title: Text(
                        snapshot.child('uid').value.toString() == '639108151312' ? 'AMAL' :
                        snapshot.child('uid').value.toString() == '338968156' ? 'AKHIL' : 'Unknown UID'
                        
                         
                        
),

            );
          }))
      ],
    ),
    );
  }
}
 