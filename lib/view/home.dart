import 'package:blockchain_app/model/coinModel.dart';
import 'package:blockchain_app/view/components/cryptoAsset.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;

import 'components/recommendedAsset.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    getCoinMarket();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double myWidth = MediaQuery.of(context).size.width;
    double myHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
          height: myHeight,
          width: myWidth,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomRight,
                  colors: [
                Color.fromARGB(255, 255, 219, 73),
                Color(0xffFBC700)
              ])),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: myHeight * 0.03),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: myWidth * 0.02,
                            vertical: myHeight * 0.005),
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(5)),
                        child: const Text(
                          'Main Portfolio',
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      const Text(
                        'Top 10 Coins',
                        style: TextStyle(fontSize: 14),
                      ),
                      const Text(
                        'Experimental',
                        style: TextStyle(fontSize: 14),
                      ),
                    ]),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: myWidth * 0.05),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Ksh 17,357.34',
                        style: TextStyle(fontSize: 30),
                      ),
                      Container(
                        padding: EdgeInsets.all(myWidth * 0.02),
                        height: myHeight * 0.05,
                        width: myWidth * 0.1,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withOpacity(0.5)),
                        child: Image.asset('assets/icons/5.1.png'),
                      )
                    ]),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: myWidth * 0.05),
                child: Row(children: const [
                  Text(
                    '+162% all time',
                    style: TextStyle(fontSize: 15),
                  ),
                ]),
              ),
              SizedBox(
                height: myHeight * 0.02,
              ),
              Container(
                height: myHeight * 0.65,
                width: myWidth,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.shade200,
                        spreadRadius: 3,
                        offset: const Offset(0, 3),
                        blurRadius: 5)
                  ],
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50)),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: myHeight * 0.03,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: myWidth * 0.07),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            'Assets',
                            style: TextStyle(fontSize: 16),
                          ),
                          Icon(Icons.add)
                        ],
                      ),
                    ),
                    SizedBox(
                      height: myHeight * 0.02,
                    ),
                    Expanded(
                        child: isLoading
                            ? const Center(
                                child: CircularProgressIndicator(
                                  color: Color(0xffFBC700),
                                ),
                              )
                            : coinMarket == null || coinMarket!.isEmpty
                                ? Padding(
                                    padding: EdgeInsets.all(myHeight * 0.06),
                                    child: const Center(
                                      child: Text(
                                        'Attention this Api is free, so you cannot send multiple requests per second, please wait and try again later.',
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ),
                                  )
                                : ListView.builder(
                                    itemCount: 4,
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return CryptoAsset(
                                          cryptoAsset: coinMarket![index]);
                                    })),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: myWidth * 0.05),
                      child: Row(children: const [
                        Text(
                          'Recommend to Buy',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ]),
                    ),
                    SizedBox(
                      height: myHeight * 0.01,
                    ),
                    SizedBox(
                      height: myHeight * 0.19,
                      width: myWidth,
                      child: Padding(
                        padding: EdgeInsets.only(left: myWidth * 0.03),
                        child: isLoading
                            ? const Center(
                                child: CircularProgressIndicator(
                                  color: Color(0xffFBC700),
                                ),
                              )
                            : coinMarket == null || coinMarket!.isEmpty
                                ? Padding(
                                    padding: EdgeInsets.all(myHeight * 0.06),
                                    child: const Center(
                                      child: Text(
                                        'Attention this Api is free, so you cannot send multiple requests per second, please wait and try again later.',
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ),
                                  )
                                : ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: coinMarket!.length,
                                    itemBuilder: (context, index) {
                                      return RecommendedAsset(
                                          recommendedAsset: coinMarket![index]);
                                    }),
                      ),
                    ),
                  ],
                ),
              )
            ],
          )),
    );
  }

  bool isLoading = false;

  List? coinMarket = [];
  var coinMarketList;
  Future<List<CoinModel>?> getCoinMarket() async {
    const url =
        'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&sparkline=true';

    setState(() {
      isLoading = true;
    });

    var response = await http.get(Uri.parse(url), headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    });

    setState(() {
      isLoading = false;
    });
    if (response.statusCode == 200) {
      var body = response.body;
      coinMarketList = coinModelFromJson(body);
      setState(() {
        coinMarket = coinMarketList;
      });
    } else {
      print(response.statusCode);
    }
  }
}
