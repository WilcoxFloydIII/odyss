import 'package:flutter/material.dart';
import 'package:odyss/core/colors.dart';
import 'package:odyss/core/constraints.dart';

class VibeButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;

  const VibeButton({Key? key, required this.text, this.onPressed})
    : super(key: key);

  @override
  State<VibeButton> createState() => _VibeButtonState();
}

class _VibeButtonState extends State<VibeButton> {
  bool _isSelected = false;

  void _toggleSelection() {
    setState(() {
      _isSelected = !_isSelected;
    });

    if (widget.onPressed != null) {
      widget.onPressed!();
    }

    final vibes = newUser['vibes'] ?? [];

    if (vibes.contains(widget.text)) {
      vibes.remove(widget.text);
    } else {
      vibes.add(widget.text);
    }

    newUser['vibes'] = vibes; // ✅ Update the map after change

    print(newUser['vibes']);
  }

  @override
  Widget build(BuildContext context) {
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
      onPressed: _toggleSelection,
      child: Text(widget.text),
    );
  }
}
