import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsetsDirectional.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/next-data-logo.png",
                alignment: Alignment.center,
                fit: BoxFit.contain,
                height: 90,
                width: 180,
              ),
              SizedBox(height: 44),
              Text(
                "Welcome to NextData",
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff14223A),
                ),
              ),
              SizedBox(height: 5),
              Text(
                "Login with Email",
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Colors.blueGrey.shade700,
                ),
              ),
              SizedBox(height: 24),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 8,
                children: [
                  Text(
                    "Email",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff233453),
                    ),
                  ),
                  TextFormField(
                    maxLines: 1,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blueGrey.shade700,
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xff14223A)),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      alignLabelWithHint: true,
                      errorMaxLines: 1,
                      hintText: "Email",
                      hintStyle: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Colors.blueGrey.shade700,
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blueGrey.shade700),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 18),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 8,
                children: [
                  Text(
                    "Password",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff233453),
                    ),
                  ),
                  TextFormField(
                    maxLines: 1,
                    obscureText: true,
                    decoration: InputDecoration(
                      suffix: GestureDetector(
                        onTap: () {},
                        child: Icon(
                          Icons.visibility_sharp,
                          color: Colors.blueGrey.shade700,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blueGrey.shade700,
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xff14223A)),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      alignLabelWithHint: true,
                      errorMaxLines: 1,
                      hintText: "Password",
                      hintStyle: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Colors.blueGrey.shade700,
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blueGrey.shade700),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 8),
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {},
                  child: Text(
                    "Forgot Password",
                    style: GoogleFonts.poppins(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff1864D3),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24),
              Column(
                spacing: 12,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff1864D3),
                        foregroundColor: Colors.white,
                        fixedSize: Size(
                          double.maxFinite,
                          48,
                        ),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                    onPressed: () {},
                    child: Text(
                      'Login',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Color(0xff1864D3),
                        side: BorderSide(color: Color(0xff1864D3)),
                        fixedSize: Size(
                          double.maxFinite,
                          48,
                        ),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                    onPressed: () {},
                    child: Text(
                      'Sign Up',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
