import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ErrorDialogWidget extends StatefulWidget {
  const ErrorDialogWidget({super.key, required this.error});

  final String error;

  @override
  State<ErrorDialogWidget> createState() => _ErrorDialogWidgetState();
}

class _ErrorDialogWidgetState extends State<ErrorDialogWidget> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Center(
        child: Material(
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(width: 2, color: Colors.black),
              borderRadius: BorderRadius.circular(20),
            ),
            width: MediaQuery.of(context).size.width * 0.8,
            height: 200,
            padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.1),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.error,
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
                  ),
                  SizedBox(height: 20,),
                  TextButton(
                    onPressed: () => context.pop(),
                    child: Text('Close', style: TextStyle(fontWeight: FontWeight.w700),),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
