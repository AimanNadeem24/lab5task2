import 'package:flutter/material.dart';

void main() {
  runApp(const Aimoo());
}

class Aimoo extends StatelessWidget {
  const Aimoo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Center(child: const Text('Pookies Animation'))),
        body: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;
  late Animation<double> _borderRadiusAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _animation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(1.0, 0.0),
    ).animate(_controller);

    _borderRadiusAnimation = Tween<double>(
      begin: 0.0,
      end: 50.0,
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _startAnimation() {
    if (_controller.isAnimating) {
      _controller.stop();
    } else {
      _controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SlideTransition(
            position: _animation,
            child: AnimatedBuilder(
              animation: _borderRadiusAnimation,
              builder: (context, child) {
                return Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 226, 97, 194),
                    borderRadius:
                        BorderRadius.circular(_borderRadiusAnimation.value),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _startAnimation,
            child: const Text('pop it/stop it'),
          ),
        ],
      ),
    );
  }
}
