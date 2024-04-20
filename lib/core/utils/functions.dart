import 'package:url_launcher/url_launcher.dart';


void openWhatsAppChat({required String phoneNumber}) async {
  String url = 'https://wa.me/$phoneNumber';
  if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(Uri.parse(url));
  } else {
    throw 'Could not launch $url';
  }
}