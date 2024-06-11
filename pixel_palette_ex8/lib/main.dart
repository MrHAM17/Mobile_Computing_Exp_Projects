// import 'package:flutter/material.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter GUI App',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         fontFamily: 'SF-Pro-Text',
//       ),
//       home: MyHomePage(),
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   double fontSize = 25.0;
//   FontWeight fontWeight = FontWeight.normal;
//   FontStyle fontStyle = FontStyle.normal;
//   TextDecoration textDecoration = TextDecoration.none;
//   Color textColor = Colors.black;
//   int colorIndex = 0;
//   List<Color> colors = [
//     Colors.red,
//     Colors.green,
//     Colors.blue,
//     Colors.cyan,
//     Colors.yellow,
//     Colors.purple,
//   ];
//
//   TextEditingController textEditingController = TextEditingController();
//
//   void changeFontSize() {
//     setState(() {
//       fontSize += 5;
//       if (fontSize > 50) {
//         fontSize = 25;
//       }
//     });
//   }
//
//   void changeFontWeight() {
//     setState(() {
//       fontWeight = fontWeight == FontWeight.normal
//           ? FontWeight.bold
//           : FontWeight.normal;
//     });
//   }
//
//   void changeFontStyle() {
//     setState(() {
//       fontStyle = fontStyle == FontStyle.normal
//           ? FontStyle.italic
//           : FontStyle.normal;
//     });
//   }
//
//   void changeTextDecoration() {
//     setState(() {
//       if (textDecoration == TextDecoration.none) {
//         textDecoration = TextDecoration.lineThrough;
//       } else if (textDecoration == TextDecoration.lineThrough) {
//         textDecoration = TextDecoration.underline;
//       } else if (textDecoration == TextDecoration.underline) {
//         textDecoration = TextDecoration.none;
//       }
//     });
//   }
//
//   void changeTextColor() {
//     setState(() {
//       textColor = colors[colorIndex];
//       colorIndex = (colorIndex + 1) % colors.length;
//     });
//   }
//
//   void changeText(String newText) {
//     setState(() {
//       textEditingController.text = newText;
//     });
//   }
//
//   void clearText() {
//     setState(() {
//       textEditingController.clear();
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Center(child: Text('Flutter GUI App')),
//         backgroundColor: Colors.blue,
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.all(16.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               TextField(
//                 controller: textEditingController,
//                 decoration: InputDecoration(
//                   labelText: 'Enter your text',
//                   border: OutlineInputBorder(),
//                 ),
//                 onChanged: (value) {
//                   changeText(value);
//                 },
//               ),
//               SizedBox(height: 20),
//               Container(
//                 height: 150, // Set a fixed height for the result box
//                 decoration: BoxDecoration(
//                   border: Border.all(color: Colors.blue),
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: Padding(
//                   padding: EdgeInsets.all(8.0),
//                   child: SingleChildScrollView( // Make the result box scrollable
//                     child: SelectableText(
//                       textEditingController.text,
//                       style: TextStyle(
//                         fontSize: fontSize,
//                         color: textColor,
//                         fontWeight: fontWeight,
//                         fontStyle: fontStyle,
//                         decoration: textDecoration,
//                         fontFamily: 'Montserrat',
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: changeFontSize,
//                 child: Text(
//                   'Change font size',
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                     fontFamily: 'SF-Pro-Text',
//                   ),
//                 ),
//                 style: ElevatedButton.styleFrom(
//                   primary: Colors.blue,
//                   onPrimary: Colors.white,
//                   padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 10),
//               ElevatedButton(
//                 onPressed: changeFontWeight,
//                 child: Text(
//                   fontWeight == FontWeight.normal
//                       ? 'Make Bold'
//                       : 'Make Normal',
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                     fontFamily: 'SF-Pro-Text',
//                   ),
//                 ),
//                 style: ElevatedButton.styleFrom(
//                   primary: Colors.blue,
//                   onPrimary: Colors.white,
//                   padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 10),
//               ElevatedButton(
//                 onPressed: changeFontStyle,
//                 child: Text(
//                   fontStyle == FontStyle.normal
//                       ? 'Italic'
//                       : 'Normal',
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                     fontFamily: 'SF-Pro-Text',
//                   ),
//                 ),
//                 style: ElevatedButton.styleFrom(
//                   primary: Colors.blue,
//                   onPrimary: Colors.white,
//                   padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 10),
//               ElevatedButton(
//                 onPressed: changeTextDecoration,
//                 child: Text(
//                   textDecoration == TextDecoration.none
//                       ? 'Strike Through'
//                       : textDecoration == TextDecoration.lineThrough
//                       ? 'Underline'
//                       : 'None',
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                     fontFamily: 'SF-Pro-Text',
//                   ),
//                 ),
//                 style: ElevatedButton.styleFrom(
//                   primary: Colors.blue,
//                   onPrimary: Colors.white,
//                   padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 10),
//               ElevatedButton(
//                 onPressed: changeTextColor,
//                 child: Text(
//                   'Change color',
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                     fontFamily: 'SF-Pro-Text',
//                   ),
//                 ),
//                 style: ElevatedButton.styleFrom(
//                   primary: Colors.blue,
//                   onPrimary: Colors.white,
//                   padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: clearText,
//         child: Icon(Icons.clear),
//         backgroundColor: Colors.red,
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
//     );
//   }
// }

































import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pixel Palette',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'SF-Pro-Text',
      ),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,  // <-- Set this to false

    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double fontSize = 25.0;
  FontWeight fontWeight = FontWeight.normal;
  FontStyle fontStyle = FontStyle.normal;
  TextDecoration textDecoration = TextDecoration.none;
  Color textColor = Colors.black;
  int colorIndex = 0;
  List<Color> colors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.cyan,
    Colors.yellow,
    Colors.purple,
  ];

  TextEditingController textEditingController = TextEditingController();

  void changeFontSize() {
    setState(() {
      fontSize += 5;
      if (fontSize > 50) {
        fontSize = 25;
      }
    });
  }

  void changeFontWeight() {
    setState(() {
      fontWeight = fontWeight == FontWeight.normal
          ? FontWeight.bold
          : FontWeight.normal;
    });
  }

  void changeFontStyle() {
    setState(() {
      fontStyle = fontStyle == FontStyle.normal
          ? FontStyle.italic
          : FontStyle.normal;
    });
  }

  void changeTextDecoration() {
    setState(() {
      if (textDecoration == TextDecoration.none) {
        textDecoration = TextDecoration.lineThrough;
      } else if (textDecoration == TextDecoration.lineThrough) {
        textDecoration = TextDecoration.underline;
      } else if (textDecoration == TextDecoration.underline) {
        textDecoration = TextDecoration.none;
      }
    });
  }

  void changeTextColor() {
    setState(() {
      textColor = colors[colorIndex];
      colorIndex = (colorIndex + 1) % colors.length;
    });
  }

  void changeText(String newText) {
    setState(() {
      textEditingController.text = newText;
    });
  }

  void clearText() {
    setState(() {
      textEditingController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Pixel Palette',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        )),
        backgroundColor: Colors.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(10),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: textEditingController,
                decoration: InputDecoration(
                  labelText: 'Enter your text',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  changeText(value);
                },
              ),
              SizedBox(height: 20),
              Container(
                height: 150,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: SelectableText(
                      textEditingController.text,
                      style: TextStyle(
                        fontSize: fontSize,
                        color: textColor,
                        fontWeight: fontWeight,
                        fontStyle: fontStyle,
                        decoration: textDecoration,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 80),
              buildButtonRow([
                buildButton('Font size', changeFontSize),
                buildButton(
                    fontWeight == FontWeight.normal ? 'Make Bold' : 'Make Normal',
                    changeFontWeight),
              ]),
              SizedBox(height: 10),
              buildButtonRow([
                buildButton(
                    fontStyle == FontStyle.normal ? 'Italic' : 'Normal',
                    changeFontStyle),
                buildButton(
                    textDecoration == TextDecoration.none
                        ? 'Strike Through'
                        : textDecoration == TextDecoration.lineThrough
                        ? 'Underline'
                        : 'None',
                    changeTextDecoration),
              ]),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: changeTextColor,
                child: Text(
                  'Change color',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'SF-Pro-Text',
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  onPrimary: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: clearText,
        child: Icon(Icons.clear),
        backgroundColor: Colors.orangeAccent,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget buildButtonRow(List<Widget> buttons) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: buttons,
    );
  }

  Widget buildButton(String label, Function onPressed) {
    return ElevatedButton(
      onPressed: () => onPressed(),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          fontFamily: 'SF-Pro-Text',
        ),
      ),
      style: ElevatedButton.styleFrom(
        primary: Colors.blue,
        onPrimary: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
