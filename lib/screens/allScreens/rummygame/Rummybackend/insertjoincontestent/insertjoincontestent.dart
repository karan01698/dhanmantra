import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../../../main.dart';

class InsertJoinContestent extends GetxController{
  final isLoading = false.obs;
  final message = ''.obs;

  Future<void> InsertJoinContest ({
    required String token,
    required String TournamentId,
    required String title,
    required String StartTime,
    required String Entryfee,
    required String Prizepool,
    required String TotalSeats,
    required String JoinedSeats,
    required String DurationInMinute,
    required String TotalWinner,
    required String FirstPrizeDescription,
    required String Phone,
}) async {
    final url = Uri.parse('https://dhanmantragame.com/APIs/WebService1.asmx/InsertJoinContestents');

  try{
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: {
        'token':token,
        'TournamentID':TournamentId,
        'Title':title,
        'StartTime':StartTime,
        'EntryFee':Entryfee,
        'PrizePool':Prizepool,
        'TotalSeats':TotalSeats,
        'JoinedSeats':JoinedSeats,
        'DurationInMins':DurationInMinute,
        'TotalWinners':TotalWinner,
        'FirstPrizeDescription':FirstPrizeDescription,
        'Phone':Phone,
      }
    );
    if(response.statusCode == 200){
      logPrint("✅ Successfully joined");
      logPrint(response.body);
    }
  }
  catch (e) {
    logPrint('❌ Exception while joining $e');
  }
  }
}