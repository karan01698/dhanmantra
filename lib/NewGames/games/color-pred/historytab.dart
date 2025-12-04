  import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../../../main.dart';
import '../../backend/utils.dart';

class DamanScreen extends StatefulWidget {
  final String type;

  const DamanScreen({super.key, required this.type});

  @override
  _DamanScreenState createState() => _DamanScreenState();
}

class _DamanScreenState extends State<DamanScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late StreamController<List<Map<String, dynamic>>> _streamController;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _streamController =
        StreamController<List<Map<String, dynamic>>>.broadcast();
    fetchHistory('1min');
    _tabController = TabController(initialIndex: 0, length: 2, vsync: this);

    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      fetchHistory(widget.type);
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _timer?.cancel();
    _streamController.close();
    super.dispose();
    super.dispose();
  }

  Future<void> fetchHistory(String type) async {
    final String url =
        'https://dhanmantragame.com/apis/WebService1.asmx/GetHistory?token=RMNAJAMDNAFJNFTAMI&roundid=$type';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);

        Map<int, Color> resultColors = {
          0: Colors.purpleAccent,
          1: Colors.red,
          2: Colors.green,
          3: Colors.red,
          4: Colors.green,
          5: Colors.purpleAccent,
          6: Colors.green,
          7: Colors.red,
          8: Colors.green,
          9: Colors.red,
        };

        List<Map<String, dynamic>> historyData = data.map((entry) {
          int result = int.tryParse(entry['Result'] ?? '0') ?? 0;
          String periodId = _formatDateTime(entry['DateTim']);

          return {
            'periodId': periodId, // Now using DateTim from API
            'result': result,
            'size': result >= 5 ? 'Big' : 'Small',
            'color': resultColors[result] ?? Colors.purple,
          };
        }).toList();

        _streamController.add(historyData);
      } else {
        logPrint("Failed to load data: ${response.statusCode}");
      }
    } catch (e) {
      logPrint("Error fetching data: $e");
    }
  }

  String _formatDateTime(String? dateTimeString) {
    if (dateTimeString == null || dateTimeString.isEmpty) {
      return DateFormat(
        'yyyyMMddHHmm',
      ).format(DateTime.now()); // Fallback if missing
    }

    try {
      DateTime parsedDate = DateFormat(
        'yyyy-MM-dd HH:mm',
      ).parse(dateTimeString);
      return DateFormat('yyyyMMddHHmm').format(parsedDate);
    } catch (e) {
      logPrint("Error parsing date: $e");
      return DateFormat('yyyyMMddHHmm').format(DateTime.now());
    }
  }


    String generatePeriodId() {
    Random random = Random();
    int randomNumber =
        random.nextInt(900000) + 100000; // Ensures a 6-digit random number
    String timestamp = DateTime.now().millisecondsSinceEpoch
        .toString()
        .substring(3, 9); // Extracts 6 digits from timestamp

    return '$timestamp$randomNumber'; // 12-digit unique ID
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.yellow.shade300,
          child: TabBar(
            controller: _tabController,
            indicatorColor: Colors.white,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.black54,
            tabs: [Tab(text: 'Game History',)],
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                    color: Colors.black54,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Period',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'Number',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'Big Small',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'Color',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: StreamBuilder<List<Map<String, dynamic>>>(
                      stream: _streamController.stream,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text(
                              "Error: ${snapshot.error}",
                              style: TextStyle(color: Colors.white),
                            ),
                          );
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return Center(
                            child: Text(
                              "No data available",
                              style: TextStyle(color: Colors.white),
                            ),
                          );
                        }

                        List<Map<String, dynamic>> historyData = snapshot.data!;

                        return ListView.builder(
                          itemCount: historyData.length,
                          itemBuilder: (context, index) {
                            var item = historyData[index];

                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 4,
                                horizontal: 8,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    item['periodId'].toString(),
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    '${item['result']}',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    item['size'],
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Icon(Icons.circle, color: item['color']),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
              // MyHistoryTab(),
            ],
          ),
        ),
      ],
    );
  }
}

class MyHistoryTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('My History Data', style: TextStyle(color: Colors.white)),
    );
  }
}
