import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_android_flutter/core/models/post.dart';
import 'package:test_android_flutter/core/models/user.dart';

class PostDetailsScreen extends StatelessWidget {
  final Post post;
  final User user;

  const PostDetailsScreen({
    super.key,
    required this.post,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        shape: RoundedRectangleBorder(side: BorderSide(color: Colors.black.withValues(alpha: 0.2))),
        backgroundColor: Colors.white,
        title: Text(
          "Post details",
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
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
              height: 13,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 4,
              children: [
                Text(
                  "Title :",
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  post.title ?? "sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
                  style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w400, color: Color(0xff233453)),
                ),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Divider(
              color: Color(0xffC3D3E2),
              thickness: 0.5,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 4,
              children: [
                Text(
                  "body :",
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  post.body ??
                      "est rerum tempore vitae\nsequi sint nihil reprehenderit dolor beatae ea dolores neque\nfugiat blanditiis voluptate porro vel nihil molestiae ut reiciendis\nqui aperiam non debitis possimus qui neque nisi nulla",
                  style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w400, color: Color(0xff233453)),
                ),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Divider(
              color: Color(0xffC3D3E2),
              thickness: 0.5,
            ),
            SizedBox(
              height: 4,
            ),
            Row(
              spacing: 10,
              children: [
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
                        fontSize: 12,
                        color: Color(0xff8696BB),
                      ),
                      maxLines: 1,
                    ),
                  ],
                ),
                Row(
                  spacing: 8,
                  children: [
                    SvgPicture.asset(
                      "assets/svg/userid-icon.svg",
                      height: 11,
                      width: 11,
                    ),
                    Text(
                      "USER ID : ${post.userId}",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        color: Color(0xff8696BB),
                      ),
                      maxLines: 1,
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
