import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';

class DateBar extends StatelessWidget {
  const DateBar({super.key});

  @override
  Widget build(BuildContext context) {
    final days = List.generate(7, (index){
      DateTime date = DateTime(2022, 12, 25).add(Duration(days: index));
      return DateFormat(DateFormat.WEEKDAY).format(date);
    });
    print(days);

    verifyDay(int index){
      if(days[index] == DateFormat(DateFormat.WEEKDAY).format(DateTime.now())){
        return Center(child: Text("${days[index].toUpperCase()}"),);
      }else{
        return Center(child: Text("${days[index].substring(0, 3).toUpperCase()}"),);
      }
    }

    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for(int i = 0; i < 7; i++)
          Container(
            margin: EdgeInsets.all(3),
            height: 26,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(width: 2),
              boxShadow: [BoxShadow(
                          color: Colors.black54,
                          blurRadius: 15.0,
                          offset: Offset(0.0, 0.75)
                      )]
            ),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            child: verifyDay(i),
          )

        
      ],
    );
    
  }
}
/*Container(
      margin: EdgeInsets.symmetric(horizontal: 28, vertical: 10),
      padding: EdgeInsets.only(bottom: 7),
      decoration: BoxDecoration(border: Border.all(width: sqrt1_2)),
      height: 50,
      child: ListView.separated(
        separatorBuilder: (ctx, index) {
          return SizedBox(width: 2,);
        },
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 7),
            margin: EdgeInsets.symmetric(horizontal: 4),
            height: 30,
            decoration: BoxDecoration(border: Border.all(width: 3)),
            child: verifyDay(index)
          );
        },
        itemCount: days.length,
        scrollDirection: Axis.horizontal,
      ),
    );*/

