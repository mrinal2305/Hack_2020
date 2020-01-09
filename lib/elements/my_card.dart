import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class MyCard extends StatelessWidget {
  final String title;
  final Function onTap;
  final String imgPath;

  MyCard(this.title, this.onTap,this.imgPath);

  @override
  Widget build(BuildContext context) {
    final data=MediaQuery.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: Color(0xddffffff),
        elevation: 8,
//        borderOnForeground: false,
        child: Container(
          width:data.size.width-50.0,
          height: data.size.height/6,
          margin: EdgeInsets.only(left: 8, top: 8, bottom: 8),
          padding: EdgeInsets.all(12),
          child: Row(
//          mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Image.asset(imgPath,scale: 10.0,),
              SizedBox(
                width: 50,
              ),
              Text(title,style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w400
              ),),
            ],
          ),
//          height: 120.00,
//          width: 300,
        ),
      ),
    );
  }
}
