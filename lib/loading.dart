import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:invoices_app/invoice.dart';
import 'package:invoices_app/invoice_model.dart';
import 'package:provider/provider.dart';

fetchInvoices(BuildContext context) async {
  var response = await http.get(Uri.parse('https://www.jsonkeeper.com/b/TT8U'));
  if (response.statusCode == 200) {
    var jsonArray = jsonDecode(response.body)['invoices'] as List;
    Provider.of<InvoiceModel>(context, listen: false).invoices =
        jsonArray.map((e) => Invoice.fromJson(e)).toList();
  }
  Navigator.pop(context);
  Navigator.pushReplacementNamed(context, '/');
}

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchInvoices(context);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
