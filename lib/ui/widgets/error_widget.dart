import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class ServerErrorWidget extends StatelessWidget {
  const ServerErrorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxHeight: 250),
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      alignment: Alignment.center,
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.grey.withValues(alpha: 0.6))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 45,
        children: [
          SvgPicture.asset(
            "assets/svg/server-error.svg",
          ),
          Text(
            "Server Error Codes 5XX",
            maxLines: 1,
            style: GoogleFonts.poppins(
              color: Colors.orange,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      ),
    );
  }
}
