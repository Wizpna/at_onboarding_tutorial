import 'package:at_onboarding_tutorial/dashboard.dart';
import 'package:at_onboarding_tutorial/at_service.dart';
import 'package:flutter/material.dart';
import 'package:at_onboarding_flutter/at_onboarding_flutter.dart';
import 'package:at_utils/at_logger.dart';
import 'package:get_storage/get_storage.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var atClientPrefernce;
  var _logger = AtSignLogger('Plugin example app');

  @override
  void initState() {
    AtService.getInstance()
        .getAtClientPreference()
        .then((value) => atClientPrefernce = value);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Builder(
          builder: (context) => Center(
            child: TextButton(
              onPressed: () async {
                Onboarding(
                  context: context,

                  //The atClientPreference is required to continue with the onboarding.
                  atClientPreference: atClientPrefernce,

                  //Default the plugin connects to [root.atsign.org] to perform onboarding.
                  domain: 'root.atsign.org',

                  //This Function returns atClientServiceMap on successful onboarding along with the onboarded @sign.
                  onboard: (value, atsign) {
                    GetStorage().write('username', atsign);
                    AtService.getInstance().atClientServiceMap = value;
                    print('value ${value[atsign]}');
                    _logger.finer('Successfully onboarded $atsign');
                  },

                  //This Function returns error when failed in onboarding the existing or given atsign user.
                  onError: (error) {
                    _logger.severe('Onboarding throws $error error');
                  },

                  //after successful onboarding users will gets redirected to this screen if it is not null.
                  nextScreen: DashBoard(),

                  // API authentication key for getting free atsigns
                  appAPIKey: '400b-806u-bzez-z42z-6a3p',
                );
              },
              child: Text(
                'Login with @sign',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}