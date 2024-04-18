class PatientInfo {
  final String fName, lName;
  final double age;
  final bool isMale;
  final String date;
  final String disease;
  final String result;
  final String userId;

  PatientInfo(
      {required this.fName,
      required this.userId,
      required this.result,
      required this.lName,
      required this.date,
      required this.disease,
      required this.age,
      required this.isMale});
}
