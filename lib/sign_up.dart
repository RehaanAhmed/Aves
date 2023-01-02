import 'package:avesproj/profile_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignUP extends StatefulWidget {
  const SignUP({Key? key}) : super(key: key);

  @override
  State<SignUP> createState() => _SignUPState();
}

class _SignUPState extends State<SignUP> {
  static Future<User?>loginUsingEmailPassword({required String email,required String password,required BuildContext context}) async{
    FirebaseAuth auth=FirebaseAuth.instance;
    User? user;
    try{
      UserCredential userCredential=await auth.signInWithEmailAndPassword(email: email, password: password);
      user=userCredential.user;
    }on FirebaseAuthException catch(e)
    {
      if(e.code =="user-not-found"){
        print("No User found for that email");
      }
    }
    return user;
  }
  @override
  Widget build(BuildContext context) {
    //final double w=MediaQuery.of(context).size.width;
    //final double h=MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,//w,
              height: MediaQuery.of(context).size.height*0.3,//h*0.3,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                          "images/aves_logo.jpg"
                      ),
                      fit: BoxFit.cover
                  )
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20,right: 20),
              width: MediaQuery.of(context).size.width,//w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "AVES",
                    style: TextStyle(
                        fontSize: 45,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  Text(
                    "Sign into your account",
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey[500]
                    ),
                  ),
                  SizedBox(height:40,),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 6,
                              spreadRadius: 5,
                              //offset: Offset(1, 1),
                              color: Colors.grey.withOpacity(0.5)
                          )
                        ]
                    ),
                    child: TextField(
                      autofocus: true,
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          hintText: "user Email",
                          prefixIcon: Icon(Icons.mail, color: Colors.black54),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(
                                  color: Colors.white,
                                  width: 0.5
                              )
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.white,
                                  width: 0.3
                              )
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30)
                          )
                      ),
                    ),
                  ),
                  SizedBox(height:20,),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 10,
                              spreadRadius: 7,
                              offset: Offset(1, 1),
                              color: Colors.grey.withOpacity(0.5)
                          )
                        ]
                    ),
                    child: TextField(
                      autofocus: true,
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                          hintText: "password",
                          prefixIcon: Icon(Icons.lock, color: Colors.black54),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(
                                  color: Colors.white,
                                  width: 1.0
                              )
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.white,
                                  width: 1.0
                              )
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30)
                          )
                      ),
                    ),
                  ),
                  SizedBox(height:18,),
                  Row(
                    children: [
                      Expanded(child: Container(),),
                      Text(
                        "Forgot Password",
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey[500]
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: 50,),
            Container(
              width: MediaQuery.of(context).size.width*0.5,//w*0.5,
              height: MediaQuery.of(context).size.height*0.08,//h*0.08,
              child: RawMaterialButton(
                fillColor: Colors.black38,
                elevation: 0.0,
                padding: EdgeInsets.symmetric(vertical: 16.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)),
                onPressed: () async{
                  User? user=await loginUsingEmailPassword(email: _emailController.text, password: _passwordController.text, context: context);
                  print(user);
                  if(user !=null){
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> ProfilePage()));
                    //let build new page named as profilePage

                  }
                  //let test the app
                  try {
                    UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                        email: _emailController.text,
                        password: _passwordController.text,
                    );
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'weak-password') {
                      print('The password provided is too weak.');
                    } else if (e.code == 'email-already-in-use') {
                      print('The account already exists for that email.');
                    }
                  } catch (e) {
                    print(e);
                  }
                },
                child: Text("SignUp",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    )),
              ),
            ),
            SizedBox(height:20,),
            RichText(text: TextSpan(
              text: " have an account?",
              style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: 20
              ),
              children: [
                TextSpan(
                    text: " Enter",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                    )
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }
  final _emailController=TextEditingController();
  final _passwordController=TextEditingController();
}