import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


import '../../../../../main.dart';
import '../../../../backend/apis/methods.dart';
import '../models/get_results.dart';
import '../models/get_transactions.dart';
import '../models/profile.dart';

class MoneyStarMethods {
  final String token = "MNAHBOHDHNHSDEBAYSNBTNHAJHVR";
  final String baseUrl = "https://moneyheist.live/APIs/app.asmx";

  Future<void> addTransactions(
      {required String amount,
      required String status,
      required String phone}) async {
    final url = Uri.parse(
        '$baseUrl/AddTransactionAll?token=$token&Amount=$amount&Status=$status&phone=$phone');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      log("transaction added");
    } else {
      logPrint(response.body);
    }
  }

  Future<bool> registerAndLogin(
      {required String password, required String phone}) async {
    final url = Uri.parse(
        '$baseUrl/RegisterLogin?token=$token&phone=$phone&Password=$password');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final msg = jsonDecode(response.body)["message"];
      if (msg == "Wrong Password!") {
        return false;
      } else {
        return true;
      }
    } else {
      return false;
    }
  }

  Future<void> updateWallet(
      {required String amount, required String phone}) async {
    final email = await AppServices.getEmail();
    AppServices.updateWalletBalance(email, amount,"");
  }

  Future<List<GetProfile>> getProfile(String phone) async {
    final wallet = await AppServices.getWallet();

    final profileData = GetProfile(
        id: 1,
        phone: phone,
        passwords: "",
        balance: wallet[0].balance,
        atype: "User");
    return [profileData];
  }

  Future<List<GetTransactions>> getTransactions(
      String phone, String status) async {
    http.Response response = await http.get(
      Uri.parse(
          '$baseUrl/GetTransactionAll?token=$token&phone=$phone&Status=$status'),
    );

    if (response.statusCode == 200) {
      return getTransactionsFromMap(response.body);
    } else {
      log("error while getting rounds from api");
      throw '';
    }
  }

  Future<List<GetResults>> getResults() async {
    http.Response response = await http.get(
      Uri.parse('$baseUrl/WiningProbability?token=$token'),
    );

    if (response.statusCode == 200) {
      return getResultsFromMap(response.body);
    } else {
      log("error while getting rounds from api");
      throw response.body;
    }
  }
}
