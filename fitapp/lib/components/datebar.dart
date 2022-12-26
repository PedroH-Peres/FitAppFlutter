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
      return DateFormat(DateFormat.ABBR_WEEKDAY).format(date);
    });
    print(days);

    verifyDay(int index){
      if(days[index] == DateFormat(DateFormat.ABBR_WEEKDAY).format(DateTime.now())){
        return Center(child: Text("${days[index]}"),);
      }else{
        return Center(child: Text("${days[index][0]}"),);
      }
    }

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      height: 50,
      child: ListView.builder(
        itemBuilder: (context, index) {
          return Container(
            height: 30,
            decoration: BoxDecoration(border: Border.all(width: 3)),
            child: verifyDay(index)
          );
        },
        itemCount: days.length,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}


