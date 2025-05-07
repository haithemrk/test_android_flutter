import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomBottomBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTabSelected;

  const CustomBottomBar({
    super.key,
    required this.selectedIndex,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    final tabs = [
      _buildTabItem(
        context,
        0,
        selectedIndex,
        SvgPicture.asset(
          "assets/svg/home.svg",
          colorFilter: ColorFilter.mode(Color(0xff1864D3), BlendMode.srcIn),
        ),
        SvgPicture.asset(
          "assets/svg/home.svg",
        ),
        "Home",
      ),
      _buildTabItem(
        context,
        1,
        selectedIndex,
        SvgPicture.asset(
          "assets/svg/posts.svg",
          colorFilter: ColorFilter.mode(Color(0xff1864D3), BlendMode.srcIn),
        ),
        SvgPicture.asset(
          "assets/svg/posts.svg",
          colorFilter: ColorFilter.mode(Color(0xff8696BB), BlendMode.srcIn),
        ),
        "Posts",
      ),
      _buildTabItem(
        context,
        2,
        selectedIndex,
        SvgPicture.asset(
          "assets/svg/explore.svg",
          colorFilter: ColorFilter.mode(Color(0xff1864D3), BlendMode.srcIn),
        ),
        SvgPicture.asset("assets/svg/explore.svg"),
        "Explore",
      ),
      _buildTabItem(
        context,
        3,
        selectedIndex,
        SvgPicture.asset(
          "assets/svg/account.svg",
          colorFilter: ColorFilter.mode(Color(0xff1864D3), BlendMode.srcIn),
        ),
        SvgPicture.asset("assets/svg/account.svg"),
        "Account",
      ),
    ];

    return Container(
      height: 70,
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey.shade200)),
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            blurStyle: BlurStyle.inner,
            blurRadius: 25,
            color: Colors.grey.shade100,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: tabs,
      ),
    );
  }

  Widget _buildTabItem(
    BuildContext context,
    int index,
    int selectedIndex,
    Widget selectedIcon,
    Widget unselectedIcon,
    String label,
  ) {
    final isSelected = index == selectedIndex;

    return InkWell(
      onTap: () => onTabSelected(index),
      borderRadius: BorderRadius.circular(30),
      child: AnimatedContainer(
        constraints: BoxConstraints(
          minWidth: isSelected ? 80 : 35,
          maxWidth: isSelected ? 130 : 64,
        ),
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              constraints: BoxConstraints(
                minHeight: 35,
                minWidth: isSelected ? 50 : 40,
                maxWidth: isSelected ? 130 : 64,
              ),
              decoration: BoxDecoration(
                color: isSelected ? Theme.of(context).colorScheme.primary.withValues(alpha: 0.1) : Colors.transparent,
                borderRadius: BorderRadius.circular(30),
              ),
              width: 24,
              height: 24,
              child: isSelected ? selectedIcon : unselectedIcon,
            ),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).colorScheme.primary,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
