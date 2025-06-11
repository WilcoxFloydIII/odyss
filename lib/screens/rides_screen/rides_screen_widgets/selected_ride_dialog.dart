import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:odyss/core/colors.dart';

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
  });

  final String depLoc;
  final String arrLoc;
  final DateTime initDate;
  final DateTime finalDate;
  final String company;
  final int seats;
  final String vehicle;
  final int days;
  final List members;

  @override
  State<SelectedRideDialog> createState() => _SelectedRideDialogState();
}

class _SelectedRideDialogState extends State<SelectedRideDialog> {
  @override
  Widget build(BuildContext context) {
    final myColors = Theme.of(context).extension<MyColors>()!;
    return Scaffold(
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
        ),
      ),
    );
  }
}
