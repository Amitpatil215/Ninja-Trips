import 'package:flutter/material.dart';

class Heart extends StatefulWidget {
  @override
  _HeartState createState() => _HeartState();
}

class _HeartState extends State<Heart> with SingleTickerProviderStateMixin {
  bool isFav = false;
  AnimationController _controller;
  Animation _colorAnimation;
  Animation<double> _sizeAnimation;
  Animation _curve;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 300),
      // vsync syncs with our state, by passing this we mentioning please
      // sync with this state of statefull Widget.
      vsync: this,
    );

    _curve = CurvedAnimation(
      parent: _controller,
      curve: Curves.slowMiddle,
    );

    _colorAnimation = ColorTween(
      begin: Colors.grey[400],
      end: Colors.red,
    )
        //.animate(_controller);
        // by passing curve we actually passing controller with curve as it defiend as
        // parent to the CurvedAnimation. Do pass controller if don't wanna use curve
        .animate(_curve);
    _sizeAnimation = TweenSequence(<TweenSequenceItem<double>>[
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 30, end: 50), weight: 50 // sets the both sequence item time to 50 percent
          ),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 50, end: 30), weight: 50 // sets the both sequence item time to 50 percent
          ),
    ]).animate(_controller);

    // Listen to changes of animationController values.
    _controller.addListener(() {
      // instead of setting state every time value of controller changes
      // and building whole tree again, use animationBuilder on specific widget
      // which listen to value changes.
      // setState(() {});
      print(_controller.value);
      print(_colorAnimation.value);
    });

    // Listen to changes of animationController status.
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          isFav = true;
        });
      }
      if (status == AnimationStatus.dismissed) {
        setState(() {
          isFav = false;
        });
      }
      print(status);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: EdgeInsets.all(0),
      icon: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Icon(
            Icons.favorite,
            color: _colorAnimation.value,
            size: _sizeAnimation.value,
          );
        },
      ),
      onPressed: () {
        isFav
            ?
            //Ends the animation
            _controller.reverse()
            :
            //Starts the animation
            _controller.forward();
      },
    );
  }
}
