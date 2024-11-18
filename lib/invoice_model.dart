import 'package:flutter/material.dart';

import 'invoice.dart';

class InvoiceModel extends ChangeNotifier{
  List<Invoice> invoices = [];
  int selectedIndex = -1;
  int getSize() {
    return invoices.length;
  }
  getLast() {
    return invoices.last;
  }
  removeInvoice() {
    invoices.removeAt(selectedIndex);
    notifyListeners();
  }
  addInvoice(inv) {
    invoices.add(inv);
    notifyListeners();
  }
}