import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/scheduler.dart';
import 'package:games_services/games_services.dart';
import 'package:onboarding/onboarding.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:virtual_keyboard_multi_language/virtual_keyboard_multi_language.dart';
import 'package:flutter/material.dart';
import 'package:wordleconvivientes/rae.dart';
import 'package:wordleconvivientes/settings.dart';
import 'custom-layout.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String text = "";
  String solution = "planta".toUpperCase();
  int currentWord = 0;
  bool loadingGame = true;
  bool canPlay = true;
  bool endGame = false;
  List<List<int>> colors = [];
  List<List<String>> characters = [];

  final CustomLayoutKeys _customLayoutKeys = CustomLayoutKeys();
  late MediaQueryData queryData;
  final TextEditingController _controllerText = TextEditingController();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  void initState() {
    _initTheGame();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    queryData = MediaQuery.of(context);
    return loadingGame
        ? Container()
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Color(0xFF198BCA),
              actions: [
                IconButton(
                  icon: Icon(
                    Icons.leaderboard_outlined,
                    color: Colors.white,
                  ),
                  onPressed: () async {
                    _checkSignInStatus();
                    await GamesServices.showLeaderboards(
                        androidLeaderboardID: "CgkIioGnq48DEAIQAQ",
                        iOSLeaderboardID: 'coruna_leaderboard_id');
                  },
                ),
                IconButton(
                  icon: Icon(
                    Platform.isIOS ? Icons.ios_share : Icons.share_outlined,
                    color: Colors.white,
                  ),
                  onPressed: () async {
                    Share.share('¿Conoces el reto de Xerión? https://ficiverson.github.io/xerion-web/');
                  },
                ),
                IconButton(
                  icon: Icon(Icons.settings_applications_outlined,
                    color: Colors.white,
                  ),
                  onPressed: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SettingsPage()),
                    );
                  },
                )
              ],
              title: Text(widget.title,
                  style: TextStyle(
                      fontFamily: 'Calestra',
                      fontSize: 30,
                      fontWeight: FontWeight.w700)),
            ),
            body: _getBody());
  }

  //widget mthods

  Widget _getBody() {
    return canPlay
        ? Container(
            // height: queryData.size.height,
            color: Colors.white,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  _getTopContainers(),
                  _getKeyboard(),
                  //SizedBox(height: 40),
                  GestureDetector(
                      onTap: () async {
                        final SharedPreferences prefs = await _prefs;
                        int currentScore =  prefs.getInt("current_score") != null? prefs.getInt("current_score")!: 0;
                        prefs.setInt("current_score", currentScore - 10);
                        _showAlert(
                            context,
                            DialogType.QUESTION,
                            "Xerión te ayuda:",
                            raeXerion[_dayOfTheyear() % raeXerion.length]);
                      }, // Image tapped
                      child: Container(
                          height: 40, child: Image.asset('xerion_icon.png')))
                ],
              ),
            ),
          )
        : Center(
            child: Column(children: [
            Padding(
                padding: EdgeInsets.all(20),
                child: Container(child: Image.asset('assets/xerion.png'))),
            Padding(
                padding: EdgeInsets.all(30),
                child: Text(
                    "Mañana puedes volver a jugar para ganar a Xerión. No olvides mirar la clasificación en la barra superior.",
                    style: TextStyle(
                      fontSize: 18.0,
                      wordSpacing: 1,
                      letterSpacing: 1.2,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF202020),
                    ))),
          ]));
  }

  Widget _getTopContainers() {
    return Container(
        color: Colors.transparent,
        padding: EdgeInsets.fromLTRB(40.0, 10.0, 40.0, 0.0),
        key: PageStorageKey<String>("grid"),
        width: queryData.size.width,
        height: Platform.isIOS ? 480 : 440,
        child: GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            itemCount: solution.length * (solution.length + 1),
            gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 1.0,
                crossAxisSpacing: 1.0,
                childAspectRatio: 1.0,
                crossAxisCount: solution.length),
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                  child: GestureDetector(
                      onTap: () {
                        //
                      },
                      child: Padding(
                          padding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
                          child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: _getColor(index),
                                  border: Border.all(color: Color(0xFFcdd0d5)),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0))),
                              height: 30,
                              width: 30,
                              child: Text(
                                  characters[index ~/ solution.length]
                                      [index % solution.length],
                                  style: TextStyle(
                                      color: _getTextColor(index)))))));
            }));
  }

  Color _getTextColor(index) {
    if (colors[index ~/ solution.length][index % solution.length] == 2) {
      return Colors.white;
    } else {
      return Colors.black;
    }
  }

  Color _getColor(int index) {
    if (colors[index ~/ solution.length][index % solution.length] == 0) {
      return Colors.transparent;
    } else if (colors[index ~/ solution.length][index % solution.length] == 1) {
      return Color(0xFFf3d851);
    } else if (colors[index ~/ solution.length][index % solution.length] == 2) {
      return Color(0xFF198BCA);
    } else {
      return Color(0xFFEEEEEE);
    }
  }

  _getKeyboard() {
    return Container(
      color: Colors.transparent,
      child: VirtualKeyboard(
          height: 160,
          width: queryData.size.width - 20,
          textColor: Colors.white,
          textController: _controllerText,
          customLayoutKeys: _customLayoutKeys,
          defaultLayouts: const [
            VirtualKeyboardDefaultLayouts.Arabic,
            VirtualKeyboardDefaultLayouts.English
          ],
          fontSize: 18,
          type: VirtualKeyboardType.Alphanumeric,
          onKeyPress: _onKeyPress),
    );
  }

  //private methods for the game

  _checkSignInStatus() async {
    await GamesServices.signIn();
  }

  _initTheGame() {
    SchedulerBinding.instance?.addPostFrameCallback((_) async {
      solution = "";
      text = "";
      currentWord = 0;
      endGame = false;
      colors.clear();
      characters.clear();

      solution = rae[_dayOfTheyear() % rae.length].toUpperCase();
      for (var i = 0; i < solution.length + 1; i++) {
        List<int> subColorList = [];
        List<String> subCharactersList = [];
        for (var j = 0; j < solution.length; j++) {
          subColorList.add(0);
          subCharactersList.add("");
        }
        colors.add(subColorList);
        characters.add(subCharactersList);
      }
      print(solution);
      final SharedPreferences prefs = await _prefs;
      canPlay = prefs.getInt("last_day_played") != _dayOfTheyear();
      bool restored =false;
      //restore previous game
      if(prefs.getBool("arrays_contains_junk") == false && canPlay){
        colors.clear();
        characters.clear();
        for(var k = 0 ; k < solution.length + 1; k ++) {
          if(prefs.getStringList("colors_array_$k")!=null) {
            colors.add(prefs.getStringList("colors_array_$k")!.map((e) => int.parse(e)).toList());
          } else {
            List<int> subColorList = [];
            for (var j = 0; j < solution.length; j++) {
              subColorList.add(0);
            }
            colors.add(subColorList);
          }
        }
        for(var k = 0 ; k < solution.length + 1; k ++) {
          if(prefs.getStringList("characters_array_$k")!=null) {
            characters.add(prefs.getStringList("characters_array_$k")!);
          } else {
            List<String> subCharactersList = [];
            for (var j = 0; j < solution.length; j++) {
              subCharactersList.add("");
            }
            characters.add(subCharactersList);
          }
        }
        if(prefs.getInt("current_word_restored")!=null) {
          currentWord = prefs.getInt("current_word_restored")!;
        }

        restored = true;
        canPlay = true;
      } else {
        prefs.setBool("arrays_contains_junk", true);
      }

      //show a dialog to play or vaites hoy ya jugaste
      if(!restored) {
        canPlay
            ? _showAlert(context, DialogType.INFO, "Vamos a jugar",
            "Adivina la palabra del hoy")
            : _showAlert(context, DialogType.INFO, "Hoy ya jugaste",
            "Tendrás que volver mañana para seguir jugando");
      }
      setState(() {
        loadingGame = false;
      });
    });
  }

  int _dayOfTheyear() {
    return DateTime.now()
        .difference(new DateTime(DateTime.now().year, 1, 1, 0, 0))
        .inDays;
  }

  _fillTheArray() {
    for (var i = 0; i < characters[currentWord].length; i++) {
      if (i < text.characters.length) {
        characters[currentWord][i] = text.characters.elementAt(i).toUpperCase();
      } else {
        characters[currentWord][i] = "";
      }
    }
  }

  _showAlert(BuildContext context, DialogType type, String title, String desc) {
    AwesomeDialog(
            context: context,
            dialogType: type,
            borderSide: const BorderSide(color: Colors.green, width: 2),
            width: 400,
            buttonsBorderRadius: BorderRadius.all(const Radius.circular(2)),
            headerAnimationLoop: true,
            animType: AnimType.BOTTOMSLIDE,
            title: title,
            desc: desc,
            showCloseIcon: false,
            btnCancel: null,
            dismissOnBackKeyPress: false,
            dismissOnTouchOutside: false,
            btnOkOnPress: () {})
        .show();
  }

  _onKeyPress(VirtualKeyboardKey key) async {
    if (key.keyType == VirtualKeyboardKeyType.String) {
      if (text.length < solution.length && !endGame) {
        text = text + key.text;
        _fillTheArray();
      }
    } else if (key.keyType == VirtualKeyboardKeyType.Action) {
      switch (key.action) {
        case VirtualKeyboardKeyAction.Backspace:
          if (text.length == 0) return;
          text = text.substring(0, text.length - 1);
          _fillTheArray();
          break;
        case VirtualKeyboardKeyAction.Return:
          if (characters[currentWord][characters[currentWord].length - 1]
              .isNotEmpty) {
            //evaluate current word to draw colors
            Map<int, String> correct = {};
            Map<int, String> almost = {};
            for (var i = 0; i < characters[currentWord].length; i++) {
              if (i < solution.characters.length) {
                if (solution.characters.elementAt(i).toUpperCase() ==
                    characters[currentWord][i]) {
                  correct.addAll({i: characters[currentWord][i]});
                  colors[currentWord][i] = 2;
                } else if (solution.contains(characters[currentWord][i])) {
                  if (!almost.containsValue(characters[currentWord][i])) {
                    almost.addAll({i: characters[currentWord][i]});
                    colors[currentWord][i] = 1;
                  }
                } else {
                  colors[currentWord][i] = 3;
                }
              }
            }

            for (var element in almost.entries) {
              if (correct.containsValue(element.value)) {
                colors[currentWord][element.key] = 3;
              }
            }

            text = "";
            final SharedPreferences prefs = await _prefs;
            if (currentWord == solution.length ||
                correct.entries.length == solution.length) {
              //save the date
              prefs.setInt("last_day_played", _dayOfTheyear());

              int currentScore =  prefs.getInt("current_score") != null? prefs.getInt("current_score")!: 0;
              if (solution.isNotEmpty &&
                  correct.entries.length == solution.length) {
                _checkSignInStatus();
                await GamesServices.submitScore(
                    score: Score(
                        androidLeaderboardID: 'CgkIioGnq48DEAIQAQ',
                        iOSLeaderboardID: 'coruna_leaderboard_id',
                        value: currentScore + 100));
              } else {
                prefs.setInt("current_score", currentScore - 25);
              }

              _showAlert(
                  context,
                  correct.entries.length == solution.length
                      ? DialogType.SUCCES
                      : DialogType.QUESTION,
                  correct.entries.length == solution.length
                      ? "Siiiii 👏👏👏"
                      : "Ooooh 🥺",
                  correct.entries.length == solution.length
                      ? "Enhorabuena!! $solution era la solución 🎉"
                      : "Lo siento. $solution era la solución. Vuelve mañana 😊");

              //reload the interface
              setState(() {
                endGame = true;
                canPlay = false;
              });

              //remove current selections from prefs to restore
              prefs.setBool("arrays_contains_junk", true);

            } else {
              currentWord = currentWord + 1;

              //save current selection in prefs
              for(var k = 0 ; k<colors.length; k ++) {
                prefs.setStringList("colors_array_$k", colors[k].map((e) => e.toString()).toList());
              }
              for(var k = 0 ; k<characters.length; k ++) {
                prefs.setStringList("characters_array_$k", characters[k]);
              }
              prefs.setInt("current_word_restored",currentWord);
              prefs.setBool("arrays_contains_junk", false);
            }
          }
          break;
        default:
      }
    }
    // Update the screen
    setState(() {});
  }
}
