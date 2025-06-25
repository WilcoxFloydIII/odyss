import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:odyss/core/colors.dart';
import 'package:odyss/core/constraints.dart';
import 'package:odyss/core/providers/circles_list.dart';
import 'package:odyss/data/models/circle_model.dart';

class CreateCircleScreen extends ConsumerStatefulWidget {
  const CreateCircleScreen({super.key});

  @override
  ConsumerState<CreateCircleScreen> createState() => _CreateCircleScreenState();
}

class _CreateCircleScreenState extends ConsumerState<CreateCircleScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController departureController = TextEditingController();
  TextEditingController destinationController = TextEditingController();
  TextEditingController dateRangeController = TextEditingController();

  final GlobalKey _departureKey = GlobalKey();
  final GlobalKey _destinationKey = GlobalKey();

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

  @override
  Widget build(BuildContext context) {
    List<CircleModel> allCircles = ref.watch(CircleListProvider);

    final myColors = Theme.of(context).extension<MyColors>()!;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Container(
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
                    Container(
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
                              key: _departureKey,
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
                                setState(() {
                                  final RenderBox button =
                                      _departureKey.currentContext!
                                              .findRenderObject()
                                          as RenderBox;
                                  final RenderBox overlay =
                                      Overlay.of(
                                            context,
                                          ).context.findRenderObject()
                                          as RenderBox;

                                  final Offset position = button.localToGlobal(
                                    Offset.zero,
                                    ancestor: overlay,
                                  );

                                  showMenu(
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadiusGeometry.circular(20),
                                    ),
                                    context: context,
                                    position: RelativeRect.fromLTRB(
                                      position.dx,
                                      position.dy +
                                          button.size.height, // show just below
                                      position.dx + button.size.width,
                                      position.dy,
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
                                          setState(() {
                                            departureController.text = 'Enugu';
                                          });
                                        },
                                      ),
                                    ],
                                  );
                                });
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
                              key: _destinationKey,
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
                                setState(() {
                                  final RenderBox button =
                                      _destinationKey.currentContext!
                                              .findRenderObject()
                                          as RenderBox;
                                  final RenderBox overlay =
                                      Overlay.of(
                                            context,
                                          ).context.findRenderObject()
                                          as RenderBox;

                                  final Offset position = button.localToGlobal(
                                    Offset.zero,
                                    ancestor: overlay,
                                  );

                                  showMenu(
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadiusGeometry.circular(20),
                                    ),
                                    context: context,
                                    position: RelativeRect.fromLTRB(
                                      position.dx,
                                      position.dy +
                                          button.size.height, // show just below
                                      position.dx + button.size.width,
                                      position.dy,
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
                                          setState(() {
                                            destinationController.text =
                                                'Lagos';
                                          });
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
                                          setState(() {
                                            destinationController.text =
                                                'Abuja';
                                          });
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
                                          setState(() {
                                            destinationController.text =
                                                'Rivers';
                                          });
                                        },
                                      ),
                                    ],
                                  );
                                });
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
                          Container(
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
                                  ref
                                      .read(CircleListProvider.notifier)
                                      .addCircle(newCircle);
                                  context.go('/circles');
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
