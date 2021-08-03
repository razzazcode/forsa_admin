// @dart=2.9
import 'package:forsa_admin/DialogBox/errorDialog.dart';
import 'package:forsa_admin/DialogBox/loadingDialog.dart';
import 'package:forsa_admin/Login/backgroundPainter.dart';
import 'package:forsa_admin/MainScreens/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';








class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}



class _LoginScreenState extends State<LoginScreen>
{
  String email="";
  String password="";

  returnEmailField(IconData icon, bool isObscure)
  {
    return TextField(
      onChanged: (value)
      {
        email = value;
      },
      obscureText: isObscure,
      style: TextStyle(fontSize: 15.0, color: Colors.white),
      decoration: InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.green),
        ),
        hintText: "Email",
        hintStyle: TextStyle(color: Colors.white),
        icon: Icon(
          icon,
          color: Colors.green,
        ),
      ),
    );
  }

  returnPasswordField(IconData icon, bool isObscure)
  {
    return TextField(
      onChanged: (value)
      {
        password = value;
      },
      obscureText: isObscure,
      style: TextStyle(fontSize: 15.0, color: Colors.white),
      decoration: InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.green),
        ),
        hintText: "Password",
        hintStyle: TextStyle(color: Colors.white),
        icon: Icon(
          icon,
          color: Colors.green,
        ),
      ),
    );
  }

  returnLoginButton()
  {
    return ElevatedButton(
      onPressed: ()
      {
        if(email != "" && password != "")
        {
          //login
          loginAdmin();
        }
      },
      child: Text(
        "Login",
        style: TextStyle(
          color: Colors.white,
          letterSpacing: 2.0,
          fontSize: 16.0,
        ),
      ),
    );
  }

  loginAdmin() async
  {
    showDialog(
        context: context,
        builder: (context)
        {
          return LoadingAlertDialog(
            message: "please wait...",
          );
        }
    );

    User currentUser;
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    ).then((aAuth)
    {
      currentUser = aAuth.user;
    }).catchError((error)
    {
      Navigator.pop(context);

      showDialog(
          context: context,
          builder: (context)
          {
            return ErrorAlertDialog(
              message: "Error Occured: " + error.toString(),
            );
          }
      );
    });

    if(currentUser != null)
    {
      //homepage
      Route newRoute = MaterialPageRoute(builder: (context) => HomeScreen());
      Navigator.pushReplacement(context, newRoute);
    }
    else
    {
      //loginPage
      Route newRoute = MaterialPageRoute(builder: (context) => LoginScreen());
      Navigator.pushReplacement(context, newRoute);
    }
  }


  @override
  Widget build(BuildContext context)
  {
    double _screenWidth = MediaQuery.of(context).size.width,
        _screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.black87,
      body: Stack(
        alignment: Alignment.lerp(
          Alignment.lerp(Alignment.centerRight, Alignment.center, 0.3),
          Alignment.topCenter,
          0.15,
        ),
        children: [
          CustomPaint(
            painter: BackgroundPainter(),
            child: Container(height: _screenHeight,),
          ),
          Center(
            child: Container(
              width: _screenWidth * .5,
              child: Column(
                children: [
                  Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 40.0),
                      child: Image.asset("images/admin.png", width: 300, height: 300,),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 50.0),
                    child: returnEmailField(Icons.person, false),
                  ),
                  SizedBox(height: 20.0,),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 50.0),
                    child: returnPasswordField(Icons.person, true),
                  ),
                  SizedBox(height: 40.0,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 50.0),
                        child: returnLoginButton(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}




  /*

  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Sample App'),
        ),
        body: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'TutorialKart',
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w500,
                          fontSize: 30),
                    )),
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Sign in',
                      style: TextStyle(fontSize: 20),
                    )),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'User Name',
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextField(
                    obscureText: true,
                    controller: passwordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                  ),
                ),
                FlatButton(
                  onPressed: (){
                    //forgot password screen
                  },
                  textColor: Colors.blue,
                  child: Text('Forgot Password'),
                ),
                Container(
                    height: 50,
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: Colors.blue,
                      child: Text('Login'),
                      onPressed: () {
                        print(nameController.text);
                        print(passwordController.text);
                      },
                    )),
                Container(
                    child: Row(
                      children: <Widget>[
                        Text('Does not have account?'),
                        FlatButton(
                          textColor: Colors.blue,
                          child: Text(
                            'Sign in',
                            style: TextStyle(fontSize: 20),
                          ),
                          onPressed: () {
                            //signup screen
                          },
                        )
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    ))
              ],
            )));
  }
}
*/