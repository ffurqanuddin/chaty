import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../widgets/customprofiletextfield_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController aboutController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    usernameController;
    aboutController;
    formKey;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      ///-------AppBar--------///
      appBar: AppBar(
        title: Text(
          "ffurqanuddin@gmail.com",
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 18.sp,
          ),
        ),
      ),

      ///----------Body---------///
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 2.h,
              ),

              ///Profile Image Change
              Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Circular Avatar
                    CircleAvatar(
                      radius: 25.w,
                      child: ExtendedImage.network(
                          width: 49.w,
                          height: 49.w,
                          shape: BoxShape.circle,
                          "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?auto=format&fit=crop&q=80&w=2670&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                          borderRadius: BorderRadius.circular(25.w),
                          fit: BoxFit.cover),
                    ),
                    // Username text positioned around the avatar
                    Positioned(
                      bottom: 3.w,
                      right: 3.w,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.camera_alt,
                              size: 21.sp,
                              color: Colors.black,
                            )),
                      ),
                    ),
                  ],
                ),
              ),

              ///-------Username------///
              CustomProfileTextField(
                controller: usernameController,
                prefixIcon: Icons.person,
                hintText: "Furqan Uddin",
                labelText: "Username",
                validatorText: "Please fill the username field",
              ),

              ///---------About---------///
              CustomProfileTextField(
                controller: aboutController,
                validatorText: "Please fill the about field",
                hintText: "Hey, I'm using Chaty Chat",
                labelText: "About",
                prefixIcon: Icons.account_box_outlined,
                maxLines: 6,
                minLines: 1,
                textInputType: TextInputType.multiline,
              ),

              SizedBox(
                height: 2.h,
              ),

              ///----------Save Changes----------///
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(85.w, 6.5.h),
                ),
                child: const Text(
                  "Save Changes",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
