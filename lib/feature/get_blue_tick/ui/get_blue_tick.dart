import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class GetBlueTickPage extends StatefulWidget {
  const GetBlueTickPage({super.key});

  @override
  State<GetBlueTickPage> createState() => _GetBlueTickPageState();
}

class _GetBlueTickPageState extends State<GetBlueTickPage> {
  final formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  Gender currentGender = Gender.male;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          "Get Verification Tick Now",
          style: GoogleFonts.abhayaLibre(fontWeight: FontWeight.w500),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Form(
          key: formKey,
          child: Column(
            children: [
              ///Name Field
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomTextFieldVP(
                    hint: "Full Name",
                    icon: Icons.person,
                    controller: nameController),
              ),

              ///Phone Number Field
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IntlPhoneField(
                  controller: phoneController,
                  decoration: InputDecoration(
                    hintText: "Enter your phone number",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  initialCountryCode: 'PK',
                  onChanged: (phone) {
                    print(phone.completeNumber);
                  },
                ),
              ),

              ///Gender Selection
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Gender :",
                      style: TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 19.sp),
                    ),
                    Row(
                      children: [
                        const Text("Male"),
                        Radio(
                          value: Gender.male,
                          groupValue: currentGender,
                          onChanged: (value) {
                            currentGender = value!;
                            setState(() {});
                          },
                        ),
                        const Text("Female"),
                        Radio(
                          value: Gender.female,
                          groupValue: currentGender,
                          onChanged: (value) {
                            currentGender = value!;
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              ///Description
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: TextField(
                  maxLines: 7,
                  minLines: 1,
                  decoration: InputDecoration(
                    labelText: "Reason for Blue Tick Verification",
                    border: OutlineInputBorder(),
                    hintText:
                        "Please provide a brief explanation of why you are requesting blue tick verification. This information will help us understand your need and expedite the verification process. Note that your request should be in line with our verification criteria.",
                  ),
                ),
              ),

              SizedBox(
                height: 2.h,
              ),

              ///Request for Blue Tick
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(90.w, 5.h),
                  ),
                  onPressed: () {},
                  child: const Text("Submit Request"))
            ],
          ),
        ),
      ),
    );
  }
}

enum Gender { male, female }

class CustomTextFieldVP extends StatelessWidget {
  CustomTextFieldVP({
    required this.controller,
    required this.hint,
    required this.icon,
    super.key,
  });

  TextEditingController controller;
  String hint;
  IconData icon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onTapOutside: (event) {
        ///Hide Keyboard on Tap Outside
        FocusManager.instance.primaryFocus?.unfocus();
      },
      validator: (value) {
        if (value!.isEmpty || value == "") {
          return "please fill the field";
        }
      },
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }
}
