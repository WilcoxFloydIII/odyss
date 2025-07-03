import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:odyss/core/colors.dart';
import 'package:odyss/core/constraints.dart';
import 'package:odyss/core/providers/list_providers/circles_list.dart';
import 'package:odyss/data/models/circle_model.dart';
import 'package:odyss/screens/error_dialog_widget.dart';

class CreateCircleScreen extends ConsumerWidget {
  const CreateCircleScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final myColors = Theme.of(context).extension<MyColors>()!;
    final allCirclesAsync = ref.watch(CircleListProvider);

    final titleController = TextEditingController();
    final descriptionController = TextEditingController();
    final departureController = TextEditingController();
    final destinationController = TextEditingController();
    final dateRangeController = TextEditingController();
    DateTimeRange? selectedRange;

    Future<void> pickDateRange() async {
      DateTimeRange? result = await showDateRangePicker(
        context: context,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 90)),
        initialDateRange: selectedRange,
      );

      if (result != null) {
        selectedRange = result;
        dateRangeController.text =
            '${DateFormat('yyyy/MM/dd').format(result.start)} -- ${DateFormat('yyyy/MM/dd').format(result.end)}';
      }
    }

    Future<void> createCircle(CircleModel newCircle) async {
      final token = await secureStorage.read(key: 'access_token');
      final response = await http.post(
        Uri.parse(circleUrl),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(newCircle.toJson()),
      );
      if (response.statusCode == 201) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Circle created successfully')));
        if (kDebugMode) {
          print(response.body);
        }
        ref.invalidate(CircleListProvider);
        context.go('/circles');
      } else {
        if (kDebugMode) {
          print(response.body);
        }
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Failed to create circle')));
      }
    }

    if (allCirclesAsync is AsyncLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (allCirclesAsync is AsyncError) {
      return Scaffold(
        body: ErrorDialogWidget(
          error: allCirclesAsync.error.toString(),
          onRetry: () => {},
        ),
      );
    }

    List<CircleModel> allCircles = allCirclesAsync.value ?? [];

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () {
                        context.pop();
                      },
                      icon: Icon(Icons.arrow_back_ios_rounded, size: 30),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Text(
                        'What makes up this circle?',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 50),
                Padding(
                  padding: EdgeInsetsGeometry.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.05,
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        padding: EdgeInsets.only(
                          top: 10,
                          bottom: 0,
                          left: 10,
                          right: 10,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(width: 2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Circle title'),
                            TextFormField(
                              keyboardType: TextInputType.name,
                              controller: titleController,
                              textInputAction: TextInputAction.next,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                              ),
                              decoration: InputDecoration(
                                hintText: 'Name your circle to set the vibe',
                                hintStyle: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                ),
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                contentPadding: EdgeInsets.zero,
                                disabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.width * 0.05,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        padding: EdgeInsets.only(
                          top: 10,
                          bottom: 0,
                          left: 10,
                          right: 10,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(width: 2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Circle description'),
                            TextFormField(
                              keyboardType: TextInputType.text,
                              maxLines: 2,
                              maxLength: 250,
                              controller: descriptionController,
                              textInputAction: TextInputAction.next,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                              ),
                              decoration: InputDecoration(
                                hintText:
                                    'Tell the others who might be interested what kind of circle this is',
                                hintStyle: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                ),
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                contentPadding: EdgeInsets.zero,
                                disabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.width * 0.05,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        padding: EdgeInsets.only(
                          top: 10,
                          bottom: 0,
                          left: 10,
                          right: 10,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(width: 2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Departure city'),
                            TextFormField(
                              readOnly: true,
                              keyboardType: TextInputType.name,
                              controller: departureController,
                              textInputAction: TextInputAction.next,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                              ),
                              decoration: InputDecoration(
                                hintText: 'What city are you currently in?',
                                hintStyle: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                ),
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                contentPadding: EdgeInsets.zero,
                                disabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                              ),
                              onTap: () {
                                showMenu(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadiusGeometry.circular(
                                      20,
                                    ),
                                  ),
                                  context: context,
                                  position: RelativeRect.fromLTRB(
                                    MediaQuery.of(context).size.width * 0.05,
                                    MediaQuery.of(context).size.height * 0.3,
                                    MediaQuery.of(context).size.width * 0.9,
                                    MediaQuery.of(context).size.height * 0.3,
                                  ),
                                  items: [
                                    PopupMenuItem(
                                      child: Text(
                                        'Enugu',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15,
                                        ),
                                      ),
                                      onTap: () {
                                        departureController.text = 'Enugu';
                                      },
                                    ),
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.width * 0.05,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        padding: EdgeInsets.only(
                          top: 10,
                          bottom: 0,
                          left: 10,
                          right: 10,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(width: 2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Destination city'),
                            TextFormField(
                              readOnly: true,
                              keyboardType: TextInputType.name,
                              controller: destinationController,
                              textInputAction: TextInputAction.next,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                              ),
                              decoration: InputDecoration(
                                hintText: 'What city are you heading to?',
                                hintStyle: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                ),
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                contentPadding: EdgeInsets.zero,
                                disabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                              ),
                              onTap: () {
                                showMenu(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadiusGeometry.circular(
                                      20,
                                    ),
                                  ),
                                  context: context,
                                  position: RelativeRect.fromLTRB(
                                    MediaQuery.of(context).size.width * 0.05,
                                    MediaQuery.of(context).size.height * 0.3,
                                    MediaQuery.of(context).size.width * 0.9,
                                    MediaQuery.of(context).size.height * 0.3,
                                  ),
                                  items: [
                                    PopupMenuItem(
                                      child: Text(
                                        'Lagos',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15,
                                        ),
                                      ),
                                      onTap: () {
                                        destinationController.text = 'Lagos';
                                      },
                                    ),
                                    PopupMenuItem(
                                      child: Text(
                                        'Abuja',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15,
                                        ),
                                      ),
                                      onTap: () {
                                        destinationController.text = 'Abuja';
                                      },
                                    ),
                                    PopupMenuItem(
                                      child: Text(
                                        'Rivers',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15,
                                        ),
                                      ),
                                      onTap: () {
                                        destinationController.text = 'Rivers';
                                      },
                                    ),
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.width * 0.05,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        padding: EdgeInsets.only(
                          top: 10,
                          bottom: 0,
                          left: 10,
                          right: 10,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(width: 2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Date Range'),
                            TextFormField(
                              keyboardType: TextInputType.name,
                              readOnly: true,
                              controller: dateRangeController,
                              textInputAction: TextInputAction.next,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                              ),
                              decoration: InputDecoration(
                                hintText: 'Enter date range',
                                hintStyle: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                ),
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                contentPadding: EdgeInsets.zero,
                                disabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                              ),
                              onTap: () {
                                pickDateRange();
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 50),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(
                            width: 130,
                            child: ElevatedButton(
                              onPressed: () {
                                if (titleController.text.isEmpty ||
                                    titleController.text.length < 3) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      duration: Duration(seconds: 2),
                                      backgroundColor: myColors.backgound,
                                      content: Text(
                                        'Title should not be less than three letters',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  );
                                } else if (descriptionController.text.isEmpty ||
                                    descriptionController.text.length < 10) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      duration: Duration(seconds: 2),
                                      backgroundColor: myColors.backgound,
                                      content: Text(
                                        'Description should not be less than ten letters',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  );
                                } else if (departureController.text.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      duration: Duration(seconds: 2),
                                      backgroundColor: myColors.backgound,
                                      content: Text(
                                        'You must select a departure city',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  );
                                } else if (destinationController.text.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      duration: Duration(seconds: 2),
                                      backgroundColor: myColors.backgound,
                                      content: Text(
                                        'You must select a destination city',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  );
                                } else if (dateRangeController.text.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      duration: Duration(seconds: 2),
                                      backgroundColor: myColors.backgound,
                                      content: Text(
                                        'You must select a date range',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  );
                                } else {
                                  // ignore: unused_local_variable
                                  CircleModel newCircle = CircleModel(
                                    id: allCircles.length.toString(),
                                    name: titleController.text,
                                    description: descriptionController.text,
                                    departure: departureController.text,
                                    destination: destinationController.text,
                                    startDate: selectedRange!.start,
                                    endDate: selectedRange!.end,
                                    users: [UID],
                                  );
                                  createCircle(newCircle);
                                }
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Post', style: TextStyle(fontSize: 15)),
                                  SizedBox(width: 10),
                                  Icon(Icons.arrow_forward_rounded, size: 20),
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
          ),
        ),
      ),
    );
  }
}
