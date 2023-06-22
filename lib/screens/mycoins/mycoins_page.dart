import 'package:examen_flutter/models/Owned.dart';
import 'package:flutter/material.dart';

import '../../models/user.dart';
import '../../services/mycoins_service.dart';

class MyCoinsPage extends StatefulWidget {
  @override
  _MyCoinsPageState createState() => _MyCoinsPageState();
}

class _MyCoinsPageState extends State<MyCoinsPage> {
  List<Owned>? currencies = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final user = ModalRoute.of(context)!.settings.arguments as User;
    fetchCoins2(user!.id).then((value) {
      setState(() {
        currencies = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = ModalRoute.of(context)!.settings.arguments as User;
    return Scaffold(
      appBar: AppBar(
        title: Text('My coins'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'BALANCE',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 16),
            Text(
              '\$' +
                  user.balance.toStringAsFixed(
                      0), // Replace with the actual balance amount
              style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 24),
            Expanded(
              child: (currencies == null)
                  ? Text("List vide")
                  : GridView.builder(
                      physics: ScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // Set the desired number of columns
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                      ),
                      itemCount: currencies!.length,
                      itemBuilder: (context, index) {
                        return buildGridTile(index, context);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Card buildGridTile(int index, BuildContext context) {
    final user = ModalRoute.of(context)!.settings.arguments as User;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 3,
      child: InkWell(
        onTap: () {},
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(
                'assets/images/${currencies![index].image!}',
              ),
              radius: 50,
            ),
            SizedBox(height: 10),
            Text(
              "${currencies![index].quantity!} ${currencies![index].code!}",
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
