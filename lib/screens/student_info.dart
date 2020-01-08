import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:librarian/constants.dart';
import 'package:librarian/elements/round_icon_button.dart';


class StudentInfo extends StatefulWidget {
  static const id = 'student_info';

  @override
  _StudentInfoState createState() => _StudentInfoState();
}

class _StudentInfoState extends State<StudentInfo> {
  final db = FirebaseDatabase.instance;
  String field = '';
  Student student;
  DatabaseReference studentRef;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    student=Student(regNo:"",cl:"",name:"",fine:"",roll:"");
//    final FirebaseDatabase database=FirebaseDatabase(app: app);
    studentRef=FirebaseDatabase.instance.reference().child('student');

  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Student'),
        ),
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text('Student Info'),
//            CustomWidget(),
            TextField(
              decoration: kTextFieldDecoration,
              onChanged: (value) {
                field = value;
              },
            ),
            SizedBox(
              height: 10,
            ),
            RoundIconButton(
              title: 'Issue',
              onPress: () {
                field += ' ';
                String temp = '';
                List<String> strList = [];
                for (int i = 0; i < field.length; i++) {
                  if (field[i] == ' ') {
                    strList.add(temp);
                    temp = '';
                    continue;
                  }
                  temp += field[i];
                }
                for (String x in strList) {
                  print(x);
                }
                student.regNo=strList[0];
                student.cl=strList[1];
                student.fine=strList[2];
                student.name=strList[3];
                student.roll=strList[4];
                studentRef.update(student.toJson());
              },
            )
          ],
        ),
      ),
    );
  }
}

class CustomWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: 150,
        height: 100,
        child: Text('hello'),
      ),
    );
  }
}


//class for holding firebase db table
class Student {
  String regNo;
  String cl; //class
  String fine;
  String name;
  String roll;

  Student({this.regNo, this.cl, this.fine, this.name, this.roll});

//  Student.fromSnapShot(DataSnapshot snapshot) {
////    regNo = snapshot.value;
//    cl = snapshot.value['class'];
//    fine = snapshot.value['fine'];
//    name = snapshot.value['name'];
//    roll = snapshot.value['roll'];
//  }

  toJson() {
    return {
     regNo:{
       'class': cl,
       'fine': fine,
       'name': name,
       'roll': roll,
     }
    };
  }
}
