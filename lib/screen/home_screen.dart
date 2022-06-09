import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../screen/pages/add_video_page.dart';
import '../screen/pages/home_page.dart';
import '../screen/pages/search_page.dart';
import '../screen/pages/inbox_page.dart';
import '../screen/pages/me_page.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _pageController = 0;

  List<Widget> _pages = [
    HomePage(),
    SearchPage(),
    InboxPage(),
    MePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (BuildContext context, SizingInformation sizingInformation) {
        return Scaffold(
            bottomNavigationBar: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 0,
              ),
              alignment: Alignment.center,
              color: Color(0xff012c53),
              height: sizingInformation.localWidgetSize.height * 0.08,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      setState(() {
                        _pageController = 0;
                      });
                    },
                    child: _navBarItem(
                      title: "Home",
                      icon: Icons.home,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        _pageController = 1;
                      });
                    },
                    child: _navBarItem(
                      title: "Search",
                      icon: Icons.search,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => AddVideoPage()));
                    },
                    child: Container(
                      width: 50,
                      height: sizingInformation.localWidgetSize.height * 0.07,
                      child: Stack(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              width: 20,
                              height: sizingInformation.localWidgetSize.height *
                                  0.04,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(30),
                                ),
                                color: Color(0xff9d0b0e),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              width: 20,
                              height: sizingInformation.localWidgetSize.height *
                                  0.04,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(30),
                                ),
                                color: Colors.orange,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              width: 38,
                              height: sizingInformation.localWidgetSize.height *
                                  0.04,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                                color: Colors.white,
                              ),
                              child: Icon(
                                Icons.add,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        _pageController = 2;
                      });
                    },
                    child: _navBarItem(
                      title: "Inbox",
                      icon: Icons.message,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        _pageController = 3;
                      });
                    },
                    child: _navBarItem(
                      title: "Me",
                      icon: Icons.person,
                    ),
                  ),
                ],
              ),
            ),
            body: _pages[_pageController]);
      },
    );
  }

  Widget _navBarItem({
    String title,
    IconData icon,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          icon,
          color: Colors.white,
        ),
        Text(
          title,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
