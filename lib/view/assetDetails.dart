import 'dart:convert';

import 'package:blockchain_app/model/chartModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_charts/charts.dart';

class AssetDetails extends StatefulWidget {
  var selectedAsset;
  AssetDetails({this.selectedAsset});

  @override
  State<AssetDetails> createState() => _AssetDetailsState();
}

class _AssetDetailsState extends State<AssetDetails> {
  late TrackballBehavior trackballBehavior;

  @override
  void initState() {
    getChart();
    trackballBehavior = TrackballBehavior(
      enable: true,
      activationMode: ActivationMode.singleTap,
    );
    super.initState();
  }

  Widget build(BuildContext context) {
    double myWidth = MediaQuery.of(context).size.width;
    double myHeight = MediaQuery.of(context).size.height;
    return SafeArea(
        child: Scaffold(
      body: SizedBox(
        height: myHeight,
        width: myWidth,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: myWidth * 0.05, vertical: myHeight * 0.02),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SizedBox(
                          height: myHeight * 0.08,
                          child: Image.network(widget.selectedAsset.image)),
                      SizedBox(
                        width: myWidth * 0.02,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.selectedAsset.id,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: myHeight * 0.01,
                          ),
                          Text(
                            widget.selectedAsset.symbol,
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.normal,
                                color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '\$ ${widget.selectedAsset.currentPrice.toString()}',
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.normal,
                            color: Colors.black),
                      ),
                      SizedBox(
                        height: myHeight * 0.01,
                      ),
                      Text(
                        '${widget.selectedAsset.marketCapChangePercentage24H}%'
                            .toString(),
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: widget.selectedAsset
                                        .marketCapChangePercentage24H >=
                                    0
                                ? Colors.green
                                : Colors.red),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Divider(),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: myWidth * 0.05, vertical: myHeight * 0.02),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      const Text(
                        'Low',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                            color: Colors.grey),
                      ),
                      SizedBox(
                        height: myHeight * 0.01,
                      ),
                      Text(
                        '\$ ${widget.selectedAsset.low24H.toString()}',
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      const Text(
                        'High',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                            color: Colors.grey),
                      ),
                      SizedBox(
                        height: myHeight * 0.01,
                      ),
                      Text(
                        '\$ ${widget.selectedAsset.high24H.toString()}',
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      const Text(
                        'Vol',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                            color: Colors.grey),
                      ),
                      SizedBox(
                        height: myHeight * 0.01,
                      ),
                      Text(
                        '\$ ${widget.selectedAsset.totalVolume.toString()}M',
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: myHeight * 0.4,
              width: myWidth,
              child: SfCartesianChart(
                trackballBehavior: trackballBehavior,
                zoomPanBehavior: ZoomPanBehavior(
                  enablePanning: true,
                  zoomMode: ZoomMode.x,
                ),
                series: <CandleSeries>[
                  CandleSeries<ChartModel, int>(
                      enableSolidCandles: true,
                      enableTooltip: true,
                      bullColor: Colors.green,
                      bearColor: Colors.red,
                      dataSource: itemChart!,
                      xValueMapper: (ChartModel sales, _) => sales.time,
                      lowValueMapper: (ChartModel sales, _) => sales.low,
                      highValueMapper: (ChartModel sales, _) => sales.high,
                      openValueMapper: (ChartModel sales, _) => sales.open,
                      closeValueMapper: (ChartModel sales, _) => sales.close,
                      animationDuration: 55)
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }

  List<ChartModel>? itemChart;

  Future<void> getChart() async {
    String url =
        'https://api.coingecko.com/api/v3/coins/bitcoin/ohlc?vs_currency=usd&days=1';

    var response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    });

    if (response.statusCode == 200) {
      Iterable x = json.decode(response.body);
      List<ChartModel> modelList =
          x.map((e) => ChartModel.fromJson(e)).toList();
      setState(() {
        itemChart = modelList;
      });
    } else {
      print(response.statusCode);
    }
  }
}
