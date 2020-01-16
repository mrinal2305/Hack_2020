import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:librarian/models/student.dart';
import 'package:librarian/elements/custom_card.dart';
import 'package:librarian/screens/issueScreens/book_issue.dart';

class StudentInfo extends StatefulWidget {
  static const id = "student_screen";

  @override
  _StudentInfoState createState() => _StudentInfoState();
}

class _StudentInfoState extends State<StudentInfo> {
  Student student = Student();

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    final roll = ModalRoute.of(context).settings.arguments as String;
    student.roll = roll;
    print(roll);
    if(mounted)
    getStudentByRoll();
  }

  void getStudentByRoll() async {
    var db = Firestore.instance; //
    final studentCollection = db.collection('student');
    final students = await studentCollection.document(student.roll).get();
    print(students.data);
    final studentData = students.data;
//    try {
    if (mounted)
      setState(() {
        student.name = studentData['Name'];
        student.roll = studentData['Roll'];
        student.year = studentData['Year'];
        student.branch = studentData['branch'];
        student.regNo = studentData['reg_No'];
        student.books = studentData['books'];
      });
    print(student.books);
//    } catch (e) {
//      print('in getStudentByRoll ${e.message}');
//    }
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
      body: SafeArea(
        child: Column(
          children: <Widget>[
            StudentInfoCard(
              imgUrl:
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQubH2Bcr7A-rVMRm4l91FShKAadvCOVgtlM0SgRw6YOZgKM9yg5g&s',
              studentName: student.name ?? 'Dev',
              rollNo: student.roll ?? '1706022',
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
                        Navigator.pushNamed(context, BookIssue.id);
                      },
                    ),
                    IconButton(
                      color: Colors.teal,
                      icon: Icon(FontAwesomeIcons.minus),
                      onPressed: () {},
                    )
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
                  return GestureDetector(
                    onTap: () {
//                      Navigator.pushNamed(context, BookInput.id,arguments: booksInfo[index]??'1585424331');
                    },
                    child: IssuedBookCard(
                      bookTitle: student.books[index]['title'],
                      author: student.books[index]['author'],
                      isbn: student.books[index]['isbn'],
                      fine: student.books[index]['fine'],
                      issueDate: student.books[index]['issuedDate'],
                      returnDate: student.books[index]['returnDate'],
                    ),
                  );
                },
                itemCount: student.books.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
