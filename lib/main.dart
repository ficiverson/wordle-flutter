import 'dart:math';
import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:virtual_keyboard_multi_language/virtual_keyboard_multi_language.dart';

import 'custom-layout.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Wordle Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: const MyHomePage(title: 'Wordle with Flutter'),
    );
  }
}

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
  bool playDay = false;
  bool _showDialog = true;
  bool endGame = false;
  List<List<int>> colors = [
    [0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0]
  ];
  List<List<String>> characters = [
    ["", "", "", "", ""],
    ["", "", "", "", ""],
    ["", "", "", "", ""],
    ["", "", "", "", ""],
    ["", "", "", "", ""],
    ["", "", "", "", ""]
  ];

  var rae = [
    "aseos",
    "himno",
    "debil",
    "perro",
    "suele",
    "chapa",
    "vista",
    "lenta",
    "bolsa",
    "horno",
    "bebes",
    "trama",
    "salon",
    "frase",
    "reves",
    "prosa",
    "rollo",
    "secta",
    "ricas",
    "radio",
    "cuero",
    "drama",
    "valla",
    "lapiz",
    "fruta",
    "rollo",
    "durar",
    "trono",
    "trato",
    "queja",
    "rejas",
    "poema",
    "sabio",
    "vivas",
    "dieta",
    "vinos",
    "noche",
    "gallo",
    "botes",
    "pollo",
    "veloz",
    "grasa",
    "exito",
    "laser",
    "mando",
    "verde",
    "deuda",
    "pobre",
    "cacao",
    "rasgo",
    "barro",
    "calma",
    "deuda",
    "plazo",
    "solar",
    "audaz",
    "unida",
    "nubes",
    "tapia",
    "doble",
    "feroz",
    "dosis",
    "palos",
    "angel",
    "bomba",
    "china",
    "botin",
    "velas",
    "vivas",
    "algas",
    "pasta",
    "bello",
    "funda",
    "plaza",
    "judia",
    "atomo",
    "elite",
    "pelos",
    "dieta",
    "rosas",
    "metas",
    "cajon",
    "bomba",
    "fauna",
    "matar",
    "turno",
    "notar",
    "harto",
    "rojos",
    "rubio",
    "calle",
    "guapo",
    "apodo",
    "buque",
    "patas",
    "dolar",
    "velas",
    "rojos",
    "sabor",
    "timon",
    "metas",
    "vista",
    "panza",
    "rubio",
    "golpe",
    "perro",
    "apoyo",
    "papel",
    "cable",
    "gasto",
    "farsa",
    "vocal",
    "lecho",
    "queja",
    "acoso",
    "secos",
    "vigor",
    "atlas",
    "audaz",
    "ratas",
    "sabor",
    "furia",
    "tiras",
    "cuota",
    "pausa",
    "manos",
    "dulce",
    "queja",
    "grito",
    "grado",
    "palos",
    "palos",
    "vinos",
    "guapa",
    "rodar",
    "milla",
    "radar",
    "sucio",
    "pagas",
    "grado"
  ];

  final CustomLayoutKeys _customLayoutKeys = CustomLayoutKeys();
  late MediaQueryData queryData;
  final TextEditingController _controllerText = TextEditingController();

  @override
  void initState() {
    _initTheGame();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    queryData = MediaQuery.of(context);
    Future.delayed(
        Duration.zero,
        () => _showDialog
            ? _showAlert(
                context,
                DialogType.INFO,
                "Lets play",
                 "You need to guess the word. Its in Spanish!!"): null);
    return Scaffold(
        appBar: AppBar(
          actions: playDay? [] : [IconButton(
            icon: Icon(
              Icons.replay,
              color: Colors.black,
            ),
            onPressed: () {
              setState(() {
                _initTheGame();
              });
            },
          )],
          title: Text(widget.title,
              style: TextStyle(
                  fontFamily: 'Calestra',
                  fontSize: 30,
                  fontWeight: FontWeight.w700)),
        ),
        body: Container(
          height: queryData.size.height,
          color: Colors.white,
          child: Center(
            child: Column(
              children: <Widget>[
                _getTopContainers(),
                Platform.isIOS ? SizedBox(height: 40) : Container(),
                Container(
                    height: 40,
                    child: Image.network(
                        'https://mir-s3-cdn-cf.behance.net/project_modules/fs/40798517511159.562bafbf8916a.jpg')),
                _getKeyboard()
              ],
            ),
          ),
        ));
  }

  //widget mthods

  Widget _getTopContainers() {
    return Container(
        color: Colors.transparent,
        padding: EdgeInsets.fromLTRB(40.0, 40.0, 40.0, 00.0),
        key: PageStorageKey<String>("grid"),
        width: queryData.size.width,
        height: Platform.isIOS ? 480 : 440,
        child: GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            itemCount: 30,
            gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 1.0,
                crossAxisSpacing: 1.0,
                childAspectRatio: 1.0,
                crossAxisCount: 5),
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
                            child: Text(characters[index ~/ 5][index % 5]),
                          ))));
            }));
  }

  Color _getColor(int index) {
    if (colors[index ~/ 5][index % 5] == 0) {
      return Colors.transparent;
    } else if (colors[index ~/ 5][index % 5] == 1) {
      return Colors.orange;
    } else if (colors[index ~/ 5][index % 5] == 2) {
      return Colors.green;
    } else {
      return Colors.grey;
    }
  }

  _getKeyboard() {
    return Container(
      color: Colors.transparent,
      child: VirtualKeyboard(
          height: 100,
          width: queryData.size.width - 20,
          textColor: Colors.white,
          textController: _controllerText,
          customLayoutKeys: _customLayoutKeys,
          defaultLayouts: [
            VirtualKeyboardDefaultLayouts.Arabic,
            VirtualKeyboardDefaultLayouts.English
          ],
          fontSize: 18,
          type: VirtualKeyboardType.Alphanumeric,
          onKeyPress: _onKeyPress),
    );
  }

  //private methods for the game

  _initTheGame() {
    text = "";
    currentWord = 0;
    endGame = false;
    colors = [
      [0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0]
    ];
    characters = [
      ["", "", "", "", ""],
      ["", "", "", "", ""],
      ["", "", "", "", ""],
      ["", "", "", "", ""],
      ["", "", "", "", ""],
      ["", "", "", "", ""]
    ];

    solution = rae[Random().nextInt(rae.length)].toUpperCase();
    print(solution);
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

  bool _compareDates(DateTime reference) {
    return DateTime.now().day == reference.day &&
        DateTime.now().month == reference.month &&
        DateTime.now().year == reference.year;
  }

  _showAlert(BuildContext context, DialogType type, String title, String desc) {
    _showDialog = false;
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
      btnOkOnPress: () {
        _showDialog = false;
      },
    ).show();
  }


  _onKeyPress(VirtualKeyboardKey key) {
    if (key.keyType == VirtualKeyboardKeyType.String) {
      if (text.length < 5 && !endGame) {
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
                  correct.addAll({ i : characters[currentWord][i]});
                  colors[currentWord][i] = 2;
                } else if (solution.contains(characters[currentWord][i])) {
                  if (!almost.containsValue(characters[currentWord][i])) {
                    almost.addAll({i : characters[currentWord][i]});
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
            if (currentWord == 5 || correct.entries.length == 5) {
              endGame = true;
              _showAlert(context,correct.entries.length == 5
                  ? DialogType.SUCCES
                  : DialogType.QUESTION,
                  correct.entries.length == 5 ? "Yeeeesssss" : "Ooooh",
                  correct.entries.length == 5 ?
                      "$solution You did it! :)"
                      : "Sorry for that. You can reload the game with another word in the top bar");
            } else {
              currentWord = currentWord + 1;
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
