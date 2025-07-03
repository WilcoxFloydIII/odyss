import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:odyss/core/colors.dart';
import 'package:odyss/core/constraints.dart';
import 'package:odyss/core/providers/list_providers/circles_list.dart';
import 'package:odyss/data/models/circle_model.dart';
import 'package:odyss/screens/bottom_app_bar.dart';
import 'package:odyss/screens/error_dialog_widget.dart';
import 'package:odyss/screens/loading_animation_widget.dart';

class CirclesScreen extends ConsumerStatefulWidget {
  const CirclesScreen({super.key});

  @override
  ConsumerState<CirclesScreen> createState() => _CirclesScreenState();
}

class _CirclesScreenState extends ConsumerState<CirclesScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Refresh the circles provider every time the page is opened
    ref.refresh(CircleListProvider);
  }

  Future<Map<String, dynamic>> joinCircle({required String circleId}) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const LoadingAnimationWidget(),
    );
    try {
      final token = await secureStorage.read(key: 'access_token');
      final url = Uri.parse('$circleUrl/$circleId/join');
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
      Navigator.pop(context); // Remove loading
      if (response.statusCode == 200) {
        context.push('/circle/$circleId');
        return jsonDecode(response.body) as Map<String, dynamic>;
      } else {
        showDialog(
          context: context,
          builder: (_) => ErrorDialogWidget(error: 'Failed to join circle'),
        );
        throw Exception('Failed to join circle: ${response.body}');
      }
    } catch (e) {
      Navigator.pop(context); // Remove loading
      showDialog(
        context: context,
        builder: (_) => ErrorDialogWidget(error: 'Failed to join circle'),
      );
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    final myColors = Theme.of(context).extension<MyColors>()!;

    final allCirclesAsync = ref.watch(CircleListProvider);

    if (allCirclesAsync is AsyncLoading) {
      return Scaffold(
        body: Center(child: LoadingAnimationWidget()),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingButtonWidget(),
        bottomNavigationBar: ClipRRect(
          borderRadius: BorderRadiusGeometry.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
          child: BottomAppBarWidget(
            toggle1: true,
            toggle2: false,
            toggle3: false,
            toggle4: false,
          ),
        ),
      );
    }

    if (allCirclesAsync is AsyncError) {
      return Scaffold(
        body: ErrorDialogWidget(
          error: allCirclesAsync.error.toString(),
          onRetry: () => setState(() {}),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingButtonWidget(),
        bottomNavigationBar: ClipRRect(
          borderRadius: BorderRadiusGeometry.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
          child: BottomAppBarWidget(
            toggle1: true,
            toggle2: false,
            toggle3: false,
            toggle4: false,
          ),
        ),
      );
    }

    List<CircleModel> allCircles = allCirclesAsync.value ?? [];

    List<CircleModel> memberCircles = allCircles
        .where((circle) => circle.users.contains(UID))
        .toList();

    List<CircleModel> filteredAllCircles = allCircles
        .where((circle) => !circle.users.contains(UID))
        .toList();

    return Scaffold(
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.14,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Circles',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Container(
                          width: 130,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: () {},
                                child: Image.asset(
                                  'assets/images/bell_icon.png',
                                  width: 27,
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  context.push('/createCircle');
                                },
                                style: ButtonStyle(
                                  shape: WidgetStatePropertyAll(CircleBorder()),
                                  padding: WidgetStatePropertyAll(
                                    EdgeInsets.all(13),
                                  ),
                                ),
                                child: Icon(Icons.add, size: 20),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: (MediaQuery.of(context).size.width * 0.9) - 130,
                      child: Text(
                        'Curate public circles for people with the same trip interests',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                color: myColors.backgound,
                height:
                    MediaQuery.of(context).size.height * 0.8 -
                    (MediaQuery.of(context).size.height * 0.1 +
                        MediaQuery.of(context).size.width * 0.17),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height:
                            (((125 + MediaQuery.of(context).size.width * 0.05) *
                                memberCircles.length) +
                            50),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Circles I'm in",
                              style: TextStyle(fontSize: 15),
                            ),
                            SizedBox(height: 10),
                            Container(
                              height:
                                  (125 +
                                      MediaQuery.of(context).size.width *
                                          0.05) *
                                  memberCircles.length,
                              child: ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: memberCircles.length,
                                itemBuilder: (context, index) {
                                  CircleModel circle = memberCircles[index];
                                  DateTime start = circle.startDate;
                                  DateTime end = circle.endDate;
                                  isMemberEmpty() {
                                    if (memberCircles.isEmpty) {
                                      return Text(
                                        'No active circles',
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.grey.shade600,
                                        ),
                                      );
                                    } else {
                                      return Padding(
                                        padding: EdgeInsets.only(
                                          bottom:
                                              MediaQuery.of(
                                                context,
                                              ).size.width *
                                              0.05,
                                        ),
                                        child: Container(
                                          width: double.infinity,
                                          padding: EdgeInsets.fromLTRB(
                                            15,
                                            15,
                                            10,
                                            15,
                                          ),
                                          height: 125,
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade100,
                                            borderRadius: BorderRadius.circular(
                                              30,
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                width: 65,
                                                height: 65,
                                                child: Stack(
                                                  children: [
                                                    Positioned(
                                                      left: 0,
                                                      top: 17.5,
                                                      child: Container(
                                                        height: 35,
                                                        width: 35,
                                                        decoration: BoxDecoration(
                                                          color: Colors
                                                              .grey
                                                              .shade300,
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                20,
                                                              ),
                                                        ),
                                                      ),
                                                    ),
                                                    Positioned(
                                                      left: 17.5,
                                                      top: 27.5,
                                                      child: Container(
                                                        height: 35,
                                                        width: 35,
                                                        decoration: BoxDecoration(
                                                          color: Colors
                                                              .grey
                                                              .shade300,
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                20,
                                                              ),
                                                        ),
                                                      ),
                                                    ),
                                                    Positioned(
                                                      left: 17.5,
                                                      top: 7.5,
                                                      child: Container(
                                                        height: 35,
                                                        width: 35,
                                                        decoration: BoxDecoration(
                                                          color: Colors
                                                              .grey
                                                              .shade300,
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                20,
                                                              ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    '${circle.departure} - ${circle.destination}',
                                                    style: TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                  SizedBox(height: 10),
                                                  Container(
                                                    width:
                                                        MediaQuery.of(
                                                          context,
                                                        ).size.width *
                                                        0.5,
                                                    child: Text(
                                                      circle.name,
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(height: 10),
                                                  Text(
                                                    '${start.day} ${DateFormat.MMM().format(start)} ${start.year} - ${end.day} ${DateFormat.MMM().format(end)} ${end.year}',
                                                    style: TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  context.push(
                                                    '/circle/${circle.id}',
                                                  );
                                                },
                                                child: Text(
                                                  'View',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    }
                                  }

                                  return isMemberEmpty();
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height:
                            (((125 + MediaQuery.of(context).size.width * 0.05) *
                                filteredAllCircles.length) +
                            50),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('All Circles', style: TextStyle(fontSize: 15)),
                            SizedBox(height: 10),
                            Container(
                              height:
                                  (125 +
                                      MediaQuery.of(context).size.width *
                                          0.05) *
                                  filteredAllCircles.length,
                              child: ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: filteredAllCircles.length,
                                itemBuilder: (context, index) {
                                  CircleModel circle =
                                      filteredAllCircles[index];
                                  DateTime start = circle.startDate;
                                  DateTime end = circle.endDate;
                                  return Padding(
                                    padding: EdgeInsets.only(
                                      bottom:
                                          MediaQuery.of(context).size.width *
                                          0.05,
                                    ),
                                    child: Container(
                                      width: double.infinity,
                                      padding: EdgeInsets.fromLTRB(
                                        15,
                                        15,
                                        10,
                                        15,
                                      ),
                                      height: 125,
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade100,
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: 65,
                                            height: 65,
                                            child: Stack(
                                              children: [
                                                Positioned(
                                                  left: 0,
                                                  top: 17.5,
                                                  child: Container(
                                                    height: 35,
                                                    width: 35,
                                                    decoration: BoxDecoration(
                                                      color:
                                                          Colors.grey.shade300,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            20,
                                                          ),
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  left: 17.5,
                                                  top: 27.5,
                                                  child: Container(
                                                    height: 35,
                                                    width: 35,
                                                    decoration: BoxDecoration(
                                                      color:
                                                          Colors.grey.shade300,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            20,
                                                          ),
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  left: 17.5,
                                                  top: 7.5,
                                                  child: Container(
                                                    height: 35,
                                                    width: 35,
                                                    decoration: BoxDecoration(
                                                      color:
                                                          Colors.grey.shade300,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            20,
                                                          ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                '${circle.departure} - ${circle.destination}',
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              SizedBox(height: 10),
                                              Container(
                                                width:
                                                    MediaQuery.of(
                                                      context,
                                                    ).size.width *
                                                    0.5,
                                                child: Text(
                                                  circle.name,
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 10),
                                              Text(
                                                '${start.day} ${DateFormat.MMM().format(start)} ${start.year} - ${end.day} ${DateFormat.MMM().format(end)} ${end.year}',
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              joinCircle(circleId: circle.id);
                                            },
                                            child: Text(
                                              'Join',
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingButtonWidget(),
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadiusGeometry.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
        child: BottomAppBarWidget(
          toggle1: true,
          toggle2: false,
          toggle3: false,
          toggle4: false,
        ),
      ),
    );
  }
}
