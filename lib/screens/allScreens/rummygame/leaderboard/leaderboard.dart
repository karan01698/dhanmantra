import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sattagames/constants/colors.dart';
import '../../../../utils/responsvie_web_mobile.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

  final List<Map<String, dynamic>> mockData = const [
    {"name": "Rohit Sharma", "points": 3200},
    {"name": "Virat Kohli", "points": 2800},
    {"name": "MS Dhoni", "points": 2500},
    {"name": "Hardik Pandya", "points": 2200},
    {"name": "KL Rahul", "points": 1800},
    {"name": "Suryakumar Yadav", "points": 1600},
    {"name": "Shubman Gill", "points": 1400},
    {"name": "Your Name", "points": 1000}, // Highlight this as current user
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // App Bar with gradient background
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                vertical: ResponsiveHelpers.h(20),
                horizontal: ResponsiveHelpers.w(20),
              ),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF2E3192), Color(0xFF1BFFFF)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Text(
                "Leaderboard",
                style: TextStyle(
                  fontSize: ResponsiveHelpers.sp(24),
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),

            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.all(ResponsiveHelpers.w(16)),
                itemCount: mockData.length,
                itemBuilder: (context, index) {
                  final item = mockData[index];
                  final isCurrentUser = item['name'] == "Your Name";

                  return Container(
                    margin: EdgeInsets.only(bottom: ResponsiveHelpers.h(12)),
                    padding: EdgeInsets.symmetric(
                      vertical: ResponsiveHelpers.h(12),
                      horizontal: ResponsiveHelpers.w(16),
                    ),
                    decoration: BoxDecoration(
                      color: isCurrentUser ? Colors.green[50] : Colors.white,
                      borderRadius: BorderRadius.circular(ResponsiveHelpers.r(12)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 6,
                          offset: Offset(0, 3),
                        ),
                      ],
                      border: isCurrentUser
                          ? Border.all(color: Colors.green, width: 1.5)
                          : Border.all(color: Colors.grey.shade200),
                    ),
                    child: Row(
                      children: [
                        _buildRankIcon(index),
                        SizedBox(width: ResponsiveHelpers.w(12)),
                        Expanded(
                          child: Text(
                            item['name'],
                            style: TextStyle(
                              fontSize: ResponsiveHelpers.sp(16),
                              fontWeight: isCurrentUser ? FontWeight.bold : FontWeight.w500,
                              color: isCurrentUser ? Colors.green : Colors.black,
                            ),
                          ),
                        ),
                        Text(
                          "${item['points']} pts",
                          style: TextStyle(
                            fontSize: ResponsiveHelpers.sp(14),
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRankIcon(int index) {
    if (index == 0) {
      return Icon(Icons.emoji_events, color: Colors.amber, size: ResponsiveHelpers.sp(28));
    } else if (index == 1) {
      return Icon(Icons.emoji_events, color: Colors.grey, size: ResponsiveHelpers.sp(28));
    } else if (index == 2) {
      return Icon(Icons.emoji_events, color: Colors.brown, size: ResponsiveHelpers.sp(28));
    } else {
      return CircleAvatar(
        radius: ResponsiveHelpers.r(14),
        backgroundColor: Colors.blueAccent,
        child: Text(
          "${index + 1}",
          style: TextStyle(
            color: Colors.white,
            fontSize: ResponsiveHelpers.sp(12),
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }
  }
}
