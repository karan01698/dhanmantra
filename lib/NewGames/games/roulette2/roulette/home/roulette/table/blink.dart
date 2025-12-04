import 'dart:async';

import 'package:flutter/material.dart';

class AlwaysBlinkingContainer extends StatefulWidget {
  final bool isTarget;
  const AlwaysBlinkingContainer({
    this.isTarget = false,
    super.key,
  });

  @override
  _AlwaysBlinkingContainerState createState() =>
      _AlwaysBlinkingContainerState();
}

class _AlwaysBlinkingContainerState extends State<AlwaysBlinkingContainer> {
  bool _isVisible = true;

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  late Timer _timer;

  @override
  void initState() {
    super.initState();

    // Start the blinking effect
    _timer = Timer.periodic(const Duration(milliseconds: 300), (timer) {
      setState(() {
        _isVisible = !_isVisible; // Toggle visibility
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(child: Container()
        //  Align(
        //   alignment: Alignment.centerRight,
        //   child: Container(
        //     decoration: BoxDecoration(
        //       borderRadius: widget.isTarget
        //           ? const BorderRadius.horizontal(
        //               left: Radius.circular(12), right: Radius.circular(0))
        //           : BorderRadius.circular(12),
        //       color: _isVisible
        //           ? widget.isTarget
        //               ? Colors.yellow.shade700.withOpacity(0.6)
        //               : Colors.green.withOpacity(0.4)
        //           : Colors.transparent,
        //     ),
        //     height: MediaQuery.of(context).size.height *
        //         (widget.isTarget ? 0.04 : 0.03),
        //     width: MediaQuery.of(context).size.width * 0.1,
        //   ),
        // ),

        );
  }
}

class BlinkingContainer extends StatefulWidget {
  final bool isTarget;
  const BlinkingContainer({
    this.isTarget = false,
    super.key,
  });

  @override
  _BlinkingContainerState createState() => _BlinkingContainerState();
}

class _BlinkingContainerState extends State<BlinkingContainer> {
  bool _isVisible = true;

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  late Timer _timer;

  @override
  void initState() {
    super.initState();

    // Start the blinking effect
    _timer = Timer.periodic(const Duration(milliseconds: 300), (timer) {
      setState(() {
        _isVisible = !_isVisible; // Toggle visibility
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(child: Container()
        // Align(
        //   alignment: Alignment.centerRight,
        //   child: Provider.of<MyVariableModel>(context, listen: false)
        //           .showAmusementMessage
        //       //      ||
        //       // Provider.of<MyVariableModel>(context, listen: false).acceptBet
        //       ? Container()
        //       : Container(
        //           decoration: BoxDecoration(
        //             borderRadius: widget.isTarget
        //                 ? const BorderRadius.horizontal(
        //                     left: Radius.circular(12), right: Radius.circular(0))
        //                 : BorderRadius.circular(12),
        //             color: _isVisible
        //                 ? widget.isTarget
        //                     ? Colors.yellow.shade700.withOpacity(0.6)
        //                     : Colors.green.withOpacity(0.4)
        //                 : Colors.transparent,
        //           ),
        //           height: MediaQuery.of(context).size.height *
        //               (widget.isTarget ? 0.04 : 0.03),
        //           width: MediaQuery.of(context).size.width * 0.1,
        //         ),
        // ),

        );
  }
}

class BlinkingCell extends StatefulWidget {
  final bool isZeroOrDoubleZero;

  const BlinkingCell({super.key, this.isZeroOrDoubleZero = false});

  @override
  _BlinkingCellState createState() => _BlinkingCellState();
}

class _BlinkingCellState extends State<BlinkingCell> {
  bool _isVisible = true;

  @override
  void dispose() {
    // Cancel the timer when the widget is disposed
    _timer.cancel();
    super.dispose();
  }

  late Timer _timer;

  @override
  void initState() {
    super.initState();

    // Start the blinking effect
    _timer = Timer.periodic(const Duration(milliseconds: 300), (timer) {
      setState(() {
        _isVisible = !_isVisible; // Toggle visibility
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Align(
        alignment: Alignment.centerRight,
        child: Container(
          height: widget.isZeroOrDoubleZero
              ? MediaQuery.of(context).size.height * 0.12
              : MediaQuery.of(context).size.height * 0.08,
          width: MediaQuery.of(context).size.width * 0.0656,
          decoration: BoxDecoration(
            color:
                _isVisible ? Colors.green.withOpacity(0.4) : Colors.transparent,
          ),
        ),
      ),
    );
  }
}
