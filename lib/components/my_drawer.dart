import 'package:flutter/material.dart';
import 'package:solocaht/pages/SettingPage.dart';
import '../services/auth/auth_service.dart';


class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});
  void logout(){
    //get auth service
    final _auth =AuthService();
    _auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child:
      Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        // logo
        Column(
          children: [
            DrawerHeader(
                child: Center(
                  child: Icon(
                    Icons.message,
                    color: Theme.of(context).colorScheme.primary,
                    size: 40,
                  ),
                )),
// home list tile
            Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: ListTile(
                title: Text("H O M E"),
                leading: Icon(Icons.home),
                onTap: () {
                  // pop the drawer
                  Navigator.pop(context);
                },
              ),
            ),
// setting list tile
            Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: ListTile(
                title: Text("S E T T I N G S "),
                leading: Icon(Icons.settings),
                onTap: () {

                  Navigator.pop(context);
                  // go to the setting page
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SettingsPage()));
                },
              ),
            ),
          ],
        ),
// logout list tile

        Padding(
          padding: const EdgeInsets.only(left: 25.0, bottom: 25),
          child: ListTile(
            title: Text("L O G O U T"),
            leading: Icon(Icons.logout),
            onTap: logout,
          ),
        ),
      ]),
    );
  }
}