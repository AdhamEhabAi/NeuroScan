class ErrorModel{
  final String error;

  ErrorModel({required this.error});
  factory ErrorModel.fromJson(Map<String,dynamic> data){
    return ErrorModel(error: data['error']);
  }
}