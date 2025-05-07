import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:test_android_flutter/core/provider/auth_provider.dart';
import 'package:test_android_flutter/core/provider/register_provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formRegisterKey = GlobalKey<FormState>();

  late final TextEditingController passwordController;
  late final TextEditingController confirmPasswordController;
  late final TextEditingController emailController;
  late final TextEditingController nameController;

  @override
  void initState() {
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    nameController = TextEditingController();
    emailController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsetsDirectional.symmetric(horizontal: 16),
          child: Form(
            key: _formRegisterKey,
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
                  "Create an account to get started",
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
                      "Name",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff233453),
                      ),
                    ),
                    TextFormField(
                      validator: FormBuilderValidators.required(checkNullOrEmpty: true),
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
                        hintText: "Name",
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
                      "Email Address",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff233453),
                      ),
                    ),
                    TextFormField(
                      controller: emailController,
                      validator: FormBuilderValidators.compose([FormBuilderValidators.required(checkNullOrEmpty: true), FormBuilderValidators.email(checkNullOrEmpty: true)]),
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
                        hintText: "email@email.com",
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
                    Selector<RegisterProvider, bool>(
                      selector: (context, provider) => provider.isObscure,
                      builder: (context, isObscure, child) {
                        return Column(
                          spacing: 16,
                          children: [
                            TextFormField(
                              controller: passwordController,
                              validator: FormBuilderValidators.compose([FormBuilderValidators.required(checkNullOrEmpty: true), FormBuilderValidators.minLength(6)]),
                              maxLines: 1,
                              obscureText: isObscure,
                              decoration: InputDecoration(
                                suffix: GestureDetector(
                                  onTap: () => context.read<RegisterProvider>().changeObscure(),
                                  child: Icon(
                                    isObscure ? Icons.visibility_sharp : Icons.visibility_off_sharp,
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
                                hintText: "Create a Password",
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
                            ),
                            TextFormField(
                              controller: confirmPasswordController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please Confirm Your Password";
                                } else if (value != passwordController.text) {
                                  return "Password Mismatch";
                                }
                                return null;
                              },
                              maxLines: 1,
                              obscureText: isObscure,
                              decoration: InputDecoration(
                                suffix: GestureDetector(
                                  onTap: () => context.read<RegisterProvider>().changeObscure(),
                                  child: Icon(
                                    isObscure ? Icons.visibility_sharp : Icons.visibility_off_sharp,
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
                                hintText: "Confirm Password",
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
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
                SizedBox(height: 24),
                Consumer<AuthProvider>(
                  builder: (context, authProvider, child) {
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xff1864D3),
                          foregroundColor: Colors.white,
                          fixedSize: Size(
                            double.maxFinite,
                            48,
                          ),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                      onPressed: () async {
                        if (_formRegisterKey.currentState!.validate()) {
                          await context.read<AuthProvider>().signUp(
                                emailController.text,
                                passwordController.text,
                              );
                          if (authProvider.user != null && context.mounted) {
                            context.goNamed("posts");
                          }
                        }
                      },
                      child: authProvider.isLoading
                          ? SizedBox(
                              width: 25,
                              height: 25,
                              child: const CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            )
                          : Text(
                              'Sign Up',
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                    );
                  },
                ),
                if (context.watch<AuthProvider>().error != null) ...[
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      context.watch<AuthProvider>().error!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
