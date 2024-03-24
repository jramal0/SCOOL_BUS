  import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:realtime/firebase_options.dart';
import 'package:realtime/profile.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
   Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
   runApp(HomePage());}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home:loginpage(),
    );
  }
}

class loginpage extends StatefulWidget {
  const loginpage({super.key});
 
  @override
  State<loginpage> createState() => _loginpageState();
}

class _loginpageState extends State<loginpage> {

 Future<FirebaseApp> intializeFirebase() async{
  FirebaseApp firebaseApp =await Firebase.initializeApp(
     options: FirebaseOptions(
      apiKey:  "AIzaSyCQZHFrank5aRkScOHsqgD2XWZpreWIlhg", // paste your api key here
      appId: "1:485871613569:android:c3ecc3dbf37afe83d5ff80", //paste your app id here
      messagingSenderId: "485871613569", //paste your messagingSenderId here
      projectId: "new1-26233", //paste your project id here
    ),
  );
  return firebaseApp;
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
       //resizeToAvoidBottomInset : false,
      body:FutureBuilder(
        future: intializeFirebase()
      , builder: (context, snapshot){
        if (snapshot.connectionState== ConnectionState.done){
          return loginScreen();
        }
        return  const Center(
          child: CircularProgressIndicator(),
        );
      })
  
    
    );
  }
}

class loginScreen extends StatefulWidget {
  const loginScreen({super.key});

  @override
  State<loginScreen> createState() => _loginScreenState();
}



class _loginScreenState extends State<loginScreen> {

static Future<User?> loginUsingEmailPassword({
  required String email,
  required String password,
  required BuildContext context}) async{
  
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user;
  try{
    UserCredential userCredential=await auth.signInWithEmailAndPassword(
      email: email, 
      password: password);
      user=userCredential.user;
  }on FirebaseAuthException catch (e){
    if (e.code=="user-not-found"){
      print("No User found for that email");
    }
  }
  return user;

  }


  @override
  Widget build(BuildContext context) {
    TextEditingController _emailController=TextEditingController();
    TextEditingController _passwordController=TextEditingController();
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           const Text(
            "MyApp Title",
            style: TextStyle(
              color: Colors.black,
              fontSize:28.0,
              fontWeight:FontWeight.bold,

            ),
          ),
          const Text(
            "Login to your app",
            style: TextStyle(
              color: Colors.black,
              fontSize: 44.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height:44.0,
          ),
           TextField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              hintText: "User Email",
              prefixIcon: Icon(Icons.mail,color:Colors.black),
            )
          ),const SizedBox(
            height: 26.0,
          ),
           TextField(
            controller: _passwordController,
            obscureText: true,
            decoration: const InputDecoration(
              hintText: "User Password",
              prefixIcon: Icon(Icons.lock,color:Colors.black),
            ) ,
          ),
          const SizedBox(
            height: 12.0,
          ),
          const Text(
            "Don't Remember your password?",
            style: TextStyle(color: Colors.blue),
            ),
            const SizedBox(
            height: 88.0,
          ),
          Container(
            width: double.infinity,
            child: RawMaterialButton(
              fillColor:const  Color(0xFF0069FE),
              elevation: 0.0,
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0)),
              onPressed: () async{
                User? user = await loginUsingEmailPassword(email: _emailController.text, password: _passwordController.text, context: context);
                print(user);
                if(user !=null){
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => profile()));
                }
              },
            child:const  Text("Login",
            style: TextStyle(
              color:Colors.white,
              fontSize: 18.0

            ),),
            ),
          )
        ],
      ),
      );
  }
}

