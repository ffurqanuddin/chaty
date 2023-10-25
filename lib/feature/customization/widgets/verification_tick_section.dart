

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../data/customization_data.dart';

class VerificationTickSection extends StatelessWidget {
  VerificationTickSection({
    super.key,
    required this.ref
  });

  WidgetRef ref;

  @override
  Widget build(BuildContext context) {

    final mq = MediaQuery.sizeOf(context);
    VerificationTickValue currentTick =
    ref.watch<VerificationTickValue>(currentVerificationTickStateProvider);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Choose Verification Tick",
          style: GoogleFonts.abel(fontSize: 20),
        ),
        SizedBox(
          height: 1.h,
        ),
        SizedBox(
          width: double.infinity,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [

                ///Blue/Default Tick
                SizedBox(
                  width: mq.width*0.3,
                  child: RadioListTile(
                      title:  const Icon(
                        Icons.verified,

                        color: Colors.blueAccent,
                      ),
                      value: VerificationTickValue.defaultTick,
                      groupValue: currentTick,
                      onChanged: (value) {
                        ref
                            .read(currentVerificationTickStateProvider.notifier)
                            .state = value!;
                      }),
                ),

                ///Orange/Amber Tick
                SizedBox(
                  width: mq.width*0.3,
                  child: RadioListTile(
                      title:  Icon(
                        Icons.verified,
                        color: Colors.amber.shade900,
                      ),
                      value: VerificationTickValue.amber,
                      groupValue: currentTick,
                      onChanged: (value) {
                        ref
                            .read(currentVerificationTickStateProvider.notifier)
                            .state = value!;
                      }),
                ),


                ///Pink Tick
                SizedBox(
                  width: mq.width*0.3,
                  child: RadioListTile(
                      title:  const Icon(
                        Icons.verified,
                        color: Colors.pinkAccent,
                      ),
                      value: VerificationTickValue.pink,
                      groupValue: currentTick,
                      onChanged: (value) {
                        ref
                            .read(currentVerificationTickStateProvider.notifier)
                            .state = value!;
                      }),
                ),


                ///Red Tick
                SizedBox(
                  width: mq.width*0.3,
                  child: RadioListTile(
                      title:  Icon(
                        Icons.verified,
                        color: Colors.redAccent.shade700,
                      ),
                      value: VerificationTickValue.red,
                      groupValue: currentTick,
                      onChanged: (value) {
                        ref
                            .read(currentVerificationTickStateProvider.notifier)
                            .state = value!;
                      }),
                ),

                ///Green Tick
                SizedBox(
                  width: mq.width*0.3,
                  child: RadioListTile(

                      title:  Icon(
                        Icons.verified,
                        color: Colors.greenAccent.shade700,
                      ),
                      value: VerificationTickValue.green,
                      groupValue: currentTick,
                      onChanged: (value) {
                        ref
                            .read(currentVerificationTickStateProvider.notifier)
                            .state = value!;
                      }),
                ),

              ],
            ),
          ),
        )
      ],
    );
  }
}