import 'package:flutter/material.dart';
import 'package:odyss/core/colors.dart';
import 'package:odyss/core/constraints.dart';

class TripVibeButton extends StatefulWidget {
  final String text;

  const TripVibeButton({super.key, required this.text});

  @override
  State<TripVibeButton> createState() => _TripVibeButtonState();
}

class _TripVibeButtonState extends State<TripVibeButton> {
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    void toggleSelection() {
      setState(() {
        _isSelected = !_isSelected;
      });

      if (newRide['vibes'].contains(widget.text)) {
        newRide['vibes'].remove(widget.text);
      } else {
        newRide['vibes'].add(widget.text);
      }

      print(newRide['vibes']);
      print(newRide['destLoc']);
    }

    final myColors = Theme.of(context).extension<MyColors>()!;
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        backgroundColor: _isSelected ? myColors.primary : Colors.transparent,
        side: BorderSide(color: myColors.primary, width: 2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        foregroundColor: _isSelected ? myColors.backgound : myColors.primary,
        textStyle: TextStyle(fontSize: 15),
      ),
      onPressed: () {
        print('pressed');
        toggleSelection();
      },
      child: Text(widget.text),
    );
  }
}
