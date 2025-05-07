import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:test_android_flutter/core/provider/posts_provider.dart';
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

  String getAppBarTitle() {
    switch (_selectedIndex) {
      case 0:
        return "Home";
      case 1:
        return "Browse posts";
      case 2:
        return "Explore";
      case 3:
        return "Account";

      default:
        return "Unknown";
    }
  }

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
      backgroundColor: Color(0xffF3F6FF),
      bottomNavigationBar: CustomBottomBar(
        selectedIndex: _selectedIndex,
        onTabSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
          goToBranch(index);
        },
      ),
      appBar: widget.navigationShell.shellRouteContext.routerState.fullPath == "/posts/details"
          ? null
          : AppBar(
              backgroundColor: Colors.white,
              leading: IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
              title: Text(
                getAppBarTitle(),
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              bottom: _selectedIndex == 1
                  ? PreferredSize(
                      preferredSize: Size.fromHeight(70),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: TextField(
                          maxLines: 1,
                          onChanged: (value) {
                            context.read<PostsProvider>().filterPosts(filter: value);
                          },
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Color(0xffF5F7FF),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                              borderSide: BorderSide.none,
                            ),
                            prefixIcon: Icon(
                              Icons.search,
                              color: Color(0xff808DBA),
                            ),
                            hintText: "Search ...",
                            hintStyle: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                              color: Color(0xff808DBA),
                            ),
                          ),
                        ),
                      ),
                    )
                  : null,
            ),
      body: widget.navigationShell,
    );
  }
}
