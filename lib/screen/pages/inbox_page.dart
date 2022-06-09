import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class InboxPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (
        BuildContext buildcontext,
        SizingInformation sizingInformation,
      ) {
        return Scaffold(
          appBar: AppBar(title: Text('All Activity')),
          body: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.message,
                  size: 80,
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  'Messages and notification will appear here',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(
                    horizontal: 50,
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 80,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(color: Colors.red),
                  child: Text(
                    'Sign Up',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
