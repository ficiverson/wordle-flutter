
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';

import 'game.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);


  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  late MediaQueryData queryData;


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF198BCA),
        title: Text("Ajustes",
            style: TextStyle(
                fontFamily: 'Calestra',
                fontSize: 30,
                fontWeight: FontWeight.w700)),
      ),
      body: SingleChildScrollView(
      key: PageStorageKey<String>("news_detail_container"),
    scrollDirection: Axis.vertical,
    physics: BouncingScrollPhysics(),
    child: Padding(
          padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0),
          child: Html(
            style: {
              "h2": Style(
                  color: Color(0xFF198BCA),
                  whiteSpace: WhiteSpace.PRE,
                  fontSize: FontSize(22)),
              "h3": Style(
                  color: Color(0xFF198BCA),
                  whiteSpace: WhiteSpace.PRE,
                  fontSize: FontSize(19)),
              "html": Style(
                  color: Color(0xFF202020),
                  whiteSpace: WhiteSpace.PRE,
                  fontSize: FontSize(16)),
              "p": Style(textAlign: TextAlign.left),
              "a": Style(
                  color: Color(0xFF198BCA),
                  textDecoration: TextDecoration.underline,
                  textDecorationColor: Color(0xFF198BCA))
            },
            onLinkTap: (url, _, __, ___) {
             // lets see
            },
            data: html,
          ))
    ));
  }

  final String html = "<html><body><h2 id=\"benvida-a-xerión-project\">Benvida a Xerión project</h2> <p><img src=\"https://user-images.githubusercontent.com/12527053/150801054-51d2b84b-f24a-4cf8-8663-62bd6f20e3a7.png\" width=\"200\"></p> <h3 id=\"algunas-pantallas-de-la-app\">Algunas pantallas de la app</h3> <p><img src=\"https://user-images.githubusercontent.com/12527053/150809960-cc7e60fb-d69c-4260-b034-b193711bdc55.png\" width=\"200\"><img src=\"https://user-images.githubusercontent.com/12527053/150808412-6195f4b9-294e-46c1-9ed6-650461b9ef52.png\" width=\"200\"><img src=\"https://user-images.githubusercontent.com/12527053/150807951-335dbffc-260f-4591-8d2e-4aabbc36bbfc.png\" width=\"200\"><img src=\"https://user-images.githubusercontent.com/12527053/150808530-cd1f338c-7744-4a06-bdbf-a93f1a2071aa.png\" width=\"200\"></p> <p>A continuación puedes ver los términos de uso, política de privacidad y licencias de software de la app Xerión.</p><h3 id=\"términos-y-condiciones\">Términos y condiciones</h3> <p>Puedes utilizar el juego como quieras e incluso puedes hacer tu propia versión si modificas el código fuente que está disponible para su modificación aquí https://github.com/ficiverson/wordle-flutter</p> <h3 id=\"política-de-privacidad\">Política de privacidad</h3><p>La app no rastrea ningún tipo de información del usuario y tampoco hace uso de la conexión a internet del mismo salvo para guardar los datos de Game Center y Play Games.</p> <h3 id=\"agradecimientos\">Agradecimientos</h3> <p>Agradecimientos a la cuenta https://mobile.twitter.com/xerionxerion por el icono de la app que está basado en su diseño de gloriosos Xeriones que están por toda la ciudad.</p><h3 id=\"licencias-de-uso-de-librerías\">Licencias de uso de librerías</h3> <h4 id=\"cupertino_icons-102\">cupertino_icons: ^1.0.2</h4> <p>Web del plugin https://pub.dev/packages/cupertino_icons</p> <p>Licencia: The MIT License (MIT) Copyright (c) 2016 Vladimir Kharlampidi</p> <h4 id=\"virtual_keyboard_multi_language-024\">virtual_keyboard_multi_language: ^0.2.4</h4> <p>Web del plugin https://pub.dev/packages/virtual_keyboard_multi_language</p> <p>Licencia: MIT License Copyright (c) 2020 Ahmed El-Araby</p> <h4 id=\"awesome_dialog-212\">awesome_dialog: ^2.1.2</h4><p>Web del plugin https://pub.dev/packages/awesome_dialog</p><p>Licencia: Copyright (c) 2019, Marcos Rodríguez Toranzo (marcos930807)</p> <h4 id=\"games_services-202\">games_services: ^2.0.2</h4> <p>Web del plugin https://pub.dev/packages/games_services</p> <h4 id=\"onboarding-210\">onboarding: ^2.1.0</h4><p>Web del plugin https://pub.dev/packages/onboarding</p><p>Licencia: MIT License Copyright (c) 2020 Eyoel Defare</p> <h4 id=\"shared_preferences-2012\">shared_preferences: ^2.0.12</h4><p>Web del plugin https://pub.dev/packages/shared_preferences</p><p>Licencia: Copyright 2013 The Flutter Authors. All rights reserved.</p> <h4 id=\"loading-102\">loading: ^1.0.2</h4><p>Web del plugin https://pub.dev/packages/loading</p><h4 id=\"share-204\">share: ^2.0.4</h4> <p>Web del plugin https://pub.dev/packages/share</p> <p>Licencia: Copyright 2013 The Flutter Authors. All rights reserved.</p> <h4 id=\"flutter_html134\">flutter_html: ^1.3.0</h4> <p>Web del plugin https://pub.dev/packages/flutter_html</p> <p>Licencia: MIT License Copyright (c) 2019-2022 The flutter_html developers</p><h3 id=\"contacto\">Contacto</h3> <p>Contacta con me@fernandosouto.dev para dudas o consultas. Más info de contacto en https://fernandosouto.dev/</p></body></html>";
}