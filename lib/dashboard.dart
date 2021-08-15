import 'package:at_onboarding_tutorial/at_service.dart';
import 'package:at_onboarding_tutorial/my_app.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class DashBoard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Successfully onboarded to dashboard'),
            TextButton(
              onPressed: () {
                AtService.getInstance()
                    .deleteAtSign(atsign: GetStorage().read('username'))
                    .whenComplete(
                      () => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyApp(),
                        ),
                      ),
                    );
              },
              child: Text('Log out'),
            ),
          ],
        ),
      ),
    );
  }
}