import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_android_flutter/core/models/post.dart';
import 'package:test_android_flutter/core/models/user.dart';

class PostItemWidget extends StatelessWidget {
  final Post post;
  final User user;

  const PostItemWidget({super.key, required this.post, required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsetsDirectional.only(bottom: 8),
      padding: EdgeInsetsDirectional.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadiusDirectional.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            spacing: 8,
            children: [
              SvgPicture.asset(
                "assets/svg/user.svg",
                height: 31,
                width: 31,
              ),
              Text(
                user.name ?? "Leanne Graham",
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff1864D3),
                ),
                maxLines: 1,
                overflow: TextOverflow.visible,
              )
            ],
          ),
          SizedBox(
            height: 4,
          ),
          Text(
            post.title ?? "sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w500,
              fontSize: 10,
              color: Colors.black,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(
            height: 4,
          ),
          Text(
            post.body ?? "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto",
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w400,
              fontSize: 10,
              color: Colors.grey.shade800,
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(
            height: 4,
          ),
          Row(
            spacing: 8,
            children: [
              SvgPicture.asset(
                "assets/svg/post-icon.svg",
                height: 11,
                width: 11,
              ),
              Text(
                "POST ID : ${post.id}",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  fontSize: 10,
                  color: Color(0xff8696BB),
                ),
                maxLines: 1,
              ),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
                foregroundColor: Color(0xff4894FE),
                backgroundColor: Colors.blue.shade50,
                elevation: 0,
                fixedSize: Size(
                  double.maxFinite,
                  31,
                ),
              ),
              onPressed: () => context.goNamed("details", extra: {"post": post, "user": user}),
              child: Text(
                "Details",
                style: GoogleFonts.poppins(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                ),
              )),
        ],
      ),
    );
  }
}
