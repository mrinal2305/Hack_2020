import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

class SearchService {
  searchByTitle(String searchField) {
    print('in searchbytitle $searchField');
    return Firestore.instance
        .collection('book')
        .where('titleKey',
        isEqualTo: searchField.substring(0, 1).toLowerCase())
        .getDocuments();
  }
}

class User {
//  String uid;
  bool isLibrarian;
  bool  isUserAvailable;
  String errorType;
  FirebaseUser user;

  User({this.isUserAvailable,this.isLibrarian, this.errorType});
}

class AuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user obj based on firebase user
//  User _userFromFirebaseUser(FirebaseUser user) {
//    return user != null ? User(uid: user.uid) : null;
//  }

  // auth change user stream
//  Stream<User> get user {
//    return _auth.onAuthStateChanged
//        //.map((FirebaseUser user) => _userFromFirebaseUser(user));
//        .map(_userFromFirebaseUser);
//  }

  // sign in anon
//  Future signInAnon() async {
//    try {
//      AuthResult result = await _auth.signInAnonymously();
//      FirebaseUser user = result.user;
//      return _userFromFirebaseUser(user);
//    } catch (e) {
//      print(e.toString());
//      return null;
//    }
//  }

  // sign in with email and password
  Future<User> validate(String email,String password)async{
    User u=await signInWithEmailAndPassword(email, password);
    try{
      if(u.user!=null) {
        final CollectionReference checkCollection =
        Firestore.instance.collection('check');
        final checkExist = await checkCollection.document(u.user.uid).get();
        print(u.user.email);
        print(u.user.uid);
        print(checkExist.exists);
        if (checkExist.exists) {
          print('inif');
          u.isLibrarian=true;//he is librarian
          return u;
        } else {
          print('inelse');
          u.isLibrarian=false;//not librarian but valid user
          return u;
        }
      } else{
        print('null');
        u.isUserAvailable=false;
        u.isLibrarian=false;
        return u;
      }}catch(e){
      print('invalidate try');
      print(e);
    }
  }
  static Future signInWithEmailAndPassword(
      String email, String password) async {
    User u=User();//initialize variables wasted 3 hrs throw called on null
    try {
      //gives status of sign in whether success or error for more details ctrl+click
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      print(result);
      print('above result');
      FirebaseUser user = result.user;
      print(user.email);
      u.user=user;
      u.isUserAvailable=true;
      u.errorType=null;
      return u;
    } on PlatformException catch (error) {
      print('in catch of sign in');
      print(error.message);
      print(u);
      u=User();//very important wasted 2 hrs
      u.user=null;
      u.isUserAvailable=false;
      u.errorType=error.message;
      print('outro of sign in');
      return u;
    }
  }


  static Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
}

class DatabaseService {
  final String uid;

  DatabaseService({this.uid});

  // collection reference
  final CollectionReference nlpCollection =
  Firestore.instance.collection('NLP');
  final CollectionReference bookCollection =
  Firestore.instance.collection('book');
  final CollectionReference librarianCollection =
  Firestore.instance.collection('librarian');
  final CollectionReference studentCollection =
  Firestore.instance.collection('student');


  //just for checking not used anywhere
  void getBookData() async {
    final books = await bookCollection.getDocuments();
    for (var book in books.documents) {
      print(book.data);
    }
  }

  void booksStream() async {
    final bookSnapshots = bookCollection.snapshots();
    await for (var snapshot in bookSnapshots) {
      for (var books in snapshot.documents) {
        print(books.data);
      }
    }
  }

  //just for checking not used anywhere
  void getStudentData() async {
    final students = await studentCollection.getDocuments();
    for (var student in students.documents) {
      print(student.data);
    }
  }

  //listening for database changes
  Stream studentStream(String roll)  {
    final studentBooks = studentCollection.document(roll).snapshots();
//    await for (var snapshot in studentSnapshots) {
//      for (var books in snapshot.documents) {
//        print(books.data);
//      }
    return studentBooks;
  }

  //just for checking not used for anywhere
  void getNlpData() async {
    final nlps = await nlpCollection.getDocuments();
    for (var nlp in nlps.documents) {
      print(nlp.data);
    }
  }

  //just for checking not used for anywhere
  void getLibrarianData() async {
    final librarians = await librarianCollection.getDocuments();
    for (var librarian in librarians.documents) {
      print(librarian.data);
    }
  }

  //listening for database changes
  void librarianStream() async {
    final librarianSnapShots = librarianCollection.snapshots();
    await for (var snapshot in librarianSnapShots) {
      for (var librarians in snapshot.documents) {
        print(librarians.data);
      }
    }
  }
}

