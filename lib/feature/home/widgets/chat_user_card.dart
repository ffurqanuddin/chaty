
import 'package:chaty/models/chat_user_model.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ChatUserCard extends StatelessWidget {
  ChatUserCard({super.key, required this.user});

  ChatUserModel user;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.5.h),
      child: Card(
        elevation: 1,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: ListTile(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),

          ///Profile Image
          leading: CircleAvatar(
              radius: 25,
              // backgroundColor: Colors.transparent,
              child: ExtendedImage.network(
                user.image,
                cache: true,
                border: Border.all(color: Colors.black, width: 1.0),
                shape: BoxShape.circle,
                fit: BoxFit.cover,
                borderRadius: const BorderRadius.all(Radius.circular(30.0)),
              )),

          ///Profile Name & Blue Tick
          title: Row(
            children: [
              Text(
                user.name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),

              ///If user verified
              if (user.blueTick)
                Icon(
                  Icons.verified,
                  color: Color(int.parse('0xFF${user.blueTickColor}')),
                  // color: Colors.blue,
                  size: 18.sp,
                ),
            ],
          ),

          ///Message
          subtitle: Text(
            user.about,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            // style: GoogleFonts.poppins(color: Colors.black54, fontSize: 16.sp),
          ),

          ///Time
          trailing: const Text(
            "12:30 pm",
          ),
        ),
      ),
    );
  }
}
