import 'package:fitapp/models/appcontroller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          SizedBox(height: 70, child: DrawerHeader(child: Text("Drawer"))),
          Divider(),
          ListTile(
            title: Text("Homepage"),
            leading: Icon(Icons.home),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
          Divider(),
          TextButton(onPressed: (){
            AppController.instance.changeTheme();
          }, child: Text("Change Theme"))
        ],
      ),
    );
  }
}
