class PrizeDistributionModel {
  final int id;
  final String rank;
  final String amount;

  PrizeDistributionModel({
    required this.id,
    required this.rank,
    required this.amount,

});
  factory PrizeDistributionModel.fromJson(Map<String, dynamic>json){
    return PrizeDistributionModel(
      id: json['ID'],
      rank: json['Ranks'].toString(),
      amount: json['Amount'].toString(),
    );
  }


}
