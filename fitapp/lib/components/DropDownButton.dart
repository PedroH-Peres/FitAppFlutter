import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';

final days = List.generate(7, (index){
      DateTime date = DateTime(2022, 12, 25).add(Duration(days: index));
      return DateFormat(DateFormat.WEEKDAY).format(date);
  });



class DropDownButtonWidget extends StatefulWidget {
  const DropDownButtonWidget({super.key});

    static String get ddvalue{
    return _DropDownButtonWidgetState.dropDownValue;
  }

  @override
  State<DropDownButtonWidget> createState() => _DropDownButtonWidgetState();
}

class _DropDownButtonWidgetState extends State<DropDownButtonWidget> {
  
  static String dropDownValue = days.first;



  @override
  Widget build(BuildContext context) {
    return DropdownButton<String> (
      value: dropDownValue,
      onChanged: ((value) {
        setState(() {
          dropDownValue = value!;
        });
      }),
      items: days.map<DropdownMenuItem<String>>((e) {
        return DropdownMenuItem(
          value: e,
          child: Text(e.toUpperCase()),
        );
      } ).toList(),
    );
  }
}
