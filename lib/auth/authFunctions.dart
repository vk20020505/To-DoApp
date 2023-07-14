import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

 showdialog(context, String title,String reason){
   showDialog(
    context:context,
    builder: (BuildContext context){
      return AlertDialog(
        title: Text(title,style: TextStyle(color: Theme.of(context).primaryColor),),
        content: Text(reason,style: TextStyle(color: Theme.of(context).primaryColor))
      );
    }
  );
 }

signUp(String email, String password,context )async{
    try {
  await FirebaseAuth.instance.createUserWithEmailAndPassword(
    email: email,
    password: password,
  );
  
} on FirebaseAuthException catch (e) {
  if (e.code == 'weak-password') {
    
    showdialog(context,'SignUp Fail !!','The password provided is too weak.');
  } else if (e.code == 'email-already-in-use') {
    showdialog(context,'SignUp Fail !!','The account already exists for that email.');
  }
} catch (e) {
  // print(e);
}
}

logIn(String email, String password ,context)async{
    try {
await FirebaseAuth.instance.signInWithEmailAndPassword(
    email: email,
    password: password
  );
} on FirebaseAuthException catch (e) {
  if (e.code == 'user-not-found') {
    showdialog(context,'Login Fail !!','No user found for that email.');
  } else if (e.code == 'wrong-password') {
    showdialog(context,'Login Fail !!','Wrong password provided for that user.');
  }
}
}
