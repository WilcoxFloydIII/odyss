import 'package:flutter/material.dart';

class MakePaymentWidget extends StatefulWidget {
  const MakePaymentWidget({super.key});

  @override
  State<MakePaymentWidget> createState() => _MakePaymentWidgetState();
}

class _MakePaymentWidgetState extends State<MakePaymentWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios_new_rounded),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width*0.05, MediaQuery.of(context).size.height*0.2, MediaQuery.of(context).size.width*0.05, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset('assets/icons/make_payment_icon.png', width: 150),
            SizedBox(height: 30,),
            Text('Almost done!!!', style: TextStyle(fontSize: 20)),
            Text(
              'Book trip to confirm your travel and get in touch with your travel buddies.',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 50,),
            Row(
              children: [
                Expanded(child: ElevatedButton(onPressed: () {}, child: Text('Make payment', style: TextStyle(fontWeight: FontWeight.w700),)))
              ],
            )
          ],
        ),
      ),
    );
  }
}
