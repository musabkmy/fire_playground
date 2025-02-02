import 'dart:math';

import 'package:flutter/material.dart';

class AnimationTestLayout extends StatefulWidget {
  const AnimationTestLayout({super.key});

  @override
  State<AnimationTestLayout> createState() => _AnimationTestLayoutState();
}

class _AnimationTestLayoutState extends State<AnimationTestLayout>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  double _x = 1;
  double _y = 0;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _animation = Tween<Offset>(begin: Offset(0, 0), end: Offset(_x, _y))
        .animate(_controller);

    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // random seed
  final _random = Random();

  // the coordinates of the box

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kindacode.com'),
      ),
      // implement Transform stuff
      body: AnimatedBuilder(
        animation: _animation,
        builder: (BuildContext context, Widget? child) {
          return Transform.translate(
            offset: _animation.value * MediaQuery.of(context).size.width,
            child: Container(
              width: 100,
              height: 100,
              color: Colors.red,
            ),
          );
        },
      ),
      // this button is used to move the box
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _x = _random.nextDouble();
            _y = _random.nextDouble();
            _animation = Tween<Offset>(begin: Offset(0, 0), end: Offset(_x, _y))
                .animate(_controller);
            _controller.repeat(reverse: true);
          });
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
