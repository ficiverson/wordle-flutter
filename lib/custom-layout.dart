import 'package:virtual_keyboard_multi_language/virtual_keyboard_multi_language.dart';

class CustomLayoutKeys extends VirtualKeyboardLayoutKeys{

  @override
  int getLanguagesCount() => 2;

  List<List> getLanguage(int index){
    switch(index){
      case 1:
        return _characters;
      default:
        return _characters;
    }
  }

}


const List<List> _characters = [
  // Row 1
  const [
    '',
    'Q',
    'W',
    'E',
    'R',
    'T',
    'Y',
    'U',
    'I',
    'O',
    'P',
    '',
  ],
  // Row 2
  const [
    '',
    'A',
    'S',
    'D',
    'F',
    'G',
    'J',
    'H',
    'K',
    'L',
    'Ñ',
    '',
  ],
  // Row 3
  const [
    VirtualKeyboardKeyAction.Backspace,
    '',
    'Z',
    'X',
    'C',
    'V',
    'B',
    'N',
    'M',
    '',
    VirtualKeyboardKeyAction.Return
  ]
];

