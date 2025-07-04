import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:odyss/core/colors.dart';
import 'package:odyss/core/constraints.dart';
import 'package:odyss/core/providers/list_providers/ride_list_provider.dart';
import 'package:odyss/core/providers/list_providers/user_list_provider.dart';
import 'package:odyss/data/models/ride_model.dart';
import 'package:odyss/data/models/user_model.dart';
import 'package:odyss/screens/rides_screen/rides_screen_widgets/almost_done_screen.dart';

class SelectedRideDialog extends ConsumerStatefulWidget {
  const SelectedRideDialog({super.key, required this.rideId});

  final String rideId;

  @override
  ConsumerState<SelectedRideDialog> createState() => _SelectedRideDialogState();
}

class _SelectedRideDialogState extends ConsumerState<SelectedRideDialog> {
  bool splitCost = true;
  bool offlineFill = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    ref.refresh(userListProvider);
    ref.refresh(ridesListProvider);
  }

  @override
  Widget build(BuildContext context) {
    final myColors = Theme.of(context).extension<MyColors>()!;

    final userListAsync = ref.watch(userListProvider);
    final ridesListAsync = ref.watch(ridesListProvider);

    if (userListAsync is AsyncLoading || ridesListAsync is AsyncLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (userListAsync is AsyncError) {
      return Scaffold(
        body: Center(
          child: Text('Failed to load user data: ${userListAsync.error}'),
        ),
      );
    }

    if (ridesListAsync is AsyncError) {
      return Scaffold(
        body: Center(
          child: Text('Failed to load rides data: ${ridesListAsync.error}'),
        ),
      );
    }

    List<UserModel> allUsers = userListAsync.value ?? [];
    List<RideModel> allRides = ridesListAsync.value ?? [];
    RideModel ride = allRides.firstWhere((ride) => ride.id == widget.rideId);
    List<UserModel> members = allUsers
        .where((user) => ride.memberIds.contains(user.id))
        .toList();
    bool isMember = members.any((member) => member.id == UID);

    ride.fill ? splitCost = false : splitCost = true;
    ride.fill ? offlineFill = true : offlineFill = false;

    return Scaffold(
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
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                  height: 70,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
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
                                fontSize: 6,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            Text(
                              '|',
                              style: TextStyle(
                                fontSize: 6,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            Text(
                              '|',
                              style: TextStyle(
                                fontSize: 6,
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
                                  ride.departureLoc,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  '${DateFormat('dd').format(ride.departureDate)} ${DateFormat.MMM().format(ride.departureDate)}, ${DateFormat.Hm().format(ride.departureDate)} ${DateFormat('a').format(ride.departureDate)}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 27),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  ride.arrivalLoc,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  '${DateFormat('dd').format(ride.arrivalDate)} ${DateFormat.MMM().format(ride.arrivalDate)}, ${DateFormat.Hm().format(ride.arrivalDate)} ${DateFormat('a').format(ride.arrivalDate)}',
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
        child: SizedBox(
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
                      height: (((40 + 14) * members.length) + 50),
                      color: myColors.backgound,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          ...List.generate(members.length, (indexnew) {
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
                                      child: GestureDetector(
                                        onTap: () {
                                          context.push(
                                            '/profile/${members[indexnew].id}',
                                          );
                                        },
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
                                                image: DecorationImage(
                                                  image: NetworkImage(
                                                    members[indexnew].picture,
                                                  ),
                                                  fit: BoxFit.cover,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                            Text(
                                              '${members[indexnew].firstName} ${members[indexnew].lastName} ',
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
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
                      onTap: null,
                      contentPadding: EdgeInsets.all(0),
                      leading: Text('Split the Remaining Cost'),
                      trailing: splitCost ? Icon(Icons.check) : null,
                    ),
                    ListTile(
                      onTap: null,
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
                    SizedBox(
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
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
                                  ride.company,
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
                                  text: ride.vehicle,
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
                                '₦${ride.price.toString()}',
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
                                '${(ride.seats - members.length).toString()} seats',
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
                                '${ride.departureDate.day - DateTime.now().day} days',
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
                          if (ride.memberIds.length >= ride.seats) {
                            Flushbar(
                              message: 'You are already a member of this trip',
                              duration: Duration(seconds: 2),
                              flushbarPosition:
                                  FlushbarPosition.TOP, // Top of screen
                              backgroundColor:
                                  Colors.redAccent, // Optional: customize color
                              margin: EdgeInsets.all(
                                8,
                              ), // Optional: margin for better look
                              borderRadius: BorderRadius.circular(
                                8,
                              ), // Optional: rounded corners
                            ).show(context);
                          } else {
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
                                        (
                                          context,
                                          animation,
                                          secondaryAnimation,
                                        ) {
                                          return AlmostDoneScreen();
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
                          }
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
              SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
