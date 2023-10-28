import 'dart:io';

import 'package:chaty/feature/profile/widgets/profile_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../home/widgets/home_screen_app_bar.dart';
import '../widgets/customprofiletextfield_widget.dart';
import '../widgets/save_button.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController aboutController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  ///Image
  

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    usernameController.clear();
    aboutController.clear();
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
              ProfileImageWidget(),
              

              ///-------Username------///
              CustomProfileTextField(
                controller: usernameController,
                prefixIcon: Icons.person,
                hintText: ref.watch(getCurrentUsersDataStreamProvider).when(
                          data: (data) => data["name"],
                          error: (error, stackTrace) => "username",
                          loading: () => "username",
                        ) ??
                    "username",
                labelText: "Username",
                validatorText: "Please fill the username field",
              ),

              ///---------About---------///
              CustomProfileTextField(
                controller: aboutController,
                validatorText: "Please fill the about field",
                hintText: ref.watch(getCurrentUsersDataStreamProvider).when(
                          data: (data) => data["about"],
                          error: (error, stackTrace) => "about",
                          loading: () => "Hey, I'm using Chaty!",
                        ) ??
                    "about",
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
              SaveChangesButton(
                usernameController: usernameController,
                aboutController: aboutController,
                pickedImagePath: ref.watch(pickedProfileImagePathStateProvider),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

final pickedProfileImagePathStateProvider = StateProvider<String>((ref) => "");