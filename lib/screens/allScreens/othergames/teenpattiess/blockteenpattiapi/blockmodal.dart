class UpdateUserStatusResponse {
  final String message;

  UpdateUserStatusResponse({required this.message});

  factory UpdateUserStatusResponse.fromJson(Map<String, dynamic> json) {
    return UpdateUserStatusResponse(message: json['message']);
  }
}
