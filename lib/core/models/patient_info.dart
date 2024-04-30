class PatientInfo {
  final String fName, lName;
  final double age;
  final bool isMale;
  final String date;
  final String disease;
  String? result;
  final String userId;
  final String userNumber;

  PatientInfo(
      {required this.fName,
       required this.userNumber,
      required this.userId, this.result,
      required this.lName,
      required this.date,
      required this.disease,
      required this.age,
      required this.isMale});
}
