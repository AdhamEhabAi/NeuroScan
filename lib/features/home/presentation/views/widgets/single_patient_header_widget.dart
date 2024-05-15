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
      required this.isMale, required this.result});
  final String fName, lName, age, date, pNumber,result;
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
                          openWhatsApp(pNumber);
                        }, icon: Icon(Icons.send_outlined)),
                    IconButton(
                        onPressed: () {
                          makePhoneCall(pNumber);
                        }, icon: Icon(Icons.call_outlined)),
                  ],
                ),
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,

                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(result,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),),
                        Text('Result',style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text('${age} yrs, ${isMale == true ? 'Male' : 'Female'} . '),
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
