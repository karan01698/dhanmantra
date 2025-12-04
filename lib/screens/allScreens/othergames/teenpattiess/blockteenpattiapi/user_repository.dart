import 'package:http/http.dart' as http;

class UserRepository {
  Future<String> updateUserStatus({
    required String token,
    required String roomId,
    required String userPhone,
    required String userStatus,
  }) async {
    final url = Uri.parse("https://dhanmantragame.com/APIs/WebService1.asmx/UpdateUserStatus");

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: {
        "token": token,
        "RoomID": roomId,
        "UserPhone": userPhone,
        "UserStatus": userStatus,
      },
    );

    if (response.statusCode == 200) {
      return "Updated!"; // You can parse JSON here if needed
    } else {
      throw Exception('Failed to update status');
    }
  }
}
