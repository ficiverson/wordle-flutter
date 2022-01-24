
import 'package:flutter/scheduler.dart';
import 'package:games_services/games_services.dart';
import 'package:onboarding/onboarding.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

import 'game.dart';

class TutorialPage extends StatefulWidget {
  const TutorialPage({Key? key, required this.onlyAccount}) : super(key: key);
  final bool onlyAccount;

  @override
  State<TutorialPage> createState() => _TutorialPageState();
}

class _TutorialPageState extends State<TutorialPage> {

  late MediaQueryData queryData;
  final ValueNotifier<double> notifier = ValueNotifier(0);
  final _pageCtrl = PageController();
  int pageCount = 6;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();


  @override
  void initState() {
    SchedulerBinding.instance?.addPostFrameCallback((_) async {
      if(widget.onlyAccount) {
        _checkSignInStatus();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    queryData = MediaQuery.of(context);
    return _getTutorial(widget.onlyAccount);
  }

  //widget mthods

  Widget _getTutorial(bool onlyAccount) {
    return Onboarding(
      background: Colors.white,
      proceedButtonStyle: ProceedButtonStyle(
        proceedpButtonText: Text(onlyAccount ? "Jugar":"Empezar",
          style: defaultProceedButtonTextStyle,
        ),
        proceedButtonRoute: (context) async {
          final SharedPreferences prefs = await _prefs;
          prefs.setBool("tutorial_shown", true);
          if(!onlyAccount) {
            _checkSignInStatus();
          }
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => MyHomePage(title: "Xerión")),
          );
        },
      ),
      pages: onlyAccount ? onboardingPagesListAccount : onboardingPagesList,
      isSkippable: false,
      indicator: Indicator(
          indicatorDesign: IndicatorDesign.polygon(
              polygonDesign: PolygonDesign(
                  polygon: DesignType.polygon_diamond, polygonSpacer: 13.0))),
    );
  }


  final onboardingPagesListAccount = [
    PageModel(
      widget: Column(
        children: [
          SizedBox(height: 50),
          Container(
              height: 300,
              width: 300,
              padding: EdgeInsets.only(top: 20.0),
              child: Image.asset('assets/xerion.png')),
          SizedBox(height: 50),
          Container(
              width: double.infinity,
              child: Text('¿Podrás batir a Xerión?',
                  style: TextStyle(
                    fontSize: 23.0,
                    wordSpacing: 1,
                    letterSpacing: 1.2,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF202020),
                  ))),
          Container(
            width: double.infinity,
            child: Text(
              '\nYa estás lista para continuar jugando'
                  '\n\nRecuerda que Xerión te dará algunas pistas pero te cobrará su ayuda con algunos puntos.'
                  '\n\nCada vez que falles perderás puntos.'
                  '\n\nUna palabra al día.',
              style: TextStyle(
                color: Color(0xFF202020),
                letterSpacing: 0.7,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    )
  ];

  final onboardingPagesList = [
    PageModel(
      widget: Column(
        children: [
          SizedBox(height: 50),
          Container(
              height: 300,
              padding: EdgeInsets.only(top: 20.0),
              child: Image.asset('assets/final1.png')),
          SizedBox(height: 50),
          Container(
              width: double.infinity,
              child: Text('¿Eres CTV?',
                  style: TextStyle(
                    fontSize: 23.0,
                    wordSpacing: 1,
                    letterSpacing: 1.2,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF202020),
                  ))),
          Container(
            width: double.infinity,
            child: Text(
              "\nCada día una nueva palabra que tiene alguna relación con nuestra querida Coruña. Xerión te dará una pista si la necesitas."
                  "\n\nCada intento debe ser una palabra válida de tantas letras como cuadrados ves en la pantalla. Pulsa '>' para enviar. "
                  "\nSi necesitas borrar puedes hacerlo con '<'",
              style: TextStyle(
                color: Color(0xFF202020),
                letterSpacing: 0.7,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    ),
    PageModel(
        widget: Column(
          children: [
            SizedBox(height: 50),
            Container(
                height: 300,
                padding: EdgeInsets.only(top: 20.0),
                child: Image.asset('assets/final2.png')),
            SizedBox(height: 50),
            Container(
                width: double.infinity,
                child: Text('¿Cómo se juega?',
                    style: TextStyle(
                      fontSize: 23.0,
                      wordSpacing: 1,
                      letterSpacing: 1.2,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF202020),
                    ))),
            Container(
              width: double.infinity,
              child: Text(
                '\nDespués de cada intento el color de las letras cambia para mostrar qué tan cerca estás de acertar la palabra.'
                    '\n\nLas letras D E y O están en la palabra pero en la posición incorrecta por eso se colorean de amarillo.'
                    '\n\nLas letras P y R no están presentes en la solución por eso se colorean de gris.',
                style: TextStyle(
                  color: Color(0xFF202020),
                  letterSpacing: 0.7,
                  height: 1.5,
                ),
              ),
            ),
          ],
        )),
    PageModel(
      widget: Column(
        children: [
          SizedBox(height: 50),
          Container(
              height: 300,
              padding: EdgeInsets.only(top: 20.0),
              child: Image.asset('assets/final3.png')),
          SizedBox(height: 50),
          Container(
              width: double.infinity,
              child: Text('¿Cómo se juega?',
                  style: TextStyle(
                    fontSize: 23.0,
                    wordSpacing: 1,
                    letterSpacing: 1.2,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF202020),
                  ))),
          Container(
            width: double.infinity,
            child: Text(
              '\nCuando aciertas la posición de la letra en la solución entonces se colorea de color azul.'
                  '\n\nLas letras B O E D O están en la palabra por eso se pintan de azul.'
                  '\n\nComo acertaste todas las letras has ganado la partida.',
              style: TextStyle(
                color: Color(0xFF202020),
                letterSpacing: 0.7,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    ),
    PageModel(
      widget: Column(
        children: [
          SizedBox(height: 50),
          Container(
              height: 300,
              width: 300,
              padding: EdgeInsets.only(top: 20.0),
              child: Image.asset('assets/xerion.png')),
          SizedBox(height: 50),
          Container(
              width: double.infinity,
              child: Text('Enhorabuena!!!',
                  style: TextStyle(
                    fontSize: 23.0,
                    wordSpacing: 1,
                    letterSpacing: 1.2,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF202020),
                  ))),
          Container(
            width: double.infinity,
            child: Text(
              '\nYa está todo listo para participar en el reto al que juega toda la ciudad. ¿Podrás batir a Xerión?'
              '\n\nRecuerda que Xerión te dará algunas pistas pero te cobrará su ayuda con algunos puntos. Cada vez que falles perderás puntos.',
              style: TextStyle(
                color: Color(0xFF202020),
                letterSpacing: 0.7,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    )
  ];

  _checkSignInStatus() async {
    await GamesServices.signIn();
  }
}