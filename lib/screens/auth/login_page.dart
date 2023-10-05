import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:testing/screens/auth/reset_pasword_page.dart';
import 'package:testing/screens/auth/register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

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
          reverse: true,
          child: Column(
            children: [
              Positioned(top: 80, child: _buildTop()),
              Positioned(bottom: 0, child: _buildBottom()),
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
        mainAxisSize: MainAxisSize.min,
        children: [
          Image(
            image: AssetImage(
              'assets/images/hadirbosz.png',
            ),
            width: 150.w,
            height: 300.h,
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
          Card(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            )),
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: _buildForm(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey, // Set the form key
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
          const SizedBox(height: 35),
          _buildGreyText("Username/Nomor Whatsapp"),
          _buildInputField(
            emailController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'This field is required'; // Return an error message
              }
              return null; // Return null if the input is valid
              // Return null if the input is valid
            },
          ),
          const SizedBox(height: 40),
          _buildGreyText("Password"),
          _buildPasswordInputField(
            controller:
                passwordController, // Pass controller as a named argument
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'This field is required'; // Return an error message
              }
              return null; // Return null if the input is valid
            },
          ),
          const SizedBox(height: 5),
          _buildRememberForgot(),
          const SizedBox(height: 20),
          _buildLoginButton(),
          const SizedBox(height: 20),
          _buildOtherLogin(),
        ],
      ),
    );
  }

  Widget _buildGreyText(String text) {
    return Text(
      text,
      style: const TextStyle(color: Colors.grey),
    );
  }

  Widget _buildPasswordInputField({
    required TextEditingController
        controller, // Accept controller as a named argument
    required String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
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

  Widget _buildInputField(
    TextEditingController controller, {
    IconData? icon, // Add an IconData parameter for the icon
    String? hintText,
    String? Function(String?)? validator, // Add a validator function
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: icon != null ? Icon(icon) : null, // Set the icon here
      ),
      obscureText: false, // Change this as needed
      validator: validator, // Set the validator
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
        shape: const StadiumBorder(),
        elevation: 20,
        shadowColor: myColor,
        minimumSize: const Size.fromHeight(50),
        backgroundColor: Colors.brown,
      ),
      child: const Text("LOGIN"),
    );
  }

  Widget _buildOtherLogin() {
    return Center(
      child: Column(
        children: [
          _buildGreyText("Or Login with"),
          const SizedBox(height: 10),
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
