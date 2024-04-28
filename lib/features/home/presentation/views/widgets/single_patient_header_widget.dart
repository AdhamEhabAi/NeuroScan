import 'package:animation/core/utils/functions.dart';
import 'package:flutter/material.dart';

class SinglePatientHeaderWidget extends StatelessWidget {
  const SinglePatientHeaderWidget(
      {super.key,
      required this.fName,
      required this.lName,
      required this.age,
      required this.date,
      required this.pNumber,
      required this.isMale});
  final String fName, lName, age, date, pNumber;
  final bool isMale;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Color(0xffD3E7EE),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${fName} ${lName}',
                  style: TextStyle(
                    overflow: TextOverflow.ellipsis,
                    fontWeight: FontWeight.w400,
                    fontSize: 24,
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          openWhatsAppChat(phoneNumber:  pNumber);
                        }, icon: Icon(Icons.send_outlined)),
                    IconButton(
                        onPressed: () {
                          makePhoneCall(phoneNumber: pNumber);
                        }, icon: Icon(Icons.call_outlined)),
                  ],
                ),
              ],
            ),
            Row(
              children: [
                Text('${age} yrs, ${isMale} . '),
                Text('${date}'),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text('Phone number : '),
                Text('${pNumber}'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
