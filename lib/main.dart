// Flutter code sample for BottomNavigationBar

// This example shows a [BottomNavigationBar] as it is used within a [Scaffold]
// widget. The [BottomNavigationBar] has three [BottomNavigationBarItem]
// widgets and the [currentIndex] is set to index 0. The selected item is
// amber. The `_onItemTapped` function changes the selected item's index
// and displays a corresponding message in the center of the [Scaffold].
//
// ![A scaffold with a bottom navigation bar containing three bottom navigation
// bar items. The first one is selected.](https://flutter.github.io/assets-for-api-docs/assets/material/bottom_navigation_bar.png)

//import 'dart:html';

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sacco/sacco.dart';

//void main() => runApp(MyApp());
void main() async {
  final networkInfo = NetworkInfo(
    bech32Hrp: "cosmos",
    lcdUrl: "https://122.51.26.25:1317",
  );

  final mnemonicString =
      "vivid favorite regular curve check word bubble echo disorder cute parade neck rib evidence option glimpse couple force angry section dizzy puppy express cream";
  final mnemonic = mnemonicString.split(" ");
  final wallet = Wallet.derive(mnemonic, networkInfo);

  // -----------------------------------
  // --- Creating a transaction
  // -----------------------------------

  final message = StdMsg(
    type: "cosmos-sdk/MsgSend",
    value: {
      "from_address": wallet.bech32Address,
      "to_address": "did:com:1lys5uu683wrmupn4zguz7f2gqw45qae98pzn3d",
      "amount": [
        {"denom": "uatom", "amount": "100"}
      ]
    },
  );

  final stdTx = TxBuilder.buildStdTx(stdMsgs: [message]);

  // -----------------------------------
  // Signing a transaction
  // -----------------------------------

  final signedStdTx = await TxSigner.signStdTx(wallet: wallet, stdTx: stdTx);

  // -----------------------------------
  // --- Sending a transaction
  // -----------------------------------

  final result = await TxSender.broadcastStdTx(
    wallet: wallet,
    stdTx: signedStdTx,
  );

  // Check the result
  if (result.success) {
    print("Tx send successfully. Hash: ${result.hash}");
  } else {
    print("Tx send error: ${result.error.errorMessage}");
  }
  runApp(MyApp());
}
/// This Widget is the main application widget.
class MyApp extends StatelessWidget {
  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  List _pageList=[
    Wallets(),
    Wallets(),
    PersonSettings(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BottomNavigationBar Sample'),
      ),
      body: this._pageList[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.apps),
            title: Text('Apps'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            title: Text('Settings'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}

class Wallets extends StatefulWidget {
  Wallets({Key key}) : super(key: key);

  @override
  _Wallets createState() => _Wallets();
}

class _Wallets extends State<Wallets>{
  final String host ='https://test.forself.nl/bank/balances/cosmos1j9594lvfulkycvzl6ddtu9fgudqwzydzplkds7';
  Map<String, dynamic> datas;
  @override
  HttpGetToken()async{
    var response= await http.get(host);
    datas = jsonDecode(response.body);
    return datas;
//    print(datas['result'][0]['amount']);
  }
  Widget build(BuildContext context) {
    HttpGetToken();
    print(datas);
    var card = new SizedBox(
      height: 210.0,  //设置高度
      child: new Card(
        elevation: 15.0,  //设置阴影
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(14.0))),  //设置圆角
        child: new Column(  // card只能有一个widget，但这个widget内容可以包含其他的widget
          children: [
            new ListTile(
              title: new Text('cosmossdfas1231231',
                  style: new TextStyle(fontWeight: FontWeight.w500)),
              subtitle: new Text(datas['result'][0]['amount']),
              leading: new Icon(
                Icons.attach_money,
                color: Colors.blue[500],
              ),
            ),
            //new Divider(),//界限线
            new ListTile(
              title: new Text('收款',
                  style: new TextStyle(fontWeight: FontWeight.w500)),
              leading: new Icon(
                Icons.blur_on,
                color: Colors.blue[500],
              ),
            ),
            new ListTile(
              title: new Text('转账'),
              leading: new Icon(
                Icons.payment,
                color: Colors.blue[500],
              ),
            ),
          ],
        ),
      ),
    );
    return Container(
      child: card,
    );
  }
}

class PersonSettings extends StatefulWidget {
  PersonSettings({Key key}) : super(key: key);

  @override
  _PersonSettings createState() => _PersonSettings();
}

class _PersonSettings extends State<PersonSettings>{
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.people),
            title:Text('通讯录'),
          ),
          ListTile(
            leading: Icon(Icons.announcement),
            title:Text('更改密码'),
          ),
          ListTile(
            leading: Icon(Icons.add_a_photo),
            title:Text('扫码'),
          ),
          ListTile(
            leading: Icon(Icons.add),
            title:Text('创建一个钱包'),
          ),
          ListTile(
            leading: Icon(Icons.add),
            title:Text('创建一个钱包'),
          ),
        ],
      ),
    );
  }
}