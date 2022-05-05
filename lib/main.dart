import 'dart:ui';
import 'package:flutter/material.dart';
import 'dart:math';
//import 'package:flutter_launcher_icons/android.dart';

void main() {
  runApp(MyApp());
}

final selections = ['YES', 'NO'];
var selected = '?';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override

  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Yes/No Button',
      home: Button(),
    );
  }
}

class Button extends StatefulWidget {
  @override
  _ButtonState createState() => _ButtonState();
}

class _ButtonState extends State<Button> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    const selection();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              selection(),
              Container(
                  height: 100.0,
                  width: 200.0,
                  child: SizedBox(
                      child: FloatingActionButton(
                        onPressed: () {
                          makeSelection();
                          },
                        tooltip: 'Press',
                        child: const Icon(Icons.autorenew, size: 80, color: Color(0xFFE8EAF6)),
                        backgroundColor: Colors.orange[600],
                      )
                  )
              ),
            ]
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF37474F), Color(0xFF607D8B)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
      ),
    );
  }

  void makeSelection() {
    selected = selections[Random().nextInt(2)];
    setState(() {
      const selection();
    });
  }
}

class selection extends StatefulWidget {
  const selection({Key? key}) : super(key: key);
  @override
  _selectionState createState() => _selectionState();
}

class _selectionState extends State<selection> with TickerProviderStateMixin {
  late AnimationController animController;
  late Animation<double> sizeAnimation;

  @override
  void initState() {
    print('My init state');
    super.initState();
    animController = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
    sizeAnimation = Tween(begin: 20.0, end: 150.0).chain(CurveTween(curve: Curves.easeOutQuart)).animate(animController);
    animController.forward();
  }

  @override
  void didUpdateWidget(selection oldWidget) {
    animController.reset();
    animController.forward();
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      size: sizeAnimation,
    );
  }

  @override
  void dispose () {
    animController.dispose();
    super.dispose();
  }
}

class SizeTransition extends AnimatedWidget {
  const SizeTransition({Key? key, required Animation<double> size}) : super(key: key, listenable: size);

  @override
  Widget build(BuildContext context) {
    final size = super.listenable as Animation<double>;
    return Container(
        width: 300.0,
        height: 300.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [Color(0xFFFFA726), Color(0xFFF57C00)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        alignment: Alignment.center,
        child: Text(
            selected,
            style: TextStyle(
              fontSize: size.value,
              fontWeight: FontWeight.bold,
              color: Colors.indigo[50],
            )
        )
    );
  }
}