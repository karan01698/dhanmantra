// models/haruf_response_model.dart
class HarufResponseModel {
  final String message;

  HarufResponseModel({required this.message});

  factory HarufResponseModel.fromJson(Map<String, dynamic> json) {
    return HarufResponseModel(message: json['message']);
  }
}
