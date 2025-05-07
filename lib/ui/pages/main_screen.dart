import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:test_android_flutter/ui/widgets/custom_bottom_bar.dart';

class MainScreen extends StatefulWidget {
  final StatefulNavigationShell navigationShell;

  const MainScreen({super.key, required this.navigationShell});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 1;

  void goToBranch(index) => widget.navigationShell.goBranch(
        index,
        //  initialLocation: index == widgets.navigationShell.currentIndex,
      );
  @override
  void initState() {
    goToBranch(_selectedIndex);
    super.initState();
  }

  @override
  void dispose() {
    goToBranch(1);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: CustomBottomBar(
        selectedIndex: _selectedIndex,
        onTabSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
          goToBranch(index);
        },
      ),
      appBar: AppBar(),
      body: widget.navigationShell,
    );
  }
}
