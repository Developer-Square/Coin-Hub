import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class RecommendedAsset extends StatelessWidget {
  var recommendedAsset;
  RecommendedAsset({this.recommendedAsset});

  @override
  Widget build(BuildContext context) {
    double myWidth = MediaQuery.of(context).size.width;
    double myHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: myWidth * 0.03, vertical: myHeight * 0.02),
      child: Container(
        padding: EdgeInsets.only(
            left: myWidth * 0.03,
            right: myWidth * 0.06,
            top: myHeight * 0.02,
            bottom: myHeight * 0.02),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(20)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: myHeight * 0.035,
              child: Image.network(recommendedAsset.image),
            ),
            SizedBox(
              height: myHeight * 0.01,
            ),
            Text(
              recommendedAsset.id,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: myHeight * 0.008,
            ),
            Row(
              children: [
                Text('\$ ${recommendedAsset.priceChange24H.toStringAsFixed(1)}',
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: Colors.grey)),
                SizedBox(
                  width: myWidth * 0.02,
                ),
                Text(
                    '${recommendedAsset.marketCapChangePercentage24H.toStringAsFixed(1)}%',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color:
                            recommendedAsset.marketCapChangePercentage24H >= 0
                                ? Colors.green
                                : Colors.red)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
