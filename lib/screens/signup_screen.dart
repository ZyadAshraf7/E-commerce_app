import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_shop_app/screens/home_screen.dart';
import 'package:my_shop_app/screens/login_screen.dart';

class SignUpScreen extends StatelessWidget {
  static const routeName = "/sign up screen";
  String email;
  String password;
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF9F9F9),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: ListView(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height-100,
            padding: const EdgeInsets.symmetric(horizontal:16.0),
            child: Column(
              children: [
                Text('Sign up',style: TextStyle(fontSize: 25,fontFamily: 'Roboto Bold'),),
                SizedBox(height: 40,),
                Card(
                  child: TextFormField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(20),
                      hintText: 'Name',
                      prefixIcon: Icon(Icons.person),
                      // contentPadding: EdgeInsets.symmetric(horizontal: 8)
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Card(
                  child: TextFormField(
                    onChanged: (value){
                      email = value;
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(20),
                      hintText: 'Email',
                      prefixIcon: Icon(Icons.email),
                      // contentPadding: EdgeInsets.symmetric(horizontal: 8)
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Card(
                  child: TextFormField(
                    onChanged: (value){
                      password = value;
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(20),
                        hintText: 'Password',
                        prefixIcon: Icon(Icons.lock)
                    ),
                  ),
                ),
                SizedBox(height: 30,),
                GestureDetector(
                  onTap: () async {
                    try {
                      final newUser = await _auth
                          .createUserWithEmailAndPassword(
                          email: email, password: password);
                      Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
                    }catch(e){
                      print(e.toString());
                    }
                  },
                  child: Container(
                    height: 40,
                    width: MediaQuery.of(context).size.width,
                    child: Center(child: Text("Sign up",style: TextStyle(color: Colors.white,fontSize: 20))),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Already have an account?',style: TextStyle(fontSize: 18),),
                      FlatButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, LoginScreen.routeName);
                        },
                        child: Text('Login',style: TextStyle(fontSize: 18,color: Theme.of(context).primaryColor),
                        ),
                      ),
                    ]
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
