import 'package:flutter/material.dart';

class Sandbox extends StatefulWidget {
  @override
  _SandboxState createState() => _SandboxState();
}

class _SandboxState extends State<Sandbox> {
  double _opacity = 1; //Fully Visible
  double _margin = 0;
  double _width = 200;
  Color _color = Colors.blue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: AnimatedContainer(
        duration: Duration(seconds: 2),
        margin: EdgeInsets.all(_margin),
        width: _width,
        color: _color,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            RaisedButton(
              child: Text("Animate Margin"),
              onPressed: () => setState(() {
                _margin = 50;
              }),
            ),
            RaisedButton(
              child: Text("Animate Color"),
              onPressed: () => setState(() {
                _color = Colors.purple;
              }),
            ),
            RaisedButton(
              child: Text("Animate Width"),
              onPressed: () => setState(() {
                _width = 400;
              }),
            ),
            RaisedButton(
              child: Text("Animate Opacity"),
              onPressed: () => setState(() {
                _opacity = 0;
              }),
            ),
            AnimatedOpacity(
              duration: Duration(seconds: 2),
              opacity: _opacity,
              child: Text(
                "Hide Me\nBy pressing Animate Opacity",
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}
