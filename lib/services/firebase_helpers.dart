import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:librarian/models/book.dart';

class User {
  final String uid;

  User({this.uid});
}

class AuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user obj based on firebase user
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged
        //.map((FirebaseUser user) => _userFromFirebaseUser(user));
        .map(_userFromFirebaseUser);
  }

  // sign in anon
  Future signInAnon() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign in with email and password
  static Future signInWithEmailAndPassword(
      String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return user;
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

//
//  // register with email and password
//  Future registerWithEmailAndPassword(String email, String password) async {
//    try {
//      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
//      FirebaseUser user = result.user;
//      // create a new document for the user with the uid
//      await DatabaseService(uid: user.uid).updateUserData('0','new crew member', 100);
//      return _userFromFirebaseUser(user);
//    } catch (error) {
//      print(error.toString());
//      return null;
//    }
//  }

  // sign out
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

  Future<void> updateBookData(Book book) async {
//   Book book = Book.initialize();
    final singleBookCollection =  bookCollection.document(book.isbn_10);
//    print(singleBookCollection.exists);
  final checkExist=await singleBookCollection.get();
    if (! checkExist.exists ) {
      await singleBookCollection.setData({
        'title': book.title,
        'author': book.author,
        'smallThumbnail': book.smallThumbnail,
        'description': book.description,
        'ddc': [book.ddc2, book.ddc2],
        'description': book.description,
        'isbn_10': book.isbn_10,
        'isbn_13': book.isbn_13,
        'issued': book.issued,
        'lcc': [book.lcc1, book.lcc2],
        'pageCount': book.pageCount,
        'publisher': book.publisher,
        'totalCopy': book.totalCopy,
      });
    } else {
      await singleBookCollection.updateData({
        'totalCopy':FieldValue.increment(1),
      });
      print('update');
    }
  }

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

// brew list from snapshot
//  List<Book> _bookListFromSnapshot(QuerySnapshot snapshot) {
//    return snapshot.documents.map((doc) {
//      //print(doc.data);
//      return Book(
//        title: doc.data['name'] ?? '',
//        imgUrl: doc.data['strength'] ?? 0,
//        author: doc.data['sugars'] ?? '0',
//        description: doc.data[''] ?? '0',
//        isbn: doc.data[''] ?? '0',
//      );
//    }).toList();
//  }

// user data from snapshots
//  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
//    return UserData(
//        uid: uid,
//        name: snapshot.data['name'],
//        sugars: snapshot.data['sugars'],
//        strength: snapshot.data['strength']
//    );
//  }

// get brews stream
//  Stream<List<Book>> get brews {
//    return bookCollection.snapshots().map(_bookListFromSnapshot);
//  }

// get user doc stream
//  Stream<UserData> get userData {
//    return brewCollection.document(uid).snapshots()
//        .map(_userDataFromSnapshot);
//  }

}
