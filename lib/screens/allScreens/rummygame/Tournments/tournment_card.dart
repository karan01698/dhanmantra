import 'package:flutter/material.dart';
import 'package:get/get.dart';// Import your updated model
import '../Rummybackend/gettournament/gettournament_api.dart';
import '../Rummybackend/gettournament/tournament_model.dart';
import 'bottomsheet.dart';
import 'innertabs/free.dart';

class TournmentCard extends StatefulWidget {
  const TournmentCard({super.key});

  @override
  State<TournmentCard> createState() => _TournmentCardState();
}

class _TournmentCardState extends State<TournmentCard> {
  late Future<List<TournamentModel>> _tournamentFuture;

  @override
  void initState() {
    super.initState();
    _tournamentFuture = TournamentService.fetchTournament(); // Updated return type
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<TournamentModel>>(
        future: _tournamentFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No tournaments available"));
          }

          final tournaments = snapshot.data!;

          return ListView.builder(
            itemCount: tournaments.length,
            padding: const EdgeInsets.all(12),
            itemBuilder: (context, index) {
              final item = tournaments[index];

              // Parse joinedSeats and totalSeats to double safely
              final joined = double.tryParse(item.joinedSeats) ?? 0;
              final total = double.tryParse(item.totalSeats) ?? 1;
              final progress = joined / total;

              return GestureDetector(
                onTap: () => Get.to(() => JumboJackpotScreen(), arguments: item),
                child: _buildTournamentCard(item, progress),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildTournamentCard(TournamentModel item, double progress) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text(
                    "LATE JOIN",
                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                  ),
                ),
                Text(
                  "Starts At ${item.startTime}",
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),

            const SizedBox(height: 6),
            Text(item.title, style: const TextStyle(fontWeight: FontWeight.bold)),

            const SizedBox(height: 10),
            Row(
              children: [
                const Icon(Icons.emoji_events, color: Colors.amber),
                const SizedBox(width: 4),
                Text("₹${item.prizePool}", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                const Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text("Entry Fee: ₹${item.entryFee}", style: const TextStyle(fontSize: 12)),
                    const SizedBox(height: 6),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      child: const Text("Join"),
                    )
                  ],
                ),
              ],
            ),

            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.grey.shade300,
              color: Colors.green,
              minHeight: 5,
            ),
            const SizedBox(height: 4),
            Text("${item.joinedSeats} / ${item.totalSeats} Seats", style: const TextStyle(fontSize: 12, color: Colors.grey)),

            const Divider(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _iconText(Icons.currency_rupee, "₹${item.entryFee}"),
                _iconText(Icons.timer, "${item.durationInMins} Mins"),
                _iconText(Icons.people, "${item.totalWinners} Winners"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _iconText(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.black54),
        const SizedBox(width: 4),
        Text(text, style: const TextStyle(fontSize: 12, color: Colors.black87)),
      ],
    );
  }
}
