import 'package:flutter/material.dart';
import 'package:invoices_app/invoice_model.dart';
import 'package:provider/provider.dart';

class InvoicesPage extends StatefulWidget {
  const InvoicesPage({super.key});

  @override
  State<InvoicesPage> createState() => _InvoicesPageState();
}

class _InvoicesPageState extends State<InvoicesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All customers'),
      ),
      body: Consumer<InvoiceModel>(builder: (context, value, child) {
        return ListView.builder(
        itemCount: value.invoices.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: ListTile(
              onTap: () {
                value.selectedIndex = index;
                Navigator.pushNamed(context, '/details_page');
              },
              tileColor: Colors.blue[100],
              leading: Text(
                value.invoices[index].cName,
                style: const TextStyle(fontSize: 26),
              ),
              trailing: IconButton(onPressed: () {
                value.selectedIndex = index;
                value.removeInvoice();
              }, icon: const Icon(Icons.delete)),
            ),
          );
        },
      );
      },)
    );
  }
}
