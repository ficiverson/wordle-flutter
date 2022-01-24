import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:games_services/games_services.dart';
import 'package:loading/indicator/ball_grid_pulse_indicator.dart';
import 'package:loading/indicator/line_scale_party_indicator.dart';
import 'package:loading/loading.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wordleconvivientes/tutorial.dart';

import 'game.dart';

class ShowLoadingPage extends StatefulWidget {
  const ShowLoadingPage({Key? key}) : super(key: key);
  @override
  State<ShowLoadingPage> createState() => ShowLoading();
}

class ShowLoading extends State<ShowLoadingPage> {

  bool _accountSetup = true;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  bool? _tutorial;
  BallGridPulseIndicator animation = BallGridPulseIndicator();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Loading(indicator: animation, size: 100.0, color: Color(0xFF202020)),
        ));
  }

  @override
  void initState() {
    SchedulerBinding.instance?.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 3),() async {
        _accountSetup = await GamesServices.isSignedIn;
        final SharedPreferences prefs = await _prefs;
        _tutorial = prefs.getBool("tutorial_shown");
        if (!_accountSetup && _tutorial != true) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => TutorialPage(onlyAccount: false)),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => TutorialPage(onlyAccount: true)),
          );
        }
      });

    });
    super.initState();
  }
}