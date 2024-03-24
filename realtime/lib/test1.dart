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
  runApp(MyApp());
}
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Value Comparison',
      home: ValueComparisonPage(),
    );
  }
}

class ValueComparisonPage extends StatefulWidget {
  @override
  _ValueComparisonPageState createState() => _ValueComparisonPageState();
}

class _ValueComparisonPageState extends State<ValueComparisonPage> {
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref('attendence');
  String _firebaseValue = '';
  String _valueToCompare = '338968156';
  String _comparisonResult = '';

  @override
  void initState() {
    super.initState();
    _compareValue();
  }

  void _compareValue() {
    _dbRef.child('uid').get().then((DataSnapshot snapshot) {
      if (snapshot.exists) {
        setState(() {
          _firebaseValue = snapshot.value.toString();
          // Update the comparison result based on whether the values are equal
          _comparisonResult = _firebaseValue == _valueToCompare
            ? 'The values are equal.'
            : 'The values are not equal.';
        });
      }
    }).catchError((error) {
      setState(() {
        _comparisonResult = 'Failed to read value: $error';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firebase Value Comparison'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Firebase Value: $_firebaseValue'),
            SizedBox(height: 20), // Adds space between the two text widgets
            Text(_comparisonResult),
          ],
        ),
      ),
    );
  }
}