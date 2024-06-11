import 'package:flutter/material.dart';

import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;  // Import dart:ui
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sketch Craft',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,  // Set debugShowCheckedModeBanner to false
      home: DrawingPage(),
    );
  }
}

class DrawingPage extends StatefulWidget {
  @override
  _DrawingPageState createState() => _DrawingPageState();
}

class _DrawingPageState extends State<DrawingPage> {
  List<List<Offset>> _lines = [];
  List<Offset> _points = [];
  List<List<Offset>> _undoList = [];
  List<List<Offset>> _redoList = [];

  void _startLine(Offset point) {
    setState(() {
      _points = [point];
    });
  }

  void _updateLine(Offset point) {
    setState(() {
      _points.add(point);
    });
  }

  void _finishLine() {
    setState(() {
      _lines.add(List.from(_points));
      _points.clear();
    });
  }

  void _undo() {
    if (_lines.isNotEmpty) {
      _undoList.add(_lines.removeLast());
      setState(() {});
    }
  }

  void _redo() {
    if (_undoList.isNotEmpty) {
      _lines.add(_undoList.removeLast());
      setState(() {});
    }
  }


  void _erase() {
    // Show a confirmation dialog before clearing the sketch
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Clear Sketch'),
          content: Text('Are you sure you want to clear the sketch?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: Text('Clear'),
              onPressed: () {
                // Clear the sketch
                setState(() {
                  _lines.clear();
                  _undoList.clear();
                  _redoList.clear();
                });
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }





  void _save() {
    // Show a popup to inform the user that the sketch has been "saved"
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Sketch Saved'),
          content: Text('Your sketch has been "saved".'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: AppBar(
          title: Text(
            'Sketch Craft',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.blueAccent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: GestureDetector(
                    onPanStart: (details) {
                      RenderBox renderBox = context.findRenderObject() as RenderBox;
                      _startLine(renderBox.globalToLocal(details.globalPosition));
                    },
                    onPanUpdate: (details) {
                      RenderBox renderBox = context.findRenderObject() as RenderBox;
                      _updateLine(renderBox.globalToLocal(details.globalPosition));
                    },
                    onPanEnd: (details) {
                      _finishLine();
                    },
                    child: CustomPaint(
                      painter: SketchPainter(_lines),
                      size: Size.infinite,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: Icon(Icons.undo),
                onPressed: _undo,
              ),
              IconButton(
                icon: Icon(Icons.redo),
                onPressed: _redo,
              ),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: _erase,
              ),
              IconButton(
                icon: Icon(Icons.save),
                onPressed: _save,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SketchPainter extends CustomPainter {
  final List<List<Offset>> lines;

  SketchPainter(this.lines);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    for (final line in lines) {
      for (int i = 0; i < line.length - 1; i++) {
        if (line[i] != null && line[i + 1] != null) {
          canvas.drawLine(line[i], line[i + 1], paint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
