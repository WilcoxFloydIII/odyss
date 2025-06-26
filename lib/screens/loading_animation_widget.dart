import 'package:flutter/material.dart';

class LoadingAnimationWidget extends StatefulWidget {
  const LoadingAnimationWidget({super.key});

  @override
  State<LoadingAnimationWidget> createState() => _LoadingAnimationWidgetState();
}

class _LoadingAnimationWidgetState extends State<LoadingAnimationWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _sizeAnimation;
  late Animation<double> _elevationAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);

    _sizeAnimation = Tween<double>(
      begin: 100,
      end: 120,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _elevationAnimation = Tween<double>(
      begin: 4,
      end: 12,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Material(
            elevation: _elevationAnimation.value,
            shape: const CircleBorder(),
            color: Colors.white,
            shadowColor: Colors.transparent,
            child: SizedBox(
              height: _sizeAnimation.value,
              width: _sizeAnimation.value,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Image.asset('assets/icons/odyss_logo_loading.png'),
              ),
            ),
          );
        },
      ),
    );
  }
}
