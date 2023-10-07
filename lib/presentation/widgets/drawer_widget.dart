import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:photo_redactor/presentation/pages/all_works_page.dart';
import 'package:photo_redactor/presentation/pages/holst_page.dart';
import 'package:photo_redactor/presentation/providers/holst_page_provider.dart';
import 'package:photo_redactor/presentation/services/image%20notifier/image_value_notifier.dart';
import 'package:provider/provider.dart';

Drawer myDrawer(BuildContext context) {
  return Drawer(
    child: Padding(
      padding: const EdgeInsets.all(50.0),
      child: Column(children: [
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange, fixedSize: Size(500.w, 100.h)),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AllWorksPage(),
                  ),
                  (route) => false);
            },
            child: const Text('My works')),
        const SizedBox(
          height: 25,
        ),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange, fixedSize: Size(500.w, 100.h)),
            onPressed: () {
              context.read<HolstPageProvider>().imageValueNotifier =
                  ImageValueNotifier();
              context.read<HolstPageProvider>().selectAsset(false);
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HolstPage(),
                  ),
                  (route) => false);
            },
            child: const Text('WorkSpace')),
      ]),
    ),
  );
}
