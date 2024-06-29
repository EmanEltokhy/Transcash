import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transcash/screens/transfer_screen/cubit/cubit.dart';
import 'package:transcash/screens/transfer_screen/cubit/states.dart';
import 'package:transcash/shared/components/components.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymobWebView extends StatelessWidget {
  PaymobWebView({required this.url, key}) : super(key: key);
  final String url;
  late WebViewController _webViewController;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => TransferCubit(),
      child: BlocConsumer<TransferCubit, TransferStates>(
          listener: (context, state) {},
          builder: (context, state) {
            final transfer = TransferCubit.get(context);
            return Scaffold(
              appBar: AppBar(
                title: const Text('Paymob Payment'),
              ),
              body: WebView(
                initialUrl: url,
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (WebViewController webViewController) {
                  _webViewController = webViewController;
                },
                navigationDelegate: (NavigationRequest request) {
                  // Check if callback URL is reached
                  if (request.url.contains('/account/api/callback/')) {
                    Uri uri = Uri.parse(request.url);
                    String success = uri.queryParameters['success'] ?? '';
                    int amount =
                        int.tryParse(uri.queryParameters['amount_cents']!)!;
                    if (success == 'true') {
                      print('before transfer.rechargesave');
                      transfer.rechargeSave(context,visaAmount: (amount/100).toString());
                      // Navigator.pop(context);
                      // dialog(context);
                    } else {
                      Navigator.pop(context);
                      failedDialog(context);
                    }
                    // Close the WebView and return to the app

                    return NavigationDecision.prevent;
                  }
                  return NavigationDecision.navigate;
                },
              ),
            );
          }),
    );
  }
}
