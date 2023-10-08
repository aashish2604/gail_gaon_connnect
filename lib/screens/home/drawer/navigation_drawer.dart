import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sjs_app/services/auth.dart';
import 'package:sjs_app/services/database.dart';
import 'package:sjs_app/services/theme.dart';

class HomeNavigationDrawer extends StatelessWidget {
  const HomeNavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;

    return Drawer(
        backgroundColor: Colors.blue,
        width: _width * 0.7,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: FutureBuilder(
              future: DatabaseServices().getUserInfo(),
              builder:
                  (context, AsyncSnapshot<Map<String, dynamic>?> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.data != null) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 30.0,
                        ),
                        Text(
                          snapshot.data!['name'],
                          style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w300,
                              color: kCatsKillWhiteColor),
                        ),
                        Text(
                          snapshot.data!['contact_no'],
                          style: TextStyle(
                              color: kCatsKillWhiteColor.withOpacity(0.6)),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        const Divider(
                          color: Colors.white,
                          thickness: 1.2,
                        ),
                        InkWell(
                          onTap: () => AuthService().signOut(),
                          child: const ListTile(
                            title: Text(
                              'Sign Out',
                              style: TextStyle(color: kCatsKillWhiteColor),
                            ),
                            leading: Icon(Icons.power_settings_new_sharp,
                                color: kSadRed),
                          ),
                        )
                      ],
                    );
                  }
                  return InkWell(
                    onTap: () => AuthService().signOut(),
                    child: const ListTile(
                      title: Text(
                        'Sign Out',
                        style: TextStyle(color: kCatsKillWhiteColor),
                      ),
                      leading:
                          Icon(Icons.power_settings_new_sharp, color: kSadRed),
                    ),
                  );
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(
                    child: CupertinoActivityIndicator(
                      radius: 12.0,
                    ),
                  );
                }
                return Center(
                  child: InkWell(
                    onTap: () => AuthService().signOut(),
                    child: const ListTile(
                      title: Text(
                        'Sign Out',
                        style: TextStyle(color: kCatsKillWhiteColor),
                      ),
                      leading:
                          Icon(Icons.power_settings_new_sharp, color: kSadRed),
                    ),
                  ),
                );
              }),
        ));
  }
}
