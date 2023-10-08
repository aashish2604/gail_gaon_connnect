import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sjs_app/screens/home/drawer/navigation_drawer.dart';
import 'package:sjs_app/screens/home/tabs/pooling/pooling_screen.dart';
import 'package:sjs_app/screens/home/tabs/resale/resale_screen.dart';
import 'package:sjs_app/services/theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final pages = [const ResaleHome(), const PoolingHome()];
  final titles = ["Resale Items", "All Pools"];
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          toolbarHeight: 80,
          title: Text(
            titles[index],
            style: headerTextStyle,
          ),
        ),
        extendBodyBehindAppBar: true,
        drawer: const HomeNavigationDrawer(),
        body: pages[index],
        bottomNavigationBar: ConvexAppBar(
          height: 63,
          items: const [
            TabItem(
                icon: Icon(CupertinoIcons.money_dollar_circle),
                title: "Resale",
                isIconBlend: true),
            TabItem(
                icon: Icon(CupertinoIcons.square_stack_3d_up),
                title: "Pooling",
                isIconBlend: true)
          ],
          onTap: (int i) {
            setState(() {
              index = i;
            });
          },
        ),
      ),
    );
  }
}
