import 'package:chart_sparkline/chart_sparkline.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class CryptoAsset extends StatelessWidget {
  var cryptoAsset;
  CryptoAsset({this.cryptoAsset});

  @override
  Widget build(BuildContext context) {
    double myWidth = MediaQuery.of(context).size.width;
    double myHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: myWidth * 0.05, vertical: myHeight * 0.012),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: SizedBox(
              height: myHeight * 0.06,
              child: Image.network(cryptoAsset.image),
            ),
          ),
          SizedBox(
            width: myWidth * 0.03,
          ),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    cryptoAsset.id.length > 8
                        ? '${cryptoAsset.id.substring(0, 7)}...'
                        : cryptoAsset.id,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(
                  height: myHeight * 0.005,
                ),
                Text('0.4 ${cryptoAsset.symbol}',
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: Colors.grey)),
              ],
            ),
          ),
          SizedBox(
            width: myWidth * 0.01,
          ),
          Expanded(
            flex: 2,
            child: SizedBox(
                height: myHeight * 0.05,
                child: Sparkline(
                  data: cryptoAsset.sparklineIn7D.price,
                  lineWidth: 2.0,
                  lineColor: cryptoAsset.marketCapChangePercentage24H >= 0
                      ? Colors.green
                      : Colors.red,
                  fillMode: FillMode.below,
                  fillGradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: const [0.0, 0.7],
                      colors: cryptoAsset.marketCapChangePercentage24H >= 0
                          ? [Colors.green, Colors.green.shade100]
                          : [Colors.red, Colors.red.shade100]),
                )),
          ),
          SizedBox(
            width: myWidth * 0.03,
          ),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('\$ ${cryptoAsset.currentPrice.toStringAsFixed(1)}',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold)),
                Row(
                  children: [
                    Text('\$ ${cryptoAsset.priceChange24H.toStringAsFixed(1)}',
                        style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            color: Colors.grey)),
                    SizedBox(
                      width: myWidth * 0.02,
                    ),
                    Text(
                        '${cryptoAsset.marketCapChangePercentage24H.toStringAsFixed(1)}%',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            color: cryptoAsset.marketCapChangePercentage24H >= 0
                                ? Colors.green
                                : Colors.red)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
