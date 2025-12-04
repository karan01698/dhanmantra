import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../../main.dart';
import 'GetPrizeModel.dart';

class GetPrizeDistribuition {
  static Future<List<PrizeDistributionModel>> fetchprizedistribution () async {
    final url = Uri.parse("https://dhanmantragame.com/APIs/WebService1.asmx/GetPrizeDis");

    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
      },
      body: {
        "token": "BETLAJDNDNDBARKXTER",
        "ContestentsID": "1234",
      },
    );
    
    logPrint("status code : ${response.statusCode}");
    logPrint("Raw response : \n ${response.body}");

    if(response.statusCode == 200){
      final List<dynamic> jsonData = jsonDecode(response.body);
      final prizeDis = jsonData.map((item) => PrizeDistributionModel.fromJson(item)).toList();
      logPrint("✅ Parsed Tournament List: ${prizeDis.length} items");
      return prizeDis;
    }else{
      throw Exception('❌ Failed to load tournaments. Status: ${response.statusCode}');
    }
  }
}