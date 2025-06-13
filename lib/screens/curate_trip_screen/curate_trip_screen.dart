import 'package:flutter/material.dart';

class CurateTripScreen extends StatefulWidget {
  const CurateTripScreen({super.key});

  @override
  State<CurateTripScreen> createState() => _CurateTripScreenState();
}

class _CurateTripScreenState extends State<CurateTripScreen> {
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
        padding: EdgeInsets.fromLTRB(
          MediaQuery.of(context).size.width * 0.05,
          MediaQuery.of(context).size.height * 0.2,
          MediaQuery.of(context).size.width * 0.05,
          0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset('assets/icons/curate_icon.png', width: 150),
            SizedBox(height: 30),
            Text(
              'Curate a Trip That Feels Like You',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.05,),
              child: Text(
                "Let's help you create a ride where everyone's on the same vibe - it only takes a few steps!.",
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(height: 50),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      'Get curating',
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
