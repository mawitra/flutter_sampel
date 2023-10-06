// ignore_for_file: prefer__ructors, prefer_const_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:testing/screens/auth/reset_pasword_page.dart';
import 'package:testing/screens/auth/register_page.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

GlobalKey<FormState> _formKey = GlobalKey<FormState>();

class _LoginPageState extends State<LoginPage> {
  late Color myColor;
  late Size mediaSize;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isPasswordVisible = false;
  @override
  Widget build(BuildContext context) {
    myColor = Color.fromRGBO(232, 130, 32, 10);
    mediaSize = MediaQuery.of(context).size;

    return Container(
      decoration: BoxDecoration(
        color: myColor,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Positioned(child: _buildTop()),
              Positioned(child: _buildBottom()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTop() {
    return SizedBox(
      width: mediaSize.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment
            .end, // Untuk mengatur posisi gambar dan teks ke atas
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image(
            image: AssetImage(
              'assets/images/hadirbosz.png',
            ),
            width: 150.w,
            height: 225.h,
          ),
          Container(
            color: Colors.white,
            width: 40,
            height: 4,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'LOGIN',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            color: Colors.white,
            width: 40,
            height: 4,
          ),
          SizedBox(
            height: 45,
          )
        ],
      ),
    );
  }

  Widget _buildBottom() {
    return SizedBox(
      width: mediaSize.width,
      child: Column(
        children: [
          Container(
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: _buildForm(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildForm() {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome",
              style: TextStyle(
                color: myColor,
                fontSize: 30,
                fontWeight: FontWeight.w500,
              ),
            ),
            _buildGreyText("Please login with your information"),
            SizedBox(height: 35),
            _buildInputField(
              emailController,
              hintText: "Username/Nomor Whatsapp",
              icon: Icons.person, // Tambahkan ikon person di sini
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'This field is required';
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            _buildPasswordInputField(
              controller: passwordController, // Tambahkan controller di sini
              hintText: "Password",
              icon: Icons.lock,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'This field is required';
                }
                return null;
              },
            ),
            SizedBox(height: 5),
            _buildRememberForgot(),
            SizedBox(height: 10),
            _buildLoginButton(),
            SizedBox(height: 20),
            _buildOtherLogin(),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField(
    TextEditingController controller, {
    IconData? icon,
    String? hintText,
    String? Function(String?)? validator,
    bool obscureText = false,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: icon != null ? Icon(icon) : null,
      ),
      obscureText: obscureText,
      validator: validator,
    );
  }

  Widget _buildGreyText(String text) {
    return Text(
      text,
      style: TextStyle(color: Colors.grey),
    );
  }

  Widget _buildPasswordInputField({
    required TextEditingController controller,
    required String? Function(String?)? validator,
    String? hintText,
    IconData? icon, // Tambahkan parameter icon
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: icon != null ? Icon(icon) : null, // Tambahkan ikon di sini
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              isPasswordVisible = !isPasswordVisible;
            });
          },
          child: Icon(
            isPasswordVisible ? Icons.visibility : Icons.visibility_off,
          ),
        ),
      ),
      obscureText: !isPasswordVisible,
      validator: validator,
    );
  }

  Widget _buildRememberForgot() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          onPressed: () {
            // Provide the logic you want to execute when the button is pressed here
            // For example, you can navigate to the password reset page.
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => ResetpwPage()));
          },
          child: _buildGreyText("Lupa password ?"),
        )
      ],
    );
  }

  Widget _buildLoginButton() {
    return ElevatedButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          // If the form is valid, continue with your login logic
          debugPrint("Email : ${emailController.text}");
          debugPrint("Password : ${passwordController.text}");
        }
      },
      style: ElevatedButton.styleFrom(
        shape: StadiumBorder(),
        elevation: 20,
        shadowColor: myColor,
        minimumSize: Size.fromHeight(50),
        backgroundColor: Colors.brown,
      ),
      child: Text("LOGIN"),
    );
  }

  Widget _buildOtherLogin() {
    return Center(
      child: Column(
        children: [
          _buildGreyText("Or Login with"),
          SizedBox(height: 5),
          TextButton(
            onPressed: () {
              // Add your navigation logic here to redirect to the registration page
              // For example:
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    RegisterPage(), // Replace with your registration page
              ));
            },
            child: Text(
              "Belum punya akun? Daftar sekarang!",
              style: TextStyle(
                color: myColor, // You can customize the color
              ),
            ),
          ),
        ],
      ),
    );
  }
}
