import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../main.dart';



class GameHomeScreen extends StatefulWidget {
  const GameHomeScreen({super.key});

  @override
  State<GameHomeScreen> createState() => _GameHomeScreenState();
}

class _GameHomeScreenState extends State<GameHomeScreen>
    with SingleTickerProviderStateMixin {
  List<double> sectors = [100, 20, 0.15, 0.5, 50, 20, 100, 50, 20, 50];
  int randomSectorIndex = -1;
  List<double> sectorRadians = [];
  double angle = 0;

  bool spinning = false;
  double earnedValue = 0.00;
  double totalEarnings = 0.00;
  int spins = 0;

  math.Random random = math.Random();
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    // TODO: implement deactivate
    super.initState();
    generateSectorRadians();
    // animation controller
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3600),
    );

    Tween<double> tween = Tween<double>(begin: 0, end: 1);

    CurvedAnimation curve = CurvedAnimation(
      parent: controller,
      curve: Curves.decelerate,
    );

    animation = tween.animate(curve);
    controller.addListener(() {
      if (controller.isCompleted) {
        setState(() {

        });
        recordStats();
        spinning = false;
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown,
      appBar: AppBar(title: const Text("Game Home")),
      body: _body(),
    );
  }

  Widget _body() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQat8twMWqifsHxEA1gMffCl20o7YZ51i8opQ&s',
          ),
          fit: BoxFit.cover, // Optional: make image fill the container
        ),
      ),
      child: _gameContent(),
    );
  }

  Widget _gameContent() {
    return Stack(
      children: [
        _gameTitle(),
        _gameWheel(),

        _gameActions(),
        _gameStats()
      ],
    );
  }

  Widget _gameTitle() {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        margin: const EdgeInsets.only(top: 70),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(30)),
          // ❌ missing comma here
          border: Border.all(color: CupertinoColors.systemYellow, width: 2),
          gradient: const LinearGradient(
            colors: [Color(0XFF2d014c), Color(0XFFf8009e)],
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
          ),
        ),
        child: Text(
          "Fortune Wheel",
          style: TextStyle(fontSize: 40, color: CupertinoColors.systemYellow),
        ),
      ),
    );
  }


  Widget _gameWheel() {
    return Center(
      child: Container(
        padding: const EdgeInsets.only(top: 20, left: 5),
        width: MediaQuery
            .of(context)
            .size
            .width * 0.9,
        height: MediaQuery
            .of(context)
            .size
            .height * 0.9,
        decoration: const BoxDecoration(
          // image: DecorationImage(
          //   image: NetworkImage(
          //     'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQat8twMWqifsHxEA1gMffCl20o7YZ51i8opQ&s',
          //   ),
          //   fit: BoxFit.cover, // Optional: make image fill the container
          // ),
        ),
        child: InkWell(
          onTap: () {
            if (!spinning) {
              spin();
              spinning = true;
            }
          },
          child: AnimatedBuilder(
            animation: animation,
            builder: ((context, child) {
              return Transform.rotate(
                angle: controller.value * angle,
                child: Container(
                  margin: EdgeInsets.all(
                    MediaQuery
                        .of(context)
                        .size
                        .width * 0.07,
                  ),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/spiner.png"),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }

  void generateSectorRadians() {
    double sectorRadian = 2 * math.pi / sectors.length;
    for (int i = 0; i < sectors.length; i++) {
      sectorRadians.add((i + 1) * sectorRadian);
    }
  }

  void recordStats() {
    earnedValue = sectors[sectors.length - (randomSectorIndex + 1)];
    totalEarnings = totalEarnings + earnedValue;
    spins = spins + 1;
  }

  void spin() {
    randomSectorIndex = random.nextInt(sectors.length);
    double randomRadian = generateRandomRadianToSpinTo();
    controller.reset();
    angle = randomRadian;
    controller.forward();
  }

  double generateRandomRadianToSpinTo() {
    return (2 * math.pi * sectors.length) + sectorRadians[randomSectorIndex];
  }

  Widget _gameStats() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        margin: const EdgeInsets.only(bottom: 20, left: 20),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(30)),
          border: Border.all(color: CupertinoColors.systemYellow, width: 2),
          gradient: const LinearGradient(
            colors: [Color(0xFF2d014c), Color(0xFFf8009e)],
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
          ),
        ),
        child: Table(
          border: TableBorder.all(color: CupertinoColors.systemYellow),
          children: [
            TableRow(
              children: [
                _titleColumn("Earned"),
                _titleColumn("Earnings"),
                _titleColumn("Spins"),
              ],
            ),
            TableRow(
              children: [
                _valueColumn(earnedValue),
                _valueColumn(totalEarnings),
                _valueColumn(spins),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Column _titleColumn(String title) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.yellowAccent,
            ),
          ),
        ),
      ],
    );
  }

  Column _valueColumn(var val) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            '$val',
            style: const TextStyle(
              fontSize: 25,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget _gameActions() {
    return Align(
      alignment: Alignment.bottomRight,
      child: Container(
        margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height*0.17, left: 20, right: 10
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            InkWell(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(4)),
                  border: Border.all(color: CupertinoColors.systemYellow,),
                  gradient: const LinearGradient(
                    colors: [Color(0xFF2d014c), Color(0xFFf8009e)],
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                  ),
                ),
                child: IconButton(onPressed: (){
                  logPrint("ready to go ");
                }, icon: Icon(Icons.arrow_circle_down)),
              ),

            ),
            InkWell(
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(4)),
                    border: Border.all(color: CupertinoColors.systemYellow,),
                    gradient: const LinearGradient(
                      colors: [Color(0xFF2d014c), Color(0xFFf8009e)],
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 6,vertical: 3),
                  child: Text(
                    "Reset", style: TextStyle(
                      fontSize: spinning ?20:25,
                      color: const Color(0XFF41006e)

                  ),
                  )
              ),
              onTap: (){
                if(spinning) return;
                setState(() {
                  resetGame();

                });
              },
            ),
            InkWell(
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(4)),
                    border: Border.all(color: CupertinoColors.systemYellow,),
                    gradient: const LinearGradient(
                      colors: [Color(0xFF2d014c), Color(0xFFf8009e)],
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 6,vertical: 3),
                  child: Text(
                    spinning ? "Spinning":"Spin",  style: TextStyle(
                      fontSize: spinning ?20:25,
                      color: const Color(0XFF41006e)

                  ),
                  )
              ),
              onTap: (){
                if(!spinning) {
                  setState(() {
                    spin();
                    spinning = true;

                  }
                  );}
              },
            )
          ],
        ),
      ),
    );

  }

  void resetGame() {
    spinning = false;
    angle = 0;
    earnedValue = 0;
    totalEarnings = 0;
    spins = 0;
    controller.reset();
  }
}
