import 'package:chaty/models/chat_user_model.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ChatPage extends ConsumerStatefulWidget {
  const ChatPage({super.key, required this.user});

  final ChatUserModel user;

  @override
  ConsumerState<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends ConsumerState<ChatPage> {
  late TextEditingController messageController;

  ///This is alternative method instead of using setState
  final _cameraIconNotifier = ValueNotifier<bool>(true);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _cameraIconNotifier.value = true;
    messageController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _cameraIconNotifier.dispose();
    messageController.dispose();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          flexibleSpace: ChatAppBar(
            user: widget.user,
          ),
        ),
        body: Stack(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: 1001,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  print("This is index of $index");
                  return ListTile(
                  title: Text("This is message  $index"),
                );
                },
            ),
            ),


            ///Bottom (TextField & Send Message Button)
            Align(
              alignment: Alignment.bottomCenter,
              child: BottomFieldsCard(
                  cameraIconNotifier: _cameraIconNotifier,
                  messageController: messageController),
            ),
          ],
        ),
      ),
    );
  }
}

///-----///
class BottomFieldsCard extends StatelessWidget {
  const BottomFieldsCard({
    super.key,
    required ValueNotifier<bool> cameraIconNotifier,
    required this.messageController,
  }) : _cameraIconNotifier = cameraIconNotifier;

  final ValueNotifier<bool> _cameraIconNotifier;
  final TextEditingController messageController;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 1.2.w),
      margin: EdgeInsets.only(bottom: 1.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          ///Card
          Expanded(
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              color: Theme.of(context).cardColor,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  ///Emoji Button
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.emoji_emotions,
                        color: Theme.of(context).iconTheme.color),
                  ),

                  ///TextField
                  ValueListenableBuilder(
                    valueListenable: _cameraIconNotifier,
                    builder: (context, value, child) => Expanded(
                      child: Scrollbar(
                        child: TextField(
                          style: GoogleFonts.abel(),
                          controller: messageController,
                          autofocus: false,
                          keyboardType: TextInputType.multiline,
                          maxLines: 6,
                          minLines: 1,
                          onChanged: (value) {
                            ///if TextField value is empty make camera icon visible
                            _cameraIconNotifier.value = value.isEmpty;
                          },
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "Type Something",
                              hintStyle:
                                  TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ),
                  ),

                  ///Gallery Icon
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.photo,
                        color: Theme.of(context).iconTheme.color),
                  ),

                  ///Camera Icon
                  ValueListenableBuilder(
                    valueListenable: _cameraIconNotifier,
                    builder: (context, value, child) => Visibility(
                      visible: value,
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.camera,
                            color: Theme.of(context).iconTheme.color),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          ///Send Buttton
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 2.w),
            child: Card(
              margin: EdgeInsets.zero,
              elevation: 1,
              shape: const CircleBorder(),
              child: CircleAvatar(
                  // radius: .w,
                  backgroundColor: Theme.of(context).iconTheme.color,
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.send),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}

///-----///
class ChatAppBar extends StatelessWidget {
  ChatAppBar({super.key, required this.user});

  ChatUserModel user;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 4.h),
      child: Row(
        children: [
          ///Back Button
          IconButton(
              icon: const Icon(CupertinoIcons.back),
              onPressed: () {
                Navigator.pop(context);
              }),

          SizedBox(
            width: 3.w,
          ),

          ///User Image
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: ExtendedImage.network(
              height: 12.2.w,
              width: 12.2.w,
              user.image,
              fit: BoxFit.cover,
            ),
          ),

          SizedBox(
            width: 4.w,
          ),

          ///User Name && other user status
          Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ///Username & Blue Tick Icon
              Row(
                children: [
                  Text(
                    user.name,
                    style: TextStyle(
                      fontSize: 18.sp,
                    ),
                  ),
                  if (user.blueTick)
                    Icon(
                      Icons.verified,
                      size: 18.sp,
                      color: Color(int.parse('0xFF${user.blueTickColor}')),
                    ),
                ],
              ),
              if (user.isOnline) const Text("online"),
              if (user.isOnline == false)
                Text(
                  "offline",
                  style:
                      TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400),
                ),
            ],
          ),

          const Spacer(),

          ///More Button
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
    );
  }
}

///-------Providers---------///
