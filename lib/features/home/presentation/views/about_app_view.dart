import 'package:animation/core/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AboutAppView extends StatelessWidget {
  const AboutAppView({super.key});

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
        title: const Text('About App',),
        actions: const [
          ImageIcon(AssetImage(kLogo),size: 100),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('App Name',style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),),
                  const SizedBox(height: 16,),
                  const Text('NeuroScan',style: TextStyle(fontSize: 16),),
                  const SizedBox(height: 20,),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 2,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(.3),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('App Description',style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),),
                  const SizedBox(height: 16,),
                  const Text('NeuroScan is a comprehensive health application designed to assist users in monitoring and detecting three major neurological conditions: Alzheimer\'s disease, brain tumors, and autism. With its intuitive interface and advanced diagnostic tools, NeuroScan empowers individuals to take control of their neurological health and well-being.',style: TextStyle(fontSize: 16),),
                  const SizedBox(height: 20,),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 2,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(.3),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Software Release date',style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),),
                  const SizedBox(height: 16,),
                  const Text('YYYY/MM/DD',style: TextStyle(fontSize: 16),),
                  const SizedBox(height: 20,),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 2,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(.3),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Software Version',style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),),
                  const SizedBox(height: 16,),
                  const Text('1.0',style: TextStyle(fontSize: 16),),
                  const SizedBox(height: 20,),
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
      ),
    );
  }
}
