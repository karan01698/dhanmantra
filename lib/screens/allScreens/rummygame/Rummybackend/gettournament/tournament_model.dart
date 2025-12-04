class TournamentModel {
  final int id;
  final String tournamentID;
  final String title;
  final String startTime;
  final String entryFee;
  final String prizePool;
  final String totalSeats;
  final String joinedSeats;
  final String durationInMins;
  final String totalWinners;
  final String firstPrizeDescription;

  TournamentModel({
    required this.id,
    required this.tournamentID,
    required this.title,
    required this.startTime,
    required this.entryFee,
    required this.prizePool,
    required this.totalSeats,
    required this.joinedSeats,
    required this.durationInMins,
    required this.totalWinners,
    required this.firstPrizeDescription,
  });

  factory TournamentModel.fromJson(Map<String, dynamic> json) {
    return TournamentModel(
      id: json['ID'],
      tournamentID: json['TournamentID'],
      title: json['Title'],
      startTime: json['StartTime'],
      entryFee: json['EntryFee'],
      prizePool: json['PrizePool'],
      totalSeats: json['TotalSeats'],
      joinedSeats: json['JoinedSeats'],
      durationInMins: json['DurationInMins'],
      totalWinners: json['TotalWinners'],
      firstPrizeDescription: json['FirstPrizeDescription'],
    );
  }
}
