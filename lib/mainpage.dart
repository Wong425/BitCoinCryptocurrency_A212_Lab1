import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:ndialog/ndialog.dart';
import 'package:http/http.dart' as http;
import 'main.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() => runApp(const MyApp());

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Cryptocurrency App',
      home: CurrencyPage(),
    );
  }
}

class CurrencyPage extends StatefulWidget {
  const CurrencyPage({Key? key}) : super(key: key);

  @override
  State<CurrencyPage> createState() => _CurrencyPageState();
}

class _CurrencyPageState extends State<CurrencyPage> {
  TextEditingController cateEditeCon = TextEditingController();
  String dec = "", type = "btc", name = "", unit = "", typeName = "";
  var value = 0.0;
  List<String> listType = [
  "btc", "eth", "ltc", "bch", "bnb", "eos", "xrp",
  "xlm", "link", "dot", "yfi", "usd", "aed", "ars",
  "aud", "bdt", "bhd", "bmd", "brl", "cad", "chf",
  "clp", "cny", "czk", "dkk", "eur", "gdp", "hkd",
  "huf", "idr", "ils", "inr", "jpy", "krw", "kwd",
  "lkr", "mmk", "mxn", "myr", "ngn", "nok", "nzd",
  "php", "pkr", "pln", "rub", "sar", "sek", "sgd", 
  "thb", "try","twd", "uah", "vef", "vnd", "zar", 
  "xdr", "xag","xau", "bits", "sats"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text('Cryptocurrency App'),
        ),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              Image.asset('assets/images/image1.png', scale: 2.5),
              const SizedBox(height: 20),
              const Text(
                "Please select the coin",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.blueGrey),
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField(
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            width: 4.0,
                            color: Color.fromARGB(255, 210, 248, 254)),
                        borderRadius: BorderRadius.circular(10.0))),
                itemHeight: 50,
                value: type,
                onChanged: (newValue) {
                  setState(() {
                    type = newValue.toString();
                  });
                },
                items: listType.map((type) {
                  return DropdownMenuItem(
                    child: Text(type),
                    value: type,
                  );
                }).toList(),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.grey, // background
                      onPrimary:
                          const Color.fromARGB(255, 25, 40, 251), // foreground
                      elevation: 20,
                      shadowColor: const Color.fromARGB(255, 57, 179, 220)),
                  onPressed: (_loadCur),
                  child: const Text(
                    "Load Cryptocurrencies",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  )),
              const SizedBox(height: 30),
              Container(
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 142, 180, 199),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            color: const Color.fromARGB(255, 24, 12, 43)
                                .withOpacity(1),
                            blurRadius: 3)
                      ]),
                  child: Text(
                    dec,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.black),
                  ))
            ],
          ),
        )));
  }

  Future<void> _loadCur() async {
    ProgressDialog progressDialog = ProgressDialog(context,
        message: const Text("In Progress"), title: const Text("Exchanging ..."));
    progressDialog.show();
    var url = Uri.parse('https://api.coingecko.com/api/v3/exchange_rates');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var jsonData = response.body;
      var parsedData = json.decode(jsonData);
      name = parsedData['rates'][type]['name'];
      unit = parsedData["rates"][type]['unit'];
      value = parsedData["rates"][type]['value'];
      typeName = parsedData["rates"][type]['type'];

      setState(() {
        dec =
            " Name : $name \n Unit : $unit \n Value : $value \n Type : $typeName";
      });
      Fluttertoast.showToast(
          msg: "Found!",
          textColor: Colors.amber,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          fontSize: 16.0);
    } else {
      Container(
          color: Colors.blueGrey,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10));
      setState(() {
        dec = "No record is found.";
      });
    }
    progressDialog.dismiss();
  }
}
