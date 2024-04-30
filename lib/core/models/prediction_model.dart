
class PredictionModel {
  final String prediction;

  PredictionModel({required this.prediction});
  factory PredictionModel.fromJson(Map<String, dynamic> data) {
    return PredictionModel(
      prediction: data['prediction'],
    );
  }
}
