// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:gofit/screens/account_screen/account_screens.dart';
import 'package:gofit/screens/cart_screen/cart_screen.dart';
import 'package:gofit/screens/home/home.dart';
import 'package:gofit/screens/map_screen.dart';
import 'package:gofit/screens/membership_screen.dart';
import 'package:gofit/screens/order_screen/order_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class CustomBottomBar extends StatefulWidget {
  const CustomBottomBar({
    final Key? key,
  }) : super(key: key);

  @override
  _CustomBottomBarState createState() => _CustomBottomBarState();
}

class _CustomBottomBarState extends State<CustomBottomBar> {
  final PersistentTabController _controller = PersistentTabController();
  final bool _hideNavBar = false;

  List<Widget> _buildScreens() => [
        const Home(),
        const MapScreen(),
        const MembershipScreen(),
        const OrderScreen(),
        const AccountScreen(),

        // Container(),
        // Container(),
        // Container(),
      ];

  List<PersistentBottomNavBarItem> _navBarsItems() => [
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.home),
          inactiveIcon: const Icon(Icons.home_outlined),
          title: "Home",
          activeColorPrimary: Colors.black,
          inactiveColorPrimary: Colors.black,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.map),
          inactiveIcon: const Icon(Icons.map_outlined),
          title: "Map",
          activeColorPrimary: Colors.black,
          inactiveColorPrimary: Colors.black,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.wallet_membership),
          inactiveIcon: const Icon(Icons.wallet_membership_outlined),
          title: "Membership",
          activeColorPrimary: Colors.black,
          inactiveColorPrimary: Colors.black,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.calendar_month),
          inactiveIcon: const Icon(Icons.calendar_month_outlined),
          title: "Orders",
          activeColorPrimary: Colors.black,
          inactiveColorPrimary: Colors.black,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.person),
          inactiveIcon: const Icon(Icons.person_outline),
          title: "Account",
          activeColorPrimary: Colors.black,
          inactiveColorPrimary: Colors.black,
        ),
      ];

  @override
  Widget build(final BuildContext context) => Scaffold(
        body: PersistentTabView(
          context,
          controller: _controller,
          screens: _buildScreens(),
          items: _navBarsItems(),
          resizeToAvoidBottomInset: true,
          navBarHeight: MediaQuery.of(context).viewInsets.bottom > 0
              ? 0.0
              : kBottomNavigationBarHeight,
          bottomScreenMargin: 0,

          backgroundColor: Colors.white,
          hideNavigationBar: _hideNavBar,
          decoration: const NavBarDecoration(colorBehindNavBar: Colors.indigo),
          itemAnimationProperties: const ItemAnimationProperties(
            duration: Duration(milliseconds: 400),
            curve: Curves.ease,
          ),
          screenTransitionAnimation: const ScreenTransitionAnimation(
            animateTabTransition: true,
          ),
          navBarStyle: NavBarStyle
              .style12, // Choose the nav bar style with this property
        ),
      );
}
