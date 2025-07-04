import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:odyss/core/colors.dart';
import 'package:odyss/screens/bottom_app_bar.dart';
import 'package:odyss/screens/rides_screen/rides_screen_widgets/available_rides_widget.dart';
import 'package:odyss/screens/rides_screen/rides_screen_widgets/search_widget.dart';

class RidesScreen extends ConsumerStatefulWidget {
  const RidesScreen({super.key});

  @override
  ConsumerState<RidesScreen> createState() => _RidesScreenState();
}

class _RidesScreenState extends ConsumerState<RidesScreen> {
  @override
  Widget build(BuildContext context) {
    // final myColors = Theme.of(context).extension<MyColors>()!;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        extendBodyBehindAppBar: false,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(
            MediaQuery.of(context).size.height * 0.25,
          ),
          child: SearchWidget(),
        ),
        body: SafeArea(
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(top: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('   Available Rides', style: TextStyle(fontSize: 20)),
                Expanded(child: AvailableRidesWidget()),
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
            toggle1: false,
            toggle2: true,
            toggle3: false,
            toggle4: false,
          ),
        ),
      ),
    );
  }
}
