import 'package:flutter/material.dart';
import 'package:invoices_app/invoice_model.dart';
import 'package:invoices_app/loading.dart';
import 'package:provider/provider.dart';
import 'details_page.dart';
import 'invoice.dart';
import 'invoices_page.dart';
import 'product.dart';

void main() {
  runApp(const MyApp());
}

List<Product> products = [];

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => InvoiceModel(),
      builder: (context, child) => MaterialApp(
        initialRoute: '/loading',
        theme: ThemeData(
          useMaterial3: false,
        ),
        routes: {
          '/': (context) => const InvoiceApp(),
          '/invoices_page': (context) => const InvoicesPage(),
          '/details_page': (context) => const DetailsPage(),
          '/loading': (context) => const Loading(),
        },
      ),
    );
  }
}

class InvoiceApp extends StatefulWidget {
  const InvoiceApp({super.key});
  static int invoiceNo = 1;
  @override
  State<InvoiceApp> createState() => _InvoiceAppState();
}

TextEditingController cNameController = TextEditingController();
TextEditingController pNameController = TextEditingController();
TextEditingController quantityController = TextEditingController();
TextEditingController priceController = TextEditingController();

class _InvoiceAppState extends State<InvoiceApp> {
  @override
  Widget build(BuildContext context) {
    return Consumer<InvoiceModel>(
      builder: (context, value, child) {
        if (value.getSize() != 0) {
          InvoiceApp.invoiceNo = value.getLast().invoiceNo + 1;
        } else {
          InvoiceApp.invoiceNo = 1;
        }
        return Scaffold(
          appBar: AppBar(
            title: Text('Invoice# ${InvoiceApp.invoiceNo}'),
          ),
          body: Column(
            children: [
              TextField(
                controller: cNameController,
                decoration: const InputDecoration(
                  labelText: 'Customer Name',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text(
                    'Products: ',
                    style: TextStyle(fontSize: 22),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Product Info'),
                            content: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextField(
                                    controller: pNameController,
                                    decoration: const InputDecoration(
                                      labelText: 'product name',
                                    ),
                                  ),
                                  TextField(
                                    keyboardType: TextInputType.number,
                                    controller: quantityController,
                                    decoration: const InputDecoration(
                                      labelText: 'quantity',
                                    ),
                                  ),
                                  TextField(
                                    keyboardType: TextInputType.number,
                                    controller: priceController,
                                    decoration: const InputDecoration(
                                      labelText: 'price',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            actions: [
                              ElevatedButton(
                                  onPressed: () {
                                    try {
                                      setState(() {
                                        products.add(Product(
                                            name: pNameController.text,
                                            quantity: int.parse(
                                                quantityController.text),
                                            price: double.parse(
                                                priceController.text)));
                                      });
                                      pNameController.clear();
                                      quantityController.clear();
                                      priceController.clear();
                                      Navigator.pop(context);
                                    } catch (e) {
                                      SnackBar snackBar = const SnackBar(
                                          content: Text(
                                              'please fill all fields correctly'));
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                    }
                                  },
                                  child: const Text('add')),
                              ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('cancel')),
                            ],
                          ),
                        );
                      },
                      child: const Text('add product')),
                ],
              ),
              Expanded(
                  child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      tileColor: Colors.blue[200],
                      leading: Text(products[index].name),
                      title: Text('price: ${products[index].price}'),
                      subtitle: Text('quantity: ${products[index].quantity}'),
                      trailing: IconButton(
                        onPressed: () {
                          setState(() {
                            products.removeAt(index);
                          });
                        },
                        icon: const Icon(Icons.delete_forever),
                      ),
                    ),
                  );
                },
              )
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        value.addInvoice(Invoice(
                            invoiceNo: InvoiceApp.invoiceNo,
                            cName: cNameController.text,
                            products: products));
                        InvoiceApp.invoiceNo++;
                        cNameController.clear();
                        products = [];
                      },
                      child: const Text('add invoice')),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/invoices_page');
                      },
                      child: const Text('show all invoices')),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
            ],
          ),
        );
      },
    );
  }
}
