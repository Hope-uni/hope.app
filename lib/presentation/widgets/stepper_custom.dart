import 'package:flutter/material.dart';
import 'package:hope_app/presentation/utils/utils.dart';

class StepperCustom extends StatelessWidget {
  final double totalSteps;
  final double width;
  final int curStep;
  final Color stepCompleteColor;
  final Color currentStepColor;
  final Color inactiveColor;
  final double lineWidth;
  final List<String> labelSteps;

  const StepperCustom({
    super.key,
    required this.width,
    required this.curStep,
    required this.stepCompleteColor,
    required this.totalSteps,
    required this.inactiveColor,
    required this.currentStepColor,
    required this.lineWidth,
    required this.labelSteps,
  }) : assert(curStep > 0 == true &&
            curStep <= totalSteps + 1 &&
            labelSteps.length == totalSteps);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding:
          const EdgeInsets.only(top: 10.0, left: 15.0, right: 15.0, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: _steps(),
      ),
    );
  }

  List<Widget> _steps() {
    var list = <Widget>[];
    for (int i = 0; i < totalSteps; i++) {
      //colors according to state
      var lineColor = _getLineColor(i);
      // step circles
      list.add(
        Expanded(
          child: SizedBox(
            height: 100.0,
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  height: 55,
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                    labelSteps[i],
                    textAlign: TextAlign.center,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                ),
                _getInnerElementOfStepper(i)
              ],
            ),
          ),
        ),
      );
      //line between step circles
      if (i != totalSteps - 1) {
        list.add(
          Expanded(
            child: Container(
              height: 90.0,
              padding: const EdgeInsets.only(bottom: 12.5),
              alignment: Alignment.bottomCenter,
              child: Container(
                height: lineWidth,
                color: lineColor,
              ),
            ),
          ),
        );
      }
    }

    return list;
  }

  Widget _getInnerElementOfStepper(index) {
    var circleColor = _getCircleColor(index);
    var borderColor = _getBorderColor(index);
    if (index + 1 < curStep) {
      return Container(
        width: 35.0,
        height: 35.0,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: circleColor,
          borderRadius: const BorderRadius.all(Radius.circular(25.0)),
          border: Border.all(
            color: borderColor,
            width: 1.0,
          ),
        ),
        child: const Icon(
          Icons.check,
          color: $colorTextWhite,
          size: 16.0,
        ),
      );
    } else {
      return Container(
        width: 35.0,
        height: 35.0,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: circleColor,
          borderRadius: const BorderRadius.all(Radius.circular(25.0)),
          border: Border.all(
            color: borderColor,
            width: 1.0,
          ),
        ),
        child: Text(
          '${index + 1}',
          style: const TextStyle(
            color: $colorBlueGeneral,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }
  }

  _getCircleColor(i) {
    if (i + 1 < curStep) return stepCompleteColor;
    if (i + 1 == curStep) return currentStepColor;
    if (i + 1 > curStep) return $colorTextWhite;
  }

  _getBorderColor(i) {
    if (i + 1 < curStep) return stepCompleteColor;
    if (i + 1 == curStep) return currentStepColor;
    if (i + 1 > curStep) return inactiveColor;
  }

  _getLineColor(i) {
    var color = curStep > i + 1
        ? $colorBlueGeneral.withValues(alpha: 0.4)
        : $colorButtonDisable;
    return color;
  }
}
