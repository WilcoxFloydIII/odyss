import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:odyss/core/colors.dart';

class BottomAppBarWidget extends StatefulWidget {
  BottomAppBarWidget({
    super.key,
    required this.toggle1,
    required this.toggle2,
    required this.toggle3,
    required this.toggle4,
  });

  final bool toggle1;
  final bool toggle2;
  final bool toggle3;
  final bool toggle4;

  @override
  State<BottomAppBarWidget> createState() => _BottomAppBarWidgetState();
}

class _BottomAppBarWidgetState extends State<BottomAppBarWidget> {
  @override
  Widget build(BuildContext context) {
    //final myColors = Theme.of(context).extension<MyColors>()!;
    return BottomAppBar(
      color: Colors.black,
      padding: EdgeInsets.all(0),
      notchMargin: 0,
      elevation: 0,
      height: MediaQuery.of(context).size.height * 0.1,
      shape: null,
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: ElevatedButton(
              onPressed: () {
                context.go('/circles');
              },
              child: Image.asset(
                widget.toggle1
                    ? 'assets/icons/active_circles_icon.png.png'
                    : 'assets/icons/circles_icon.png',
                width: 25,
                height: 25,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: ElevatedButton(
              onPressed: () {
                context.go('/rides');
              },
              child: Image.asset(
                widget.toggle2
                    ? 'assets/icons/active_rides_icon.png'
                    : 'assets/icons/rides_icon.png',
                width: 30,
                height: 30,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: ElevatedButton(
              onPressed: () {
                context.go('/chat');
              },
              child: Image.asset(
                widget.toggle3
                    ? 'assets/icons/active_chat_icon.png'
                    : 'assets/icons/chat_icon.png',
                width: 25,
                height: 25,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: ElevatedButton(
              onPressed: () {
                context.go('/profile');
              },
              child: Image.asset(
                widget.toggle4
                    ? 'assets/icons/active_profile.png'
                    : 'assets/icons/profile_icon.png',
                width: 25,
                height: 25,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FloatingButtonWidget extends StatefulWidget {
  const FloatingButtonWidget({super.key});

  @override
  State<FloatingButtonWidget> createState() => _FloatingButtonWidgetState();
}

class _FloatingButtonWidgetState extends State<FloatingButtonWidget> {
  @override
  Widget build(BuildContext context) {
    final myColors = Theme.of(context).extension<MyColors>()!;
    return SizedBox(
      width: 70,
      height: 70,
      child: FloatingActionButton(
        onPressed: () {
          context.push('/curate');
        },
        shape: CircleBorder(
          side: BorderSide(width: 4, color: myColors.backgound),
        ),

        child: Icon(Icons.add_rounded, size: 30),
      ),
    );
  }
}
