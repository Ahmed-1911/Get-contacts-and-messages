import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_contacts_messages/presentation/screens/widgets/custom_loading.dart';

import '../../core/utils/colors_utils.dart';
import '../viewModel/contact&message/contacts_messages_model.dart';

class Splash extends ConsumerStatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  SplashState createState() => SplashState();
}

class SplashState extends ConsumerState<Splash> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        SchedulerBinding.instance.addPostFrameCallback(
          (timeStamp) async {
            ///get contacts & messages
            final contactsListProvider = ref.read(contactsProvider.notifier);
            await contactsListProvider.getContactList(context);
            if (context.mounted) {
              await contactsListProvider.getMessagesList(context);
            }
          },
        );
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context,) {
    List list =ref.watch(contactsProvider).messagesList;
    return Scaffold(
      body: Container(
        height: 1.sh,
        width: 1.sw,
        alignment: Alignment.center,
        decoration: const BoxDecoration(color: ColorsUtils.kPrimaryColor),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              child: Customloading(
                color: ColorsUtils.whiteColor,
                width: 30.w,
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Text(
              'please wait....',
              style: TextStyle(
                color: ColorsUtils.whiteColor,
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              list.length.toString(),
              style: TextStyle(
                color: ColorsUtils.whiteColor,
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
