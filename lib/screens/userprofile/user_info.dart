import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lbs/models/student.dart';


class StudentProfile extends StatefulWidget {
  static const id="user_info.dart";
  @override
  _StudentProfileState createState() => _StudentProfileState();
}

class _StudentProfileState extends State<StudentProfile> {
  Student student = Student();
  bool showSpinner=false;
  String roll='';

  String getRollFromEmail(String email){

    for(int i=0;i<email.length;i++){
      if(email[i]=='@'){
        break;
      }
      roll+=email[i];
    }
    return roll;
  }


  void getStudentByRoll() async {
    setState(() {
      showSpinner=true;
    });
    var db = Firestore.instance; //
    final studentCollection = db.collection('student');
    final students = await studentCollection.document(roll).get();
    print(students.data);
    final studentData = students.data;
//    try {
    if (mounted)
      setState(() {
        student.name = studentData['Name'];
        student.roll = studentData['Roll'];//remove space later
        student.year = studentData['Year'];
        student.branch = studentData['branch'];
        student.regNo = studentData['reg_No'];
      });
//    } catch (e) {
//      print('in getStudentByRoll ${e.message}');
//    }
    setState(() {
      showSpinner=false;
    });
  }
  @override
  Widget build(BuildContext context) {
    final email = ModalRoute.of(context).settings.arguments as String;

    return StudentInfo(studentName: student.name,rollNo: student.roll,branch: student.branch,);
  }
}


class StudentInfo extends StatelessWidget {
  //final imgURl;
  final studentName;
  //final imgUrl;
  final rollNo;
  final branch;
 // final mobileNumber;
  //final dob;
  //final email;

  StudentInfo(
      {
        this.branch,
        //this.dob,
        //this.mobileNumber,
        this.rollNo,
        this.studentName,
        //this.email
   });

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Container(
        //height: 100,
//      width: 200,
        width: double.infinity,
        child: Row(
          children: <Widget>[
            Flexible(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22.0),
                child: Column(
//              child: Image(
//                image: NetworkImage(imgURL),
//              ),

                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(24.0),
                      child: Card(
                        elevation: 5.0,
                        child: Image(
                          image: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQubH2Bcr7A-rVMRm4l91FShKAadvCOVgtlM0SgRw6YOZgKM9yg5g&s'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Flexible(
                flex: 6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Name : $studentName',
                      textAlign: TextAlign.end,
                      style: TextStyle(
                          fontFamily: ('Nunito'),
                          fontWeight: FontWeight.w700,
                          fontSize: 12.0),
                    ),
                    Text(
                      'Roll : $rollNo',
                      textAlign: TextAlign.end,
                      style: TextStyle(
                          fontFamily: ('Nunito'),
                          fontWeight: FontWeight.w700,
                          fontSize: 12.0),
                    ),
                    Text(
                      'Branch : $branch',
                      textAlign: TextAlign.end,
                      style: TextStyle(
                          fontFamily: ('Nunito'),
                          fontWeight: FontWeight.w700,
                          fontSize: 12.0),
                    ),
//                    Text(
//                      'D.O.B : $dob',
//                      textAlign: TextAlign.end,
//                      style: TextStyle(
//                          fontFamily: ('Nunito'),
//                          fontWeight: FontWeight.w700,
//                          fontSize: 12.0),
//                    ),
//                    Text(
//                      'Mobile Number : $mobileNumber',
//                      textAlign: TextAlign.end,
//                      style: TextStyle(
//                          fontFamily: ('Nunito'),
//                          fontWeight: FontWeight.w700,
//                          fontSize: 12.0),
//                    ),
//                    Text(
//                      'Email : $email',
//                      textAlign: TextAlign.end,
//                      style: TextStyle(
//                          fontFamily: ('Nunito'),
//                          fontWeight: FontWeight.w700,
//                          fontSize: 12.0),
//                    ),
                  ],
                )),
          ],
        ),
      ),
      Divider(
        color: Colors.grey.withOpacity(0.5),
        height: 20.0,
        indent: 20.0,
        endIndent: 20.0,
      )
    ]);
  }
}
