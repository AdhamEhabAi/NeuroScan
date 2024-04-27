import 'package:flutter/material.dart';

class SinglePatientHeaderWidget extends StatelessWidget {
  const SinglePatientHeaderWidget({super.key});

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
                Text('Adham Ehab',style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 24,
                ),),
                Row(
                  children: [
                    IconButton(onPressed: (){}, icon: Icon(Icons.send_outlined)),
                    IconButton(onPressed: (){}, icon: Icon(Icons.call_outlined)),

                  ],
                ),
              ],
            ),
            Row(
              children: [
                Text('22 yrs, male . '),
                Text('Mar 14 2024'),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              children: [
                Text('Phone number : '),
                Text('01287333487'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}