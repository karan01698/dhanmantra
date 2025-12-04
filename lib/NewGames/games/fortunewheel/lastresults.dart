import 'package:sattagames/NewGames/backend/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:shimmer/shimmer.dart';

// Define constant colors
const Color kBlueColor = Colors.blue;
const Color kGoldenColor = Colors.amber;

// Function to fetch only the "Result" values from API
Future<List<String>> fetchResults() async {
  const String apiUrl =
      'https://dhanmantragame.com/apis/Webservice1.asmx/GetHistoryWheel?token=RMNAJAMDNAFJNFTAMI';

  try {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((item) => item['Result'].toString()).toList();
    } else {
      throw Exception('Failed to load results');
    }
  } catch (e) {
    throw Exception('Error fetching data: $e');
  }
}

// Main Widget with StreamBuilder
class GradientBorderContainer extends StatefulWidget {
  const GradientBorderContainer({super.key});

  @override
  State<GradientBorderContainer> createState() =>
      _GradientBorderContainerState();
}

class _GradientBorderContainerState extends State<GradientBorderContainer> {
  late StreamController<List<String>> _streamController;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _streamController = StreamController<List<String>>();
    _startFetchingData();
  }

  void _startFetchingData() {
    // Fetch data initially
    _fetchAndAddResults();
    // Fetch data every 5 seconds
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      _fetchAndAddResults();
    });
  }

  void _fetchAndAddResults() async {
    try {
      List<String> results = await fetchResults();
      _streamController.add(results);
    } catch (e) {
      _streamController.addError('Failed to fetch data');
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    _streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(3), // Space between border and content
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [kBlueColor, kGoldenColor], // Gradient colors
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20), // Rounded corners
      ),
      child: Container(
        padding: const EdgeInsets.all(1), // Padding inside the border
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.8), // Background color
          borderRadius: BorderRadius.circular(23), // Rounded corners
        ),
        child: StreamBuilder<List<String>>(
          stream: _streamController.stream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return buildShimmerPlaceholder(); // Loading state
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No results found.'));
            } else {
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: snapshot.data!.reversed.map((result) {
                    // Reverse the list here
                    return ColorCircle(result: result);
                  }).toList(),
                ),
              );
            }
          },
        ),
      ),
    );
  }

  // Shimmer loading effect
  Widget buildShimmerPlaceholder() {
    return Center(
      child: Shimmer.fromColors(
        baseColor: Colors.white.withOpacity(0.2),
        highlightColor: Colors.white.withOpacity(0.5),
        child: Container(
          width: 470,
          height: 10,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.5),
          ),
        ),
      ),
    );
  }
}

// ColorCircle Widget to display each result
class ColorCircle extends StatelessWidget {
  final String result;

  const ColorCircle({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    Color circleColor;

    // Assign color based on result value
    switch (result.toLowerCase()) {
      case 'red':
        circleColor = Colors.red;
        break;
      case 'blue':
        circleColor = Colors.blue;
        break;
      case 'yellow':
        circleColor = const Color(0xffe9d270);
        break;
      default:
        circleColor = Colors.grey;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Container(
        width: 15,
        height: 15,
        decoration: BoxDecoration(
          color: circleColor,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 2),
        ),
      ),
    );
  }
}
