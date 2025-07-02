import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:odyss/core/colors.dart';
import 'package:odyss/core/constraints.dart';
import 'package:odyss/core/providers/list_providers/company_list_provider.dart';
import 'package:odyss/core/providers/list_providers/route_list_provider.dart';
import 'package:odyss/core/providers/list_providers/user_list_provider.dart';
import 'package:odyss/data/models/company_model.dart';
import 'package:odyss/data/models/ride_model.dart';
import 'package:odyss/data/models/route_model.dart';
import 'package:odyss/data/models/user_model.dart';
import 'package:odyss/screens/curate_trip_screen/curate_trip_widgets/initiate_trip_function.dart';
import 'package:odyss/screens/error_dialog_widget.dart';

class PricingScreen extends ConsumerStatefulWidget {
  const PricingScreen({super.key});

  @override
  ConsumerState<PricingScreen> createState() => _PricingScreenState();
}

class _PricingScreenState extends ConsumerState<PricingScreen> {
  TextEditingController priceController = TextEditingController();
  TextEditingController fillController = TextEditingController();
  late bool fill;
  final GlobalKey _fillKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final myColors = Theme.of(context).extension<MyColors>()!;

    final partnerListAsync = ref.watch(partnerListProvider);
    final routesListAsync = ref.watch(routesListProvider);
    final userListAsync = ref.watch(userListProvider);
    final vehiclesListAsync = ref.watch(vehiclesListProvider);

    if (partnerListAsync is AsyncLoading ||
        routesListAsync is AsyncLoading ||
        userListAsync is AsyncLoading ||
        vehiclesListAsync is AsyncLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (partnerListAsync is AsyncError) {
      return Scaffold(
        body: ErrorDialogWidget(
          error: partnerListAsync.error.toString(),
          onRetry: () => setState(() {}),
        ),
      );
    }
    if (routesListAsync is AsyncError) {
      return Scaffold(
        body: ErrorDialogWidget(
          error: routesListAsync.error.toString(),
          onRetry: () => setState(() {}),
        ),
      );
    }
    if (userListAsync is AsyncError) {
      return Scaffold(
        body: ErrorDialogWidget(
          error: userListAsync.error.toString(),
          onRetry: () => setState(() {}),
        ),
      );
    }
    if (vehiclesListAsync is AsyncError) {
      return Scaffold(
        body: ErrorDialogWidget(
          error: vehiclesListAsync.error.toString(),
          onRetry: () => setState(() {}),
        ),
      );
    }

    final partnerList = partnerListAsync.value ?? [];
    final List<RouteModel> routesList = routesListAsync.value ?? [];
    final List<UserModel> users = userListAsync.value ?? [];
    final List<VehicleModel> vehicles = vehiclesListAsync.value ?? [];

    PartnerModel currPartner = partnerList.firstWhere(
      (currPartner) => currPartner.name == newRide['partner'],
    );

    List<RouteModel> routes = routesList
        .where((route) => route.companyId == currPartner.id)
        .toList();

    RouteModel currRoute = routes.firstWhere(
      (route) =>
          route.arrivalLocation == newRide['destLoc'] &&
          route.departureLocation == newRide['depLoc'],
    );

    // ignore: unused_local_variable
    VehicleModel currVehicle = vehicles.firstWhere(
      (vehicle) => vehicle.type == newRide['vehicle'],
    );

    UserModel user = users.firstWhere((user) => user.id == UID);

    priceController.text = currRoute.price;

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
              ],
            ),
          ),
        ),
        body: SafeArea(
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
                            context.pop();
                          },
                          icon: Icon(Icons.arrow_back_ios_rounded, size: 30),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.87,
                          child: Text(
                            overflow: TextOverflow.clip,
                            "Pricing & Plan B",
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
                      height: 500,
                      padding: EdgeInsets.all(
                        MediaQuery.sizeOf(context).width * 0.05,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
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
                              border: Border.all(
                                width: 2,
                                color: Colors.black26,
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Trip price per seat (₦)'),
                                TextFormField(
                                  controller: priceController,
                                  keyboardType: TextInputType.datetime,
                                  textInputAction: TextInputAction.next,
                                  readOnly: true,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    contentPadding: EdgeInsets.zero,
                                    disabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                  ),
                                  onTap: () {
                                    Flushbar(
                                      message:
                                          "Prices are automatically set based on the trip details you've chosen",
                                      messageSize: 12,
                                      duration: Duration(seconds: 1),
                                      flushbarPosition:
                                          FlushbarPosition.TOP, // Top of screen
                                      backgroundColor: Colors
                                          .red, // Optional: customize color
                                      margin: EdgeInsets.all(
                                        8,
                                      ), // Optional: margin for better look
                                      borderRadius: BorderRadius.circular(
                                        8,
                                      ), // Optional: rounded corners
                                    ).show(context);
                                  },
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.all(
                              MediaQuery.of(context).size.width * 0.03,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 2,
                                color: Colors.black26,
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Refund policy acknowledgement',
                                  style: TextStyle(fontSize: 13),
                                ),
                                SizedBox(height: 10),
                                ListTile(
                                  leading: Icon(Icons.circle, size: 5),
                                  titleAlignment:
                                      ListTileTitleAlignment.titleHeight,
                                  contentPadding: EdgeInsets.all(0),
                                  horizontalTitleGap: 0,
                                  title: Text(
                                    'You are eligible for a full refund if you cancel your booking at least 3 days (72 hours) before the scheduled trip date.',
                                    style: TextStyle(fontSize: 10),
                                  ),
                                ),
                                ListTile(
                                  leading: Icon(Icons.circle, size: 5),
                                  titleAlignment:
                                      ListTileTitleAlignment.titleHeight,
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
                                Text('Smart Fill Policy Preference'),
                                TextFormField(
                                  key: _fillKey,
                                  controller: fillController,
                                  keyboardType: TextInputType.datetime,
                                  textInputAction: TextInputAction.next,
                                  readOnly: true,
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: 'Select your preference',
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
                                          _fillKey.currentContext!
                                                  .findRenderObject()
                                              as RenderBox;
                                      final RenderBox overlay =
                                          Overlay.of(
                                                context,
                                              ).context.findRenderObject()
                                              as RenderBox;

                                      final Offset position = button
                                          .localToGlobal(
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
                                              button
                                                  .size
                                                  .height, // show just below
                                          position.dx + button.size.width,
                                          position.dy,
                                        ),
                                        items: [
                                          PopupMenuItem(
                                            child: Text(
                                              'Allow Offline Fill-in',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 15,
                                              ),
                                            ),
                                            onTap: () {
                                              setState(() {
                                                fillController.text =
                                                    'Allow Offline Fill-in';
                                                fill = true;
                                              });
                                            },
                                          ),
                                          PopupMenuItem(
                                            child: Text(
                                              'Split the Remaining Cost',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 15,
                                              ),
                                            ),
                                            onTap: () {
                                              setState(() {
                                                fillController.text =
                                                    'Split the Remaining Cost';
                                                fill = false;
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                child: ElevatedButton(
                                  onPressed: () async {
                                    if (fillController.text.isEmpty) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          duration: Duration(seconds: 2),
                                          backgroundColor: myColors.backgound,
                                          content: Text(
                                            textAlign: TextAlign.center,
                                            'Select a fill-in preference to continue',
                                            style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ),
                                      );
                                    }

                                    newRide['members'].add(UID);
                                    newRide['price'] = priceController.text;
                                    newRide['fill'] = fill;
                                    DateTime date = newRide['date'];
                                    DateTime time = newRide['time'];

                                    String tod() {
                                      if (time.hour < 12) {
                                        return 'Morning';
                                      } else if (time.hour < 18) {
                                        return 'Afternoon';
                                      } else {
                                        return 'Evening';
                                      }
                                    }

                                    var newRideModel = RideModel(
                                      vehicle: newRide['vehicle'],
                                      memberIds: [UID],
                                      seats: int.parse(newRide['seats']),
                                      company: newRide['partner'],
                                      price: double.parse(newRide['price']),
                                      departureLoc: newRide['depLoc'],
                                      arrivalLoc: newRide['destLoc'],
                                      departureTOD: tod(),
                                      departureDate: DateTime(
                                        date.year,
                                        date.month,
                                        date.day,
                                        time.hour,
                                        time.minute,
                                      ),
                                      arrivalDate: DateTime(
                                        date.year,
                                        date.month,
                                        date.day,
                                        time.hour + 8,
                                        time.minute,
                                      ),
                                      id: "",
                                      creator: UID,
                                      fill: newRide['fill'],
                                      vibes: List.from(newRide['vibes']),
                                    );
                                    initiateTripAndPay(
                                      context: context,
                                      ride: newRideModel,
                                      userEmail: user.email,
                                    ); // Dismiss loading
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Book your seat',
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
    );
  }
}
