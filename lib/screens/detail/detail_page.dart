import 'package:examen_flutter/services/detail_service.dart';
import 'package:examen_flutter/services/home_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../models/coin.dart';
import '../../models/user.dart';

class DetailPage extends StatefulWidget {
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  List<Coin>? currencies = [];

  @override
  void initState() {
    super.initState();
    fetchCoins().then((value) => {
          setState(() {
            currencies = value;
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController codeController = TextEditingController();
    final TextEditingController quantityController = TextEditingController();
    final TextEditingController prixController = TextEditingController();

    final user = (ModalRoute.of(context)!.settings.arguments
        as Map<String, dynamic>)['user'] as User;
    final currency = (ModalRoute.of(context)!.settings.arguments
        as Map<String, dynamic>)['currency'] as Coin;
    return Scaffold(
      appBar: AppBar(
        title: Text('${currency.name}'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(
                  'assets/images/${currency.image}'), // Replace with your image path
              radius: 50,
            ),
            SizedBox(height: 16),
            Text(
              "${currency.name}  [${currency.code}]",
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 24),
            Text(
              "\$${currency.unitPrice}",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                '${currency.description}',
                style: TextStyle(fontSize: 18),
              ),
            ),
            SizedBox(height: 8),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: codeController,
                decoration: InputDecoration(
                  labelText: user.id,
                  border: OutlineInputBorder(),
                ),
                enabled: false,
              ),
            ),
            SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: TextField(
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        controller: quantityController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Quantity',
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            final double parsedValue =
                                double.tryParse(value) ?? 0.0;
                            final double multipliedValue =
                                parsedValue * currency.unitPrice!.toDouble();
                            prixController.text = multipliedValue.toString();
                          }
                        }),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: TextFormField(
                      controller: prixController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Price',
                      ),
                      enabled: false,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
                height:
                    80), // Add additional space at the bottom for the floating action button
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          buyCoins(user.id, currency.id!, quantityController.text)
              .then((value) => {
                    if (value == false)
                      {showAlertDialog(context, 'No available funds')}
                    else
                      {
                        showAlertDialog(context,
                            'you Just bought ${quantityController.text}${currency.name}')
                      }
                  });
        },
        icon: Icon(Icons.shop_sharp),
        label: Text('Buy'),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}

showAlertDialog(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Alert'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
