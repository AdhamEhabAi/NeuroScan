import 'package:flutter/material.dart';

class PatientWidget extends StatelessWidget {
  const PatientWidget({super.key, required this.name, required this.disease, required this.date, required this.result, required this.onTap, required this.delete});
  final String name,disease,date,result;
  final VoidCallback onTap;
  final VoidCallback delete;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: 70,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(color: Colors.white.withOpacity(.7)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  const CircleAvatar(
                    backgroundImage: AssetImage('assets/images/user.png'),
                    radius: 16,
                    backgroundColor: Colors.white,
                  ),
                  const SizedBox(width: 10,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(name,style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.ellipsis,
                          fontSize: 18
                      ),),
                      Text(disease,style:const TextStyle(
                          fontSize: 14,
                          color: Colors.grey
                      ),),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Text(date),
                  Text(result,style: const TextStyle(
                      color: Colors.redAccent
                  ),),
                ],
              ),
            ),
            Row(
                children: [
                IconButton(onPressed: delete, icon: const Icon(Icons.delete,size: 18,)),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Container(
                    width: 1,
                    height: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(.3)
                    ),
                  ),
                ),
                IconButton(onPressed: onTap, icon: const Icon(Icons.arrow_forward_ios_outlined,size: 18,))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
