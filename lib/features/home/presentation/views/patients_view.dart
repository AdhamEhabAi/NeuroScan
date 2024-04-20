import 'package:animation/core/utils/constants.dart';
import 'package:animation/core/utils/functions.dart';
import 'package:animation/features/home/presentation/views/widgets/patient_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PatientsView extends StatelessWidget {
  const PatientsView({super.key});

  @override
  Widget build(BuildContext context) {
    CollectionReference patients =
        FirebaseFirestore.instance.collection('patients');
    String? userId = FirebaseAuth.instance.currentUser?.uid;


    return Scaffold(
      backgroundColor: const Color(0xffD3E7EE),
      appBar: AppBar(
        backgroundColor: const Color(0xffD3E7EE),
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.exit_to_app_rounded),
        ),
        title: const Text(
          'PATIENTS',
          style: TextStyle(letterSpacing: 2),
        ),
        actions: const [
          ImageIcon(
            AssetImage(kLogo),
            size: 120,
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: patients.where('userId',isEqualTo: userId).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Something went wrong'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if(snapshot.data!.docs.isEmpty)
          {
            return const Center(
              child: Text('No patients available',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24),),
            );
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data() as Map<String, dynamic>;
              return PatientWidget(
                delete: () {
                  patients.doc(document.id).delete();
                },
                onTap: () {
                  openWhatsAppChat(phoneNumber: data['number'] ?? '');
                },
                date: data['date'] ?? '',
                disease: data['disease'] ?? '',
                name: '${data['fName']} ${data['lName'][0].toUpperCase()+'.'}',
                result: data['result'] ?? '',
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
