import 'package:flutter/material.dart';

class CheckPoints extends StatelessWidget {
  final int checkTill;
  final List<String> checkPoints;
  final Color checkPointFilledColor;

  CheckPoints({
    this.checkTill = 1,
    this.checkPoints,
    this.checkPointFilledColor,
  });

  final double circleDia = 32;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (c, s) {
      final double cWidth = ((s.maxWidth - (32.0 * (checkPoints.length + 1))) /
          (checkPoints.length - 1));
      return Container(
        height: 56,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: checkPoints.map(
                  (e) {
                    int index = checkPoints.indexOf(e);
                    print(index);
                    return Container(
                      height: circleDia,
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: circleDia,
                            padding: EdgeInsets.all(4),
                            child: Icon(
                              Icons.done,
                              color: Colors.white,
                              size: 18,
                            ),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: index <= checkTill
                                    ? checkPointFilledColor
                                    : checkPointFilledColor.withOpacity(0.2)),
                          ),
                          index != (checkPoints.length - 1)
                              ? Container(
                                  color: index <= checkTill
                                      ? checkPointFilledColor
                                      : checkPointFilledColor.withOpacity(0.2),
                                  height: 4,
                                  width: cWidth,
                                )
                              : Container()
                        ],
                      ),
                    );
                  },
                ).toList(),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: checkPoints.map((e) {
                  return Text(
                    e,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  );
                }).toList(),
              ),
            )
          ],
        ),
      );
    });
  }
}
