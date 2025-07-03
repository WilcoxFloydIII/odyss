import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:odyss/core/colors.dart';
import 'package:odyss/core/providers/list_providers/bookings_list_provider.dart';
import 'package:odyss/core/providers/list_providers/circles_list.dart';
import 'package:odyss/core/providers/list_providers/company_list_provider.dart';
import 'package:odyss/core/providers/list_providers/ride_list_provider.dart';
import 'package:odyss/core/providers/list_providers/route_list_provider.dart';
import 'package:odyss/core/providers/list_providers/user_list_provider.dart';
import 'package:odyss/data/models/circle_model.dart';
import 'package:odyss/data/models/ride_model.dart';
import 'package:odyss/data/models/user_model.dart';
import 'package:odyss/screens/error_dialog_widget.dart';
import 'package:odyss/screens/loading_animation_widget.dart';

class CircleMembersScreen extends ConsumerStatefulWidget {
  const CircleMembersScreen({Key? key, required this.id}) : super(key: key);

  final String id;

  @override
  ConsumerState<CircleMembersScreen> createState() =>
      _CircleMembersScreenState();
}

class _CircleMembersScreenState extends ConsumerState<CircleMembersScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.refresh(CircleListProvider);
    });
  }

  @override
  Widget build(BuildContext context) {
    final myColors = Theme.of(context).extension<MyColors>()!;

    final allCirclesAsync = ref.watch(CircleListProvider);
    final allUsersAsync = ref.watch(userListProvider);
    final allRidesAsync = ref.watch(ridesListProvider);

    // Handle loading and error for all providers
    if (allCirclesAsync is AsyncLoading ||
        allUsersAsync is AsyncLoading ||
        allRidesAsync is AsyncLoading) {
      return const Scaffold(body: Center(child: LoadingAnimationWidget()));
    }

    if (allCirclesAsync is AsyncError) {
      return Scaffold(
        body: ErrorDialogWidget(
          error: allCirclesAsync.error.toString(),
          onRetry: () => setState(() {}),
        ),
      );
    }
    if (allUsersAsync is AsyncError) {
      return Scaffold(
        body: ErrorDialogWidget(
          error: allUsersAsync.error.toString(),
          onRetry: () => setState(() {}),
        ),
      );
    }
    if (allRidesAsync is AsyncError) {
      return Scaffold(
        body: ErrorDialogWidget(
          error: allRidesAsync.error.toString(),
          onRetry: () => setState(() {}),
        ),
      );
    }

    // Extract data after loading/error checks
    List<CircleModel> allCircles = allCirclesAsync.value ?? [];
    List<UserModel> allUsers = allUsersAsync.value ?? [];
    List<RideModel> allRides = allRidesAsync.value ?? [];

    CircleModel circle = allCircles.firstWhere(
      (circle) => circle.id == widget.id,
    );

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: SafeArea(
          child: Container(
            height: 80,
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.05,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).appBarTheme.backgroundColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10.0,
                  offset: Offset(0, 20),
                ),
              ],
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20.0),
                bottomRight: Radius.circular(20.0),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back_ios, size: 20),
                  onPressed: () {
                    ref.invalidate(CircleListProvider);
                    ref.invalidate(ridesListProvider);
                    ref.invalidate(userListProvider);
                    ref.invalidate(partnerListProvider);
                    ref.invalidate(routesListProvider);
                    ref.invalidate(vehiclesListProvider);
                    ref.invalidate(bookingsListProvider);
                    context.pop();
                  },
                ),
                Container(
                  width: 45,
                  height: 45,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 2,
                              color: myColors.primary,
                            ),
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.grey.shade300,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 15,
                        top: 0,
                        child: Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 2,
                              color: myColors.primary,
                            ),
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.grey.shade300,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        bottom: 0,
                        child: Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 2,
                              color: myColors.primary,
                            ),
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.grey.shade300,
                          ),
                        ),
                      ),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 2,
                              color: myColors.primary,
                            ),
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.grey.shade300,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    circle.name,
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Text(
                  circle.description,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.65,
                child: ListView.builder(
                  itemCount: circle.users.length,
                  itemBuilder: (context, index) {
                    String user = circle.users[index];
                    UserModel memberModel = allUsers.firstWhere(
                      (element) => element.id == user,
                    );
                    return ListTile(
                      onTap: () {
                        context.push('/profile/$user');
                      },
                      contentPadding: EdgeInsets.all(0),
                      leading: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          border: Border.all(width: 2, color: Colors.black),
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      title: Text(
                        '${memberModel.firstName} ${memberModel.lastName}',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      trailing: ElevatedButton(
                        onPressed: () {
                          List<RideModel> rides = allRides
                              .where((ride) => ride.memberIds.contains(user))
                              .toList();

                          void showRidePopup(BuildContext context) {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20),
                                ),
                              ),
                              builder: (context) {
                                return FractionallySizedBox(
                                  heightFactor: 0.5, // Half the screen
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 20),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal:
                                              MediaQuery.of(
                                                context,
                                              ).size.width *
                                              0.05,
                                        ),
                                        child: Text(
                                          'Select Trip',
                                          style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                            0.4, // Adjust height as needed
                                        child: SingleChildScrollView(
                                          padding: EdgeInsets.all(16),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(height: 12),
                                              ...List.generate(rides.length, (
                                                i,
                                              ) {
                                                RideModel ride = rides[i];
                                                int remainingSeats =
                                                    ride.seats -
                                                    ride.memberIds.length;
                                                bool dayCheck =
                                                    ride.departureDate.day
                                                        .toString()
                                                        .length ==
                                                    2;

                                                cardLimit() {
                                                  if (ride.memberIds.length >=
                                                      3) {
                                                    return 3;
                                                  } else {
                                                    return ride
                                                        .memberIds
                                                        .length;
                                                  }
                                                }

                                                return Container(
                                                  padding: EdgeInsets.fromLTRB(
                                                    0,
                                                    0,
                                                    0,
                                                    40,
                                                  ),
                                                  child: Container(
                                                    width: MediaQuery.of(
                                                      context,
                                                    ).size.width,
                                                    padding: EdgeInsets.all(
                                                      MediaQuery.of(
                                                            context,
                                                          ).size.width *
                                                          0.05,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                        width: 1,
                                                        color: Colors.black26,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            25,
                                                          ),
                                                    ),
                                                    child: Column(
                                                      children: [
                                                        Container(
                                                          width:
                                                              double.infinity,
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Container(
                                                                width: 200,
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Container(
                                                                      width:
                                                                          ((17 *
                                                                              (cardLimit() -
                                                                                  1)) +
                                                                          43),
                                                                      height:
                                                                          40,
                                                                      child: Stack(
                                                                        children: [
                                                                          ...List.generate(
                                                                            cardLimit(),
                                                                            (
                                                                              indexnew,
                                                                            ) {
                                                                              // final member = rides[index].members[indexnew];
                                                                              return Positioned(
                                                                                left:
                                                                                    indexnew *
                                                                                    17,
                                                                                child: Container(
                                                                                  width: 40,
                                                                                  height: 40,
                                                                                  decoration: BoxDecoration(
                                                                                    border: Border.all(
                                                                                      width: 2,
                                                                                      color: Colors.black,
                                                                                    ),
                                                                                    color: Colors.grey.shade300,
                                                                                    borderRadius: BorderRadius.circular(
                                                                                      20,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              );
                                                                            },
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                      'You and ${ride.memberIds.length - 1} others',
                                                                      style: TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              TextButton(
                                                                onPressed:
                                                                    () {},
                                                                style: ButtonStyle(
                                                                  padding: WidgetStatePropertyAll(
                                                                    EdgeInsets.symmetric(
                                                                      vertical:
                                                                          10,
                                                                      horizontal:
                                                                          20,
                                                                    ),
                                                                  ),
                                                                  backgroundColor: WidgetStateColor.resolveWith((
                                                                    states,
                                                                  ) {
                                                                    if (states.contains(
                                                                      WidgetState
                                                                          .pressed,
                                                                    )) {
                                                                      return myColors
                                                                          .primary;
                                                                    }
                                                                    return myColors
                                                                        .backgound;
                                                                  }),
                                                                  foregroundColor: WidgetStateColor.resolveWith((
                                                                    states,
                                                                  ) {
                                                                    if (states.contains(
                                                                      WidgetState
                                                                          .pressed,
                                                                    )) {
                                                                      return myColors
                                                                          .backgound;
                                                                    }
                                                                    return myColors
                                                                        .primary;
                                                                  }),
                                                                  side: WidgetStatePropertyAll(
                                                                    BorderSide(
                                                                      width: 2,
                                                                      color: myColors
                                                                          .primary,
                                                                    ),
                                                                  ),
                                                                  elevation:
                                                                      WidgetStatePropertyAll(
                                                                        0,
                                                                      ),
                                                                ),
                                                                child: Text(
                                                                  'Select',
                                                                  style:
                                                                      TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                      ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(height: 20),
                                                        Container(
                                                          width:
                                                              double.infinity,
                                                          height: 70,
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Expanded(
                                                                flex: 1,
                                                                child: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .end,
                                                                  children: [
                                                                    Icon(
                                                                      Icons
                                                                          .circle,
                                                                      size: 13,
                                                                    ),
                                                                    Text(
                                                                      '|',
                                                                      style: TextStyle(
                                                                        fontSize:
                                                                            6,
                                                                        fontWeight:
                                                                            FontWeight.w900,
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                      '|',
                                                                      style: TextStyle(
                                                                        fontSize:
                                                                            6,
                                                                        fontWeight:
                                                                            FontWeight.w900,
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                      '|',
                                                                      style: TextStyle(
                                                                        fontSize:
                                                                            6,
                                                                        fontWeight:
                                                                            FontWeight.w900,
                                                                      ),
                                                                    ),
                                                                    Icon(
                                                                      Icons
                                                                          .location_on_rounded,
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              Expanded(
                                                                flex: 15,
                                                                child: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        Text(
                                                                          ride.departureLoc,
                                                                          style: TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                            fontSize:
                                                                                12,
                                                                          ),
                                                                        ),
                                                                        Text(
                                                                          '${dayCheck ? ride.departureDate.day : '0${ride.departureDate.day}'} ${DateFormat.MMM().format(ride.departureDate)}, ${DateFormat.Hm().format(ride.departureDate)} ${DateFormat('a').format(ride.departureDate)}',
                                                                          style: TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.w400,
                                                                            fontSize:
                                                                                12,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          27,
                                                                    ),
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        Text(
                                                                          ride.arrivalLoc,
                                                                          style: TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                            fontSize:
                                                                                12,
                                                                          ),
                                                                        ),
                                                                        Text(
                                                                          '${dayCheck ? ride.arrivalDate.day : '0${ride.arrivalDate.day}'} ${DateFormat.MMM().format(ride.arrivalDate)}, ${DateFormat.Hm().format(ride.arrivalDate)} ${DateFormat('a').format(ride.arrivalDate)}',
                                                                          style: TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.w400,
                                                                            fontSize:
                                                                                12,
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
                                                        SizedBox(height: 20),
                                                        Container(
                                                          width:
                                                              double.infinity,
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Container(
                                                                width: 200,
                                                                child: Row(
                                                                  children: [
                                                                    Container(
                                                                      height:
                                                                          25,
                                                                      width: 25,
                                                                      decoration: BoxDecoration(
                                                                        color: Colors
                                                                            .grey
                                                                            .shade300,
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                              15,
                                                                            ),
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      width: 3,
                                                                    ),
                                                                    Text(
                                                                      ride.company,
                                                                      style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight.w600,
                                                                        fontSize:
                                                                            12,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              Text.rich(
                                                                TextSpan(
                                                                  text:
                                                                      'Vehicle: ',
                                                                  style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontSize:
                                                                        12,
                                                                  ),
                                                                  children: [
                                                                    TextSpan(
                                                                      text: ride
                                                                          .vehicle,
                                                                      style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight.w400,
                                                                        fontSize:
                                                                            12,
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
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Expanded(
                                                              flex: 5,
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    '₦${ride.price.toString()}',
                                                                    style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      fontSize:
                                                                          12,
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    'per seat',
                                                                    style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      fontSize:
                                                                          10,
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
                                                                    remainingSeats
                                                                        .toString(),
                                                                    style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      fontSize:
                                                                          12,
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    'available',
                                                                    style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      fontSize:
                                                                          10,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            Expanded(
                                                              flex: 5,
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .end,
                                                                children: [
                                                                  Text(
                                                                    '${ride.departureDate.day - DateTime.now().day} days',
                                                                    style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      fontSize:
                                                                          12,
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    'left to trip',
                                                                    style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      fontSize:
                                                                          10,
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
                                                );
                                              }),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          }

                          showRidePopup(context);
                        },
                        style: ButtonStyle(
                          padding: WidgetStatePropertyAll(
                            EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                          ),
                        ),
                        child: Text(
                          'Invite to trip',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
