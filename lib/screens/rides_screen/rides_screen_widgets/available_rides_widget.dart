import 'package:flutter/material.dart';

class AvailableRidesWidget extends StatefulWidget {
  const AvailableRidesWidget({super.key});

  @override
  State<AvailableRidesWidget> createState() => _AvailableRidesWidgetState();
}

class _AvailableRidesWidgetState extends State<AvailableRidesWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 2,
      itemBuilder: (context, index) {
        return Container(
          color: Colors.red,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.05),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 200,
                      child: Row(children: [Container(), Text('no')]),
                    ),
                    ElevatedButton(
                      onPressed: () {}, 
                      style: ButtonStyle(
                        padding: WidgetStatePropertyAll(EdgeInsets.symmetric(vertical: 10, horizontal: 20)),
                        textStyle: WidgetStatePropertyAll(TextStyle(fontWeight: FontWeight.w400, fontSize: 15))
                      ),
                      child: Text('Join trip')
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
