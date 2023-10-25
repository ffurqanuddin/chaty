import 'package:chaty/feature/home/ui/home_page.dart';
import 'package:chaty/helper/helper.dart';
import 'package:chaty/middleware/firestore_middleware.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../widgets/customprofiletextfield_widget.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController aboutController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

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
                  aboutController: aboutController),
            ],
          ),
        ),
      ),
    );
  }
}

////////-------Save Changes Button--------///////////
class SaveChangesButton extends StatelessWidget {
  const SaveChangesButton({
    super.key,
    required this.usernameController,
    required this.aboutController,
  });

  final TextEditingController usernameController;
  final TextEditingController aboutController;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Helper.showLoadingDialogBox(context);
        if (usernameController.text.isNotEmpty &&
            usernameController.text != "" &&
            usernameController.text != " ") {
          FirestoreMiddleWare()
              .updateCurrentUserUsername(username: usernameController.text);
        }

        if (aboutController.text.isNotEmpty &&
            aboutController.text != "" &&
            aboutController.text != " ") {
          FirestoreMiddleWare()
              .updateCurrentUserAbout(about: aboutController.text);
        }

        ///Close Loading DialogBox
        Navigator.pop(context);

        ///Back to Home
        Navigator.pop(context);
        Navigator.pop(context);
      },
      style: ElevatedButton.styleFrom(
        fixedSize: Size(85.w, 6.5.h),
      ),
      child: const Text(
        "Save Changes",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}
