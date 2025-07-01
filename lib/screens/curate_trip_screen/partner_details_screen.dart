import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:odyss/core/colors.dart';
import 'package:odyss/core/constraints.dart';
import 'package:odyss/core/providers/list_providers/company_list_provider.dart';
import 'package:odyss/core/providers/list_providers/route_list_provider.dart';
import 'package:odyss/data/models/company_model.dart';
import 'package:odyss/data/models/route_model.dart';
import 'package:odyss/screens/error_dialog_widget.dart';
import 'package:odyss/screens/loading_animation_widget.dart';

class PartnerDetailsScreen extends ConsumerStatefulWidget {
  const PartnerDetailsScreen({super.key});

  @override
  ConsumerState<PartnerDetailsScreen> createState() =>
      _PartnerDetailsScreenState();
}

class _PartnerDetailsScreenState extends ConsumerState<PartnerDetailsScreen> {
  final GlobalKey _partnerKey = GlobalKey();
  final GlobalKey _vehicleKey = GlobalKey();
  final GlobalKey _timeKey = GlobalKey();
  TextEditingController vehicleController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController partnerController = TextEditingController();
  DateTime time = DateTime.now();
  @override
  Widget build(BuildContext context) {
    final myColors = Theme.of(context).extension<MyColors>()!;

    final partnerListAsync = ref.watch(partnerListProvider);
    final routesListAsync = ref.watch(routesListProvider);
    final vehiclesListAsync = ref.watch(vehiclesListProvider);

    if (partnerListAsync is AsyncLoading ||
        routesListAsync is AsyncLoading ||
        vehiclesListAsync is AsyncLoading) {
      return const Scaffold(body: Center(child: LoadingAnimationWidget()));
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
    if (vehiclesListAsync is AsyncError) {
      return Scaffold(
        body: ErrorDialogWidget(
          error: vehiclesListAsync.error.toString(),
          onRetry: () => setState(() {}),
        ),
      );
    }

    final partnerList = partnerListAsync.value ?? [];
    final routesList = routesListAsync.value ?? [];
    final allVehicles = vehiclesListAsync.value ?? [];

    List<RouteModel> routes = routesList
        .where(
          (route) =>
              route.departureLocation == newRide['depLoc'] &&
              route.arrivalLocation == newRide['destLoc'],
        )
        .toList();

    List<String> companyIds = List.generate(routes.length, (i) {
      return routes[i].companyId;
    });

    List<PartnerModel> partners = partnerList
        .where((partner) => companyIds.contains(partner.id))
        .toList();

    // List<PartnerModel> partners = partnerList.where((partner) => ,)
    // .where(
    //   (partners) =>
    //       // partners.locations.contains(newRide['depLoc']) &&
    //       // partners.locations.contains(newRide['destLoc']),
    // )
    // .toList();

    // List<VehicleModel> vehiclePicker(String company) {
    //   // this is for getting the vehicles for the specific company that has been chosen
    //   final partner = partners.firstWhere((partner) => partner.name == company);
    //   return partner.vehicles;
    // }

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
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 50),
                Column(
                  children: [
                    SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                          onPressed: () {
                            context.pop();
                          },
                          icon: Icon(Icons.arrow_back_ios_rounded, size: 30),
                        ),
                        Text(
                          'What is the ride like?',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 600,
                      padding: EdgeInsets.all(
                        MediaQuery.sizeOf(context).width * 0.05,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                                Text('Transport partner'),
                                TextFormField(
                                  key: _partnerKey,
                                  controller: partnerController,
                                  keyboardType: TextInputType.datetime,
                                  textInputAction: TextInputAction.next,
                                  readOnly: true,
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  decoration: InputDecoration(
                                    hintText:
                                        'Select which Odyss partner to travel with',
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
                                          _partnerKey.currentContext!
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
                                        items: List.generate(partners.length, (
                                          index,
                                        ) {
                                          return PopupMenuItem(
                                            child: Text(
                                              partners[index].name,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 15,
                                              ),
                                            ),
                                            onTap: () {
                                              setState(() {
                                                partnerController.text =
                                                    partners[index].name;
                                              });
                                            },
                                          );
                                        }),
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
                                Text('Vehicle Type'),
                                TextFormField(
                                  controller: vehicleController,
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.next,
                                  key: _vehicleKey,
                                  readOnly: true,
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: 'What vehicle are you using?',
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
                                    if (partnerController.text.isEmpty) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          duration: Duration(seconds: 2),
                                          backgroundColor: myColors.backgound,
                                          content: Text(
                                            textAlign: TextAlign.center,
                                            'Choose a transport partner first',
                                            style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ),
                                      );
                                    } else {
                                      final PartnerModel selectedPartner =
                                          partners.firstWhere(
                                            (partnerInstance) =>
                                                partnerInstance.name ==
                                                partnerController.text,
                                          );
                                      final id = selectedPartner.id;

                                      final RouteModel selectedRoute = routes
                                          .firstWhere(
                                            (routeInstance) =>
                                                routeInstance.companyId == id,
                                          );

                                      final List<VehicleModel> vehicles =
                                          List.generate(
                                            selectedRoute.vehicles.length,
                                            (i) {
                                              return allVehicles.firstWhere(
                                                (vehicle) =>
                                                    vehicle.id ==
                                                    selectedRoute.vehicles[i],
                                              );
                                            },
                                          );

                                      return setState(() {
                                        final RenderBox button =
                                            _vehicleKey.currentContext!
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
                                                BorderRadiusGeometry.circular(
                                                  20,
                                                ),
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
                                          items: List.generate(
                                            vehicles.length,
                                            (index) {
                                              return PopupMenuItem(
                                                child: Text(
                                                  vehicles[index].type,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                                onTap: () {
                                                  setState(() {
                                                    vehicleController.text =
                                                        vehicles[index].type;
                                                    numberController.text =
                                                        vehicles[index].seats;
                                                  });
                                                },
                                              );
                                            },
                                          ),
                                        );
                                      });
                                    }
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
                                Text('Number of seats'),
                                TextFormField(
                                  controller: numberController,
                                  keyboardType: TextInputType.number,
                                  textInputAction: TextInputAction.next,
                                  readOnly: true,
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  decoration: InputDecoration(
                                    hintText:
                                        'How many people can join this trip?',
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
                                    if (vehicleController.text.isEmpty) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          duration: Duration(seconds: 2),
                                          backgroundColor: myColors.backgound,
                                          content: Text(
                                            textAlign: TextAlign.center,
                                            'Choose a vehicle first',
                                            style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ),
                                      );
                                    } else {
                                      Flushbar(
                                        message:
                                            'Seat number is automatically set based on vehicle',
                                        messageSize: 12,
                                        duration: Duration(seconds: 1),
                                        flushbarPosition: FlushbarPosition
                                            .TOP, // Top of screen
                                        backgroundColor: Colors
                                            .red, // Optional: customize color
                                        margin: EdgeInsets.all(
                                          8,
                                        ), // Optional: margin for better look
                                        borderRadius: BorderRadius.circular(
                                          8,
                                        ), // Optional: rounded corners
                                      ).show(context);
                                    }
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
                                Text('Time of departure'),
                                TextFormField(
                                  controller: timeController,
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.next,
                                  key: _timeKey,
                                  readOnly: true,
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: 'What time are you leaving?',
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
                                    if (partnerController.text.isEmpty) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          duration: Duration(seconds: 2),
                                          backgroundColor: myColors.backgound,
                                          content: Text(
                                            textAlign: TextAlign.center,
                                            'Choose a transport partner first',
                                            style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ),
                                      );
                                    } else {
                                      final PartnerModel selectedPartner =
                                          partners.firstWhere(
                                            (partnerInstance) =>
                                                partnerInstance.name ==
                                                partnerController.text,
                                          );
                                      final id = selectedPartner.id;

                                      final RouteModel selectedRoute = routes
                                          .firstWhere(
                                            (routeInstance) =>
                                                routeInstance.companyId == id,
                                          );

                                      return setState(() {
                                        final RenderBox button =
                                            _timeKey.currentContext!
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
                                                BorderRadiusGeometry.circular(
                                                  20,
                                                ),
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
                                          items: List.generate(
                                            selectedRoute.departureTime.length,
                                            (index) {
                                              bool hourDigitSmall = false;
                                              bool minuteDigitSmall = false;
                                              if (selectedRoute
                                                      .departureTime[index]
                                                      .hour <
                                                  10) {
                                                setState(() {
                                                  hourDigitSmall = true;
                                                });
                                              }
                                              if (selectedRoute
                                                      .departureTime[index]
                                                      .minute <
                                                  10) {
                                                setState(() {
                                                  minuteDigitSmall = true;
                                                });
                                              }
                                              return PopupMenuItem(
                                                child: Text(
                                                  hourDigitSmall
                                                      ? '0${selectedRoute.departureTime[index].hour} : ${minuteDigitSmall ? '0${selectedRoute.departureTime[index].minute}' : '${selectedRoute.departureTime[index].minute}'}'
                                                      : '${selectedRoute.departureTime[index].hour} : ${minuteDigitSmall ? '0${selectedRoute.departureTime[index].minute}' : '${selectedRoute.departureTime[index].minute}'}',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                                onTap: () {
                                                  setState(() {
                                                    timeController.text =
                                                        hourDigitSmall
                                                        ? '0${selectedRoute.departureTime[index].hour} : ${minuteDigitSmall ? '0${selectedRoute.departureTime[index].minute}' : '${selectedRoute.departureTime[index].minute}'}'
                                                        : '${selectedRoute.departureTime[index].hour} : ${minuteDigitSmall ? '0${selectedRoute.departureTime[index].minute}' : '${selectedRoute.departureTime[index].minute}'}';
                                                    time = DateTime(
                                                      0,
                                                      0,
                                                      0,
                                                      selectedRoute
                                                          .departureTime[index]
                                                          .hour,
                                                      selectedRoute
                                                          .departureTime[index]
                                                          .minute,
                                                    );
                                                    print(time);
                                                  });
                                                },
                                              );
                                            },
                                          ),
                                        );
                                      });
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.width * 0.05,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                width: 130,
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (partnerController.text.isEmpty) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          duration: Duration(seconds: 2),
                                          backgroundColor: myColors.backgound,
                                          content: Text(
                                            textAlign: TextAlign.center,
                                            'Choose a Transport partner',
                                            style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ),
                                      );
                                    } else if (vehicleController.text.isEmpty) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          duration: Duration(seconds: 2),
                                          backgroundColor: myColors.backgound,
                                          content: Text(
                                            textAlign: TextAlign.center,
                                            'Choose a vehicle type',
                                            style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ),
                                      );
                                    } else if (timeController.text.isEmpty) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          duration: Duration(seconds: 2),
                                          backgroundColor: myColors.backgound,
                                          content: Text(
                                            textAlign: TextAlign.center,
                                            'Choose a time of departure',
                                            style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ),
                                      );
                                    } else if (numberController.text.isEmpty) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          duration: Duration(seconds: 2),
                                          backgroundColor: myColors.backgound,
                                          content: Text(
                                            textAlign: TextAlign.center,
                                            'Enter number of seats',
                                            style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ),
                                      );
                                    } else {
                                      newRide['partner'] =
                                          partnerController.text;
                                      newRide['vehicle'] =
                                          vehicleController.text;
                                      newRide['seats'] = numberController.text;
                                      newRide['time'] = time;
                                      print(newRide['time']);
                                      context.push('/tripVibe');
                                    }
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
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
    );
  }
}
