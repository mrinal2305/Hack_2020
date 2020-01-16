
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:librarian/models/book.dart';
import 'package:librarian/models/librarian.dart';
import 'package:librarian/models/student.dart';
import 'package:librarian/models/nlp.dart';

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
        u.isLibrarian=true;
        return u;
      } else {
        print('inelse');
        u.isLibrarian=false;
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

  //for book collection
  Future<void> updateBookData(Book book) async {
//   Book book = Book.initialize();
    final singleBookCollection = bookCollection.document(book.isbn_10);
//    print(singleBookCollection.exists);
    final checkExist = await singleBookCollection.get();
    if (!checkExist.exists) {
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
        'totalCopy': FieldValue.increment(1),
      });
      print('update');
    }
  }

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

  //for student collection
  Future<void> updateStudentData(Student student) async {
//   Book book = Book.initialize();
    final singleStudentCollection = studentCollection.document(student.roll);
//    print(singleBookCollection.exists);
    final checkExist = await singleStudentCollection.get();
    if (!checkExist.exists) {
      await singleStudentCollection.setData({
        'Name': student.name,
        'Roll': student.roll,
        'Year': student.year,
        'Branch': student.branch,
        'reg_No': student.bookIssued,
      });
    } else {
//      await singleStudentCollection.updateData({
//        'totalCopy':FieldValue.increment(1),
//      });
      print('update');
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
  void studentStream() async {
    final studentSnapshots = studentCollection.snapshots();
    await for (var snapshot in studentSnapshots) {
      for (var books in snapshot.documents) {
        print(books.data);
      }
    }
  }

  //for nlp collection
  Future<void> updateNlpData(Nlp nlp) async {
//   Book book = Book.initialize();
    final singleNlpCollection = nlpCollection.document(nlp.isbn);
//    print(singleBookCollection.exists);
    final checkExist = await singleNlpCollection.get();
    if (!checkExist.exists) {
      await singleNlpCollection
          .setData({'concept': nlp.concept, 'sentiment': nlp.concept});
    } else {
//      await singleStudentCollection.updateData({
//        'totalCopy':FieldValue.increment(1),
//      });
      print('update');
    }
  }

  //just for checking not used for anywhere
  void getNlpData() async {
    final nlps = await nlpCollection.getDocuments();
    for (var nlp in nlps.documents) {
      print(nlp.data);
    }
  }

  //listening for database changes
  void nlpStream() async {
    final nlpSnapShots = nlpCollection.snapshots();
    await for (var snapshot in nlpSnapShots) {
      for (var nlps in snapshot.documents) {
        print(nlps.data);
      }
    }
  }

  //for librarian collection
  Future<void> updateLibrarianData(Librarian librarian) async {
//   Book book = Book.initialize();
    final singleLibrarianCollection =
        librarianCollection.document(librarian.id);
//    print(singleBookCollection.exists);
    final checkExist = await singleLibrarianCollection.get();
    if (!checkExist.exists) {
      await singleLibrarianCollection.setData({
        'Name': librarian.name,
        'Post': librarian.post,
        'isLibrarian': librarian.isLibrarian
      });
    } else {
//      await singleStudentCollection.updateData({
//        'totalCopy':FieldValue.increment(1),
//      });
      print('update');
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
