import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';


Future<void> openWhatsApp(String phoneNumber) async {
  PermissionStatus status = await Permission.phone.request();

  if (status.isGranted) {
    try {
      String url = 'https://wa.me/$phoneNumber';
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  } else if (status.isPermanentlyDenied) {
    Get.snackbar(
      'Permission Denied',
      'Please grant phone permission from settings to open WhatsApp',
      snackPosition: SnackPosition.BOTTOM,
      mainButton: TextButton(
        onPressed: () {
          openAppSettings();
        },
        child: const Text('Open Settings'),
      ),
    );
  } else {
    Get.snackbar(
      'Permission Denied',
      'Please grant phone permission to open WhatsApp',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}

Future<void> makePhoneCall(String phoneNumber) async {
  PermissionStatus status = await Permission.phone.request();

  if (status.isGranted) {
    try {
      final Uri launchUri = Uri(
        scheme: 'tel',
        path: phoneNumber,
      );
      if (await canLaunchUrl(launchUri)) {
        await launchUrl(launchUri);
      } else {
        throw 'Could not launch $launchUri';
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  } else if (status.isPermanentlyDenied) {
    Get.snackbar(
      'Permission Denied',
      'Please grant phone permission from settings to make calls',
      snackPosition: SnackPosition.BOTTOM,
      mainButton: TextButton(
        onPressed: () {
          openAppSettings();
        },
        child: const Text('Open Settings'),
      ),
    );
  } else {
    Get.snackbar(
      'Permission Denied',
      'Please grant phone permission to make calls',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}