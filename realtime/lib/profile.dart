//import "package:firebase_core/firebase_core.dart";
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';




class profile extends StatefulWidget {
  const profile({Key? key}) : super(key: key);

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
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
 