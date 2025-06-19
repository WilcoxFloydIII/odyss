import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:odyss/core/colors.dart';
import 'package:odyss/core/constraints.dart';
import 'package:odyss/data/models/user_model.dart';
import 'package:odyss/screens/rides_screen/rides_screen_widgets/make_payment_widget.dart';

class SelectedRideDialog extends StatefulWidget {
  const SelectedRideDialog({
    super.key,
    required this.arrLoc,
    required this.company,
    required this.days,
    required this.depLoc,
    required this.finalDate,
    required this.initDate,
    required this.members,
    required this.seats,
    required this.vehicle,
    required this.price,
  });

  final String depLoc;
  final String arrLoc;
  final DateTime initDate;
  final DateTime finalDate;
  final String company;
  final int seats;
  final String vehicle;
  final int days;
  final List<UserModel> members;
  final int price;

  @override
  State<SelectedRideDialog> createState() => _SelectedRideDialogState();
}

class _SelectedRideDialogState extends State<SelectedRideDialog> {
  bool splitCost = true;
  bool offlineFill = false;

  @override
  Widget build(BuildContext context) {
    final myColors = Theme.of(context).extension<MyColors>()!;
    bool isMember = widget.members.any((members) => members.id == UID);
    return Material(
      child: Scaffold(
        backgroundColor: myColors.backgound,
        extendBodyBehindAppBar: false,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(170),
          child: SafeArea(
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.width * 0.05,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 10,
                    offset: Offset(0, 10),
                    color: Colors.black12,
                  ),
                ],
                color: myColors.backgound,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                        onPressed: () => context.pop('/rides'),
                        icon: Icon(Icons.arrow_back_ios_new_rounded),
                      ),
                      Text(
                        'Selected Ride',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.05,
                    ),
                    height: 65,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(Icons.circle, size: 13),
                              Text(
                                '|',
                                style: TextStyle(
                                  fontSize: 7,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              Text(
                                '|',
                                style: TextStyle(
                                  fontSize: 7,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              Icon(Icons.location_on_rounded),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 15,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    widget.depLoc,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    '${DateFormat('dd').format(widget.initDate)} ${DateFormat.MMM().format(widget.initDate)}, ${DateFormat.Hm().format(widget.initDate)} ${DateFormat('a').format(widget.initDate)}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 23),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    widget.arrLoc,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    '${DateFormat('dd').format(widget.finalDate)} ${DateFormat.MMM().format(widget.finalDate)}, ${DateFormat.Hm().format(widget.finalDate)} ${DateFormat('a').format(widget.finalDate)}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
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
                ],
              ),
            ),
          ),
        ),
        body: SafeArea(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - 170,
            child: ListView(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(
                    MediaQuery.of(context).size.width * 0.05,
                  ),
                  decoration: BoxDecoration(
                    border: BoxBorder.fromLTRB(
                      bottom: BorderSide(width: 1, color: Colors.black26),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Travel buddies', style: TextStyle(fontSize: 15)),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: (((40 + 14) * widget.members.length) + 50),
                        color: myColors.backgound,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            ...List.generate(widget.members.length, (indexnew) {
                              return Container(
                                width: MediaQuery.of(context).size.width * 0.9,
                                color: myColors.backgound,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 7,
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 250,
                                        color: myColors.backgound,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: 40,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  width: 2,
                                                  color: Colors.black,
                                                ),
                                                color: Colors.grey.shade300,
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                            Text(
                                              '${widget.members[indexnew].firstName} ${widget.members[indexnew].lastName} ',
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                            ElevatedButton(
                              onPressed: () {},
                              style: ButtonStyle(
                                padding: WidgetStatePropertyAll(
                                  EdgeInsets.symmetric(
                                    vertical: 0,
                                    horizontal: 20,
                                  ),
                                ),
                                backgroundColor: WidgetStateColor.resolveWith((
                                  states,
                                ) {
                                  if (states.contains(WidgetState.pressed)) {
                                    return myColors.primary;
                                  }
                                  return Colors.transparent;
                                }),
                                foregroundColor: WidgetStateColor.resolveWith((
                                  states,
                                ) {
                                  if (states.contains(WidgetState.pressed)) {
                                    return myColors.backgound;
                                  }
                                  return myColors.primary;
                                }),
                                shadowColor: WidgetStatePropertyAll(
                                  Colors.transparent,
                                ),
                                side: WidgetStatePropertyAll(
                                  BorderSide(width: 2, color: myColors.primary),
                                ),
                              ),
                              child: Text(
                                'Invite others',
                                style: TextStyle(fontSize: 10),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(
                    MediaQuery.of(context).size.width * 0.05,
                  ),
                  decoration: BoxDecoration(
                    border: BoxBorder.fromLTRB(
                      bottom: BorderSide(width: 1, color: Colors.black26),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Smart Fill Policy', style: TextStyle(fontSize: 15)),
                      ListTile(
                        onTap: () {
                          setState(() {
                            splitCost = !splitCost;
                            offlineFill = !offlineFill;
                          });
                        },
                        contentPadding: EdgeInsets.all(0),
                        leading: Text('Split the Remaining Cost'),
                        trailing: splitCost ? Icon(Icons.check) : null,
                      ),
                      ListTile(
                        onTap: () {
                          setState(() {
                                  offlineFill = !offlineFill;
                                  splitCost = !splitCost;
                                });
                        },
                        contentPadding: EdgeInsets.all(0),
                        leading: Text('Allow Offline Fill-in'),
                        trailing: offlineFill ? Icon(Icons.check) : null,
                      ),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(
                    MediaQuery.of(context).size.width * 0.05,
                  ),
                  decoration: BoxDecoration(
                    border: BoxBorder.fromLTRB(
                      bottom: BorderSide(width: 1, color: Colors.black26),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Refund Eligibility', style: TextStyle(fontSize: 15)),
                      SizedBox(height: 10),
                      ListTile(
                        leading: Icon(Icons.circle, size: 5),
                        titleAlignment: ListTileTitleAlignment.titleHeight,
                        contentPadding: EdgeInsets.all(0),
                        horizontalTitleGap: 0,
                        title: Text(
                          'You are eligible for a full refund if you cancel your booking at least 3 days (72 hours) before the scheduled trip date.',
                          style: TextStyle(fontSize: 10),
                        ),
                      ),
                      ListTile(
                        leading: Icon(Icons.circle, size: 5),
                        titleAlignment: ListTileTitleAlignment.titleHeight,
                        contentPadding: EdgeInsets.all(0),
                        minVerticalPadding: 0,
                        horizontalTitleGap: 0,
                        title: Text(
                          'Refunds will be processed within 5-7 business days to your original payment method.',
                          style: TextStyle(fontSize: 10),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(
                    MediaQuery.of(context).size.width * 0.05,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 200,
                              child: Row(
                                children: [
                                  Container(
                                    height: 25,
                                    width: 25,
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade300,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                  SizedBox(width: 3),
                                  Text(
                                    widget.company,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text.rich(
                              TextSpan(
                                text: 'Vehicle: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                ),
                                children: [
                                  TextSpan(
                                    text: widget.vehicle,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '₦${widget.price.toString()}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  'per seat',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 5,
                            child: Column(
                              children: [
                                Text(
                                  '${(widget.seats - widget.members.length).toString()} seats',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  'available',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  '${widget.days.toString()} days',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  'left to trip',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.05,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            isMember
                                ? Flushbar(
                                    message:
                                        'You are already a member of this trip',
                                    duration: Duration(seconds: 2),
                                    flushbarPosition:
                                        FlushbarPosition.TOP, // Top of screen
                                    backgroundColor: Colors
                                        .redAccent, // Optional: customize color
                                    margin: EdgeInsets.all(
                                      8,
                                    ), // Optional: margin for better look
                                    borderRadius: BorderRadius.circular(
                                      8,
                                    ), // Optional: rounded corners
                                  ).show(context)
                                : showGeneralDialog(
                                    context: context,
                                    barrierDismissible: true,
                                    barrierLabel: 'Dialog',
                                    transitionDuration: const Duration(
                                      milliseconds: 300,
                                    ),
                                    pageBuilder:
                                        (context, animation, secondaryAnimation) {
                                          return MakePaymentWidget();
                                        },
                                    transitionBuilder:
                                        (
                                          context,
                                          animation,
                                          secondaryAnimation,
                                          child,
                                        ) {
                                          const begin = Offset(
                                            1.0,
                                            0.0,
                                          ); // Slide in from right
                                          const end = Offset.zero;
                                          const curve = Curves.ease;
      
                                          final tween = Tween(
                                            begin: begin,
                                            end: end,
                                          ).chain(CurveTween(curve: curve));
      
                                          return SlideTransition(
                                            position: animation.drive(tween),
                                            child: child,
                                          );
                                        },
                                  );
                          },
                          style: ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll(
                              isMember
                                  ? Colors.blueGrey.shade400
                                  : myColors.primary,
                            ),
                          ),
                          child: Text('Join Trip'),
                        ),
                        
                      ),
                      
                    ],
                  ),
                ),
                SizedBox(height: 40,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
