import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:odyss/core/colors.dart';
import 'package:odyss/core/constraints.dart';
import 'package:odyss/screens/curate_trip_screen/curate_trip_widgets/trip_vibe_button.dart';

class TripVibeScreen extends StatefulWidget {
  const TripVibeScreen({super.key});

  @override
  State<TripVibeScreen> createState() => _TripVibeScreenState();
}

class _TripVibeScreenState extends State<TripVibeScreen> {
  @override
  Widget build(BuildContext context) {
    final myColors = Theme.of(context).extension<MyColors>()!;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          excludeHeaderSemantics: true,
          toolbarHeight: 5,
          titleSpacing: 0,
          leadingWidth: 0,
          title: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(5),
            child: Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Container(
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(width: 5),
                Expanded(
                  flex: 4,
                  child: Container(
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(width: 5),
                Expanded(
                  flex: 4,
                  child: Container(
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(width: 5),
                Expanded(
                  flex: 4,
                  child: Container(
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 50),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          IconButton(
                            onPressed: () {
                              newRide['vibes'] = [];
                              context.pop();
                            },
                            icon: Icon(Icons.arrow_back_ios_rounded, size: 30),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.87,
                            child: Text(
                              overflow: TextOverflow.clip,
                              "Set the trip vibe",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 50),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 600,
                        padding: EdgeInsets.all(
                          MediaQuery.sizeOf(context).width * 0.05,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              child: Wrap(
                                spacing: 10,
                                runSpacing: 10,
                                alignment: WrapAlignment.center,
                                children: [
                                  TripVibeButton(text: 'Full Vibes Trip'),
                                  TripVibeButton(text: 'Strictly No Noise'),
                                  TripVibeButton(text: 'Afrobeats All the Way'),
                                  TripVibeButton(text: 'Chill and Quiet'),
                                  TripVibeButton(
                                    text: 'Playlist & Conversations',
                                  ),
                                  TripVibeButton(text: 'Open to Chatting'),
                                  TripVibeButton(
                                    text: 'Leave on Time, No Delay',
                                  ),
                                  TripVibeButton(text: 'Open to New Friends'),
                                  TripVibeButton(text: 'Peaceful & Calm'),
                                  TripVibeButton(text: 'Purposeful Movement'),
                                  TripVibeButton(text: 'Event-Prep Energy'),
                                  TripVibeButton(text: 'Sleep & Go'),
                                  TripVibeButton(text: 'Just Cool People'),
                                  TripVibeButton(text: 'We Move Regardless'),
                                  TripVibeButton(text: 'One Stop, One Goal'),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                SizedBox(
                                  width: 130,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      if (newRide['vibes'].isEmpty) {
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(
                                            duration: Duration(seconds: 2),
                                            backgroundColor: myColors.backgound,
                                            content: Text(
                                              textAlign: TextAlign.center,
                                              'Pick a vibe to continue',
                                              style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.red,
                                              ),
                                            ),
                                          ),
                                        );
                                      } else {
                                        context.push('/pricing');
                                      }
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Next',
                                          style: TextStyle(fontSize: 15),
                                        ),
                                        SizedBox(width: 10),
                                        Icon(
                                          Icons.arrow_forward_rounded,
                                          size: 20,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
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
