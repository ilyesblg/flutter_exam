import 'package:examen_flutter/services/home_service.dart';
import 'package:flutter/material.dart';

import '../../models/coin.dart';
import '../../models/user.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Coin>? currencies = [];

  @override
  void initState() {
    super.initState(); // Access the passed variable
    fetchCoins().then((value) => {
          setState(() {
            currencies = value;
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    final user = ModalRoute.of(context)!.settings.arguments as User;
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: SizedBox(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 230, top: 100),
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.credit_card,
                color: Colors.blue,
              ),
              title: Text(
                'My Crypto-Currencies',
                style: TextStyle(color: Colors.blue),
              ),
              onTap: () {
                Navigator.pushNamed(context, "mycoins", arguments: user);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.logout,
                color: Colors.red,
              ),
              title: Text(
                'Logout',
                style: TextStyle(color: Colors.red),
              ),
              onTap: () async {
                Navigator.pushNamedAndRemoveUntil(
                    context, "/", (route) => false);
              },
            ),
          ],
        ),
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
                  : ListView.builder(
                      physics: ScrollPhysics(),
                      itemCount: currencies?.length,
                      itemBuilder: (context, index) {
                        return buildListTile(index, context);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Card buildListTile(int index, BuildContext context) {
    final user = ModalRoute.of(context)!.settings.arguments as User;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      elevation: 3,
      child: ListTile(
        contentPadding: EdgeInsets.all(16),
        leading: CircleAvatar(
          backgroundImage: AssetImage(
            'assets/images/${currencies![index].image!}',
          ),
          radius: 50,
        ),
        title: Text(
          currencies![index].name!,
          style: TextStyle(fontSize: 20),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(left: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                currencies![index].code!,
                style: TextStyle(fontSize: 18),
              ),
              Text(
                currencies![index].unitPrice!.toString(),
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
        onTap: () {
          // Navigate to the other page
          Navigator.pushNamed(
            context,
            "detail",
            arguments: {
              'currency': currencies![index],
              'user': user,
            }, // Replace OtherPage with the desired page widget
          );
        },
      ),
    );
  }
}
