import 'package:fitapp/models/appcontroller.dart';
import 'package:fitapp/utils/routes.dart';
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
          SizedBox(child: DrawerHeader(child: Text("Fit App")), height: 90,),
          ListTile(
            title: Text("Homepage"),
            leading: Icon(Icons.home),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(UtilRoutes.home_page);
            },
          ),
          Divider(),
          ListTile(
            title: Text("Overview"),
            leading: Icon(Icons.list),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(UtilRoutes.overview_page);
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
