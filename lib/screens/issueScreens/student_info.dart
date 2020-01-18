import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:librarian/models/student.dart';
import 'package:librarian/elements/custom_cards.dart';
import 'package:librarian/screens/issueScreens/book_issue.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class StudentInfo extends StatefulWidget {
  static const id = "student_screen";

  @override
  _StudentInfoState createState() => _StudentInfoState();
}

class _StudentInfoState extends State<StudentInfo> {
  Student student = Student();
  bool toRemove = false;
  bool showSpinner = false;
  bool toCall = true;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
//    print(roll);
    final roll = ModalRoute.of(context).settings.arguments as String;
    print('in studentinfo roll $roll');
    student.roll = roll;
    if (mounted) if (toCall) {
      setState(() {
        showSpinner = true;
      });
      toCall = false;
      getStudentByRoll();
      setState(() {
        showSpinner = false;
      });
    }
  }

  //from firebase
  void getStudentByRoll() async {
    setState(() {
      showSpinner = true;
    });
    var db = Firestore.instance; //
    final studentCollection = db.collection('student');
    final students = await studentCollection.document(student.roll).get();
    print(students.data);
    final studentData = students.data;
//    try {
    if (mounted)
      setState(() {
        //always check for attributes
        student.name = studentData['Name'];
//        student.roll = studentData['roll'];//remove space later
        student.year = studentData['Year'];
        student.doa = studentData['date_of_admission'];
        student.dop = studentData['date_of_passing'];
        student.image = studentData['image'];
        student.branch = studentData['branch'];
        student.regNo = studentData['reg_No'];
        student.books = studentData['books'];
      });
    print(student.books);
//    } catch (e) {
//      print('in getStudentByRoll ${e.message}');
//    }
    setState(() {
      showSpinner = false;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Info'),
        backgroundColor: Colors.teal,
      ),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: SafeArea(
          child: Column(
            children: <Widget>[
              StudentInfoCard(
                imgUrl: student.image ??
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQubH2Bcr7A-rVMRm4l91FShKAadvCOVgtlM0SgRw6YOZgKM9yg5g&s',
                studentName: student.name ?? 'Dev',
                rollNo: student.roll,
                branch: student.branch ?? 'C.S.E',
                year: student.year ?? '3rd',
                regNo: student.regNo ?? '170274',
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 28.0),
                    child: Text('Issued Books'),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      IconButton(
                        color: Colors.teal,
                        icon: Icon(FontAwesomeIcons.plus),
                        onPressed: () {
                          Navigator.pushNamed(context, BookIssue.id,
                              arguments: [student.roll, 'add']);
                        },
                      ),
                      IconButton(
                          color: Colors.teal,
                          icon: Icon(FontAwesomeIcons.minus),
                          onPressed: () {
                            Navigator.pushNamed(context, BookIssue.id,
                                arguments: [student.roll, 'return']);
                          }),
                      IconButton(
                          color: Colors.teal,
                          icon: Icon(FontAwesomeIcons.sync),
                          onPressed: () {
                            Navigator.pushNamed(context, BookIssue.id,
                                arguments: [student.roll, 'reissue']);
                          }),
                    ],
                  )
                ],
              ),
              Divider(
                height: 20.0,
                color: Colors.black,
                endIndent: 20.0,
                indent: 20.0,
              ),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    if(student.books==null){
                      return Center(child: Text('No books issued'));
                    }
                    return GestureDetector(
                      onTap: () {
//                        getStudentByRoll();
                      },
                      child: IssuedBookCard(
                        bookTitle: student.books[index]['title'],
                        author: student.books[index]['author'],
                        isbn: student.books[index]['isbn'],
                        fine: student.books[index]['fine'],
                      imgUrl: student.books[index]['smallThumbnail'],
                        issueDate: student.books[index]['issueDate'],
                        returnDate: student.books[index]['returnDate'],
                      ),
                    );
                  },
                  itemCount: student.books != null ? student.books.length : 1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
