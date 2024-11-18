import 'package:flutter/material.dart';
import 'package:invoices_app/invoice_model.dart';
import 'package:provider/provider.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<InvoiceModel>(
      builder: (context, value, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(value.invoices[value.selectedIndex].cName),
          ),
          body: Column(children: [
            const Text(
              'Products: ',
              style: TextStyle(fontSize: 25),
            ),
            Text(value.invoices[value.selectedIndex].toString()),
          ]),
        );
      },
    );
  }
}
