import 'package:flutter/material.dart';
import 'package:my_shop_app/screens/signup_screen.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = "/login screen";
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
                Text('Login',style: TextStyle(fontSize: 25,fontFamily: 'Roboto Bold'),),
                SizedBox(height: 40,),
                Card(
                  child: TextFormField(
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
                  onTap: () {

                  },
                  child: Container(
                    height: 40,
                    width: MediaQuery.of(context).size.width,
                    child: Center(child: Text("Login",style: TextStyle(color: Colors.white,fontSize: 20))),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Don\'t have an account?',style: TextStyle(fontSize: 18),),
                    FlatButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacementNamed(SignUpScreen.routeName);
                      },
                      child: Text('Sign up',style: TextStyle(fontSize: 18,color: Theme.of(context).primaryColor),
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
