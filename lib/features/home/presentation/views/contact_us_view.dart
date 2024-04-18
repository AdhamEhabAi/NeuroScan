import 'package:animation/core/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContactUsView extends StatelessWidget {
  const ContactUsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.exit_to_app_rounded)),
        title: const Text(
          'Contact Us',
        ),
        actions: const [
          ImageIcon(AssetImage(kLogo), size: 100),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Row(
              children: [
                Text(
                  'Hello There!',
                  style: TextStyle(fontSize: 24),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Got feedback or suggestions? We\'d love to hear from you! Contact us and let us know how we can improve.',
              style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20,
            ),
            Column(
              children: [
                const Icon(Icons.email_outlined,size: 70,),
                const Text('Adhame962@gmail.com'),
                const SizedBox(
                  height: 20,
                ),

                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 2,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(.3),
                  ),
                ),

              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Column(
              children: [
                const Icon(Icons.phone,size: 70,),
                const Text('(+20)1287333487'),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 2,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(.3),
                  ),
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }
}
