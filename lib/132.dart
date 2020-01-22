import 'package:sacco/sacco.dart';

void main()  {
  // -----------------------------------
  // --- Creating a wallet
  // -----------------------------------

  final networkInfo = NetworkInfo(
    bech32Hrp: "cosmos",
    lcdUrl: "https://122.51.26.25:1317",
    name: "tttt33323231233232",
  );

  final mnemonicString =
//      "vivid favorite regular curve check word bubble echo disorder cute parade neck rib evidence option glimpse couple force angry section dizzy puppy express cream";
        "fresh dream lady echo type write valid absent mixture april trip neck meadow mask current traffic pluck offer volume engage clay sand kitchen access";
  final mnemonic = mnemonicString.split(" ");
  final wallet = Wallet.derive(mnemonic, networkInfo);

  // -----------------------------------
  // --- Creating a transaction
  // -----------------------------------



  // Check the result
  if (wallet!=null) {
    print(wallet.bech32Address);
    print(wallet.networkInfo.name);

  } else {
    print("Tx send error: ${wallet}");
  }
}