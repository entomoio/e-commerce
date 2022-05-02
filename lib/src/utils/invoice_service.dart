import 'dart:io';
import 'dart:typed_data';
import 'package:intl/intl.dart';
import 'package:localization_ecommerce/src/features/pdf/domain/product.dart';
import 'package:open_file/open_file.dart' as open_file;
// import 'package:open_document/open_document.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:async';
// ignore: avoid_web_libraries_in_flutter

class CustomRow {
  final String itemName;
  final String itemPrice;
  final String amount;
  final String total;
  final String vat;

  CustomRow(this.itemName, this.itemPrice, this.amount, this.total, this.vat);
}

class PdfInvoiceService {
  createHelloWorld() async {
    final pdf = pw.Document();

    pdf.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Center(
            child:
                pw.Text('Hello World', style: const pw.TextStyle(fontSize: 40)),
          ); // Center
        })); //

    // final file = File("example.pdf");
    // final endfile = file.writeAsBytes(await savePdfFile());
    final List<int> bytes = await pdf.save();
    return bytes;
  }

  createInvoice(List<Product> soldProducts) async {
    final pdf = pw.Document();
    final date = DateTime.now();
    final dueDate = date.add(const Duration(days: 7));
    final List<CustomRow> elements = [
      CustomRow("Item Name", "Item Price", "Quantity", "Vat", "Total"),
      CustomRow("\n", "", "", "", ""),
      for (var product in soldProducts)
        CustomRow(
          product.name,
          product.price.toStringAsFixed(2),
          product.quantity.toStringAsFixed(0),
          (product.vatInPercent * product.price).toStringAsFixed(2),
          (product.price * product.quantity).toStringAsFixed(2),
        ),
      CustomRow("\n", "", "", "", ""),
      CustomRow(
        "Sub Total",
        "",
        "",
        "",
        "\$ ${getSubTotal(soldProducts)}",
      ),
      CustomRow(
        "Vat Total",
        "",
        "",
        "",
        "\$ ${getVatTotal(soldProducts)}",
      ),
      CustomRow("\n", "", "", "", ""),
      CustomRow(
        "TOTAL",
        "",
        "",
        "",
        "\$ ${(double.parse(getSubTotal(soldProducts)) + double.parse(getVatTotal(soldProducts))).toStringAsFixed(2)}",
      )
    ];
    // final image =
    //     (await rootBundle.load("assets/ultra.jpg")).buffer.asUint8List();
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            children: [
              // pw.Image(pw.MemoryImage(image),
              // width: 150, height: 150, fit: pw.BoxFit.cover),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text("CUSTOMER"),
                      pw.Text("Sarah Field"),
                      pw.Text("Sarah Street 9, Beijing, China"),
                      pw.Text("https://paypal.me/sarahfieldzz"),
                      pw.Text("Invoice Date: " + DateFormat.yMd().format(date)),
                      pw.Text("Due Date: " + DateFormat.yMd().format(dueDate)),
                    ],
                  ),
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text("SUPPLIER"),
                      pw.Text("Max Weber"),
                      pw.Text("Apple Street, Cupertino, CA 95014"),
                      pw.Text("Vat-id: 123456"),
                      pw.Text("Invoice-Nr: 00001")
                    ],
                  )
                ],
              ),
              pw.SizedBox(height: 50),
              pw.Text(
                  "Dear Fruitter, \n\nThanks for buying at Ultra Fruit EX, here is the list of your products."),
              pw.SizedBox(height: 50),
              itemColumn(elements),
              pw.SizedBox(height: 25),
              pw.Text(
                  "Thank you for your trust, and we hope to see you again."),
              pw.SizedBox(height: 25),
              pw.Text("Kind regards,"),
              pw.SizedBox(height: 25),
              pw.Text("Ultra Fruit EX")
            ],
          );
        },
      ),
    );

    return pdf.save();
  }

  pw.Expanded itemColumn(List<CustomRow> elements) {
    return pw.Expanded(
      child: pw.Column(
        children: [
          for (var element in elements)
            pw.Row(
              children: [
                pw.Expanded(
                    child: pw.Text(element.itemName,
                        textAlign: pw.TextAlign.left)),
                pw.Expanded(
                    child: pw.Text(element.itemPrice,
                        textAlign: pw.TextAlign.right)),
                pw.Expanded(
                    child:
                        pw.Text(element.amount, textAlign: pw.TextAlign.right)),
                pw.Expanded(
                    child:
                        pw.Text(element.total, textAlign: pw.TextAlign.right)),
                pw.Expanded(
                    child: pw.Text(element.vat, textAlign: pw.TextAlign.right)),
              ],
            )
        ],
      ),
    );
  }

  Future<void> savePdfFile(String fileName, Uint8List byteList) async {
    final Directory directory = await getApplicationSupportDirectory();
    // final output = await getTemporaryDirectory();
    // String path = "${directory.path}/$fileName.pdf";
    String? path = directory.path;
    final File file = File(Platform.isWindows
        ? '$path\\$fileName' '.pdf"'
        : '$path/$fileName' '.pdf"');
    await file.writeAsBytes(byteList);
    // await OpenFile.open(filePath);
    final List<int> bytes = [];
    await file.writeAsBytes(bytes, flush: true);
    if (Platform.isAndroid || Platform.isIOS) {
      //Launch the file (used open_file package)
      await open_file.OpenFile.open('$path/$fileName');
    } else if (Platform.isWindows) {
      await Process.run('start', <String>['$path\\$fileName'],
          runInShell: true);
    }
  }

  String getSubTotal(List<Product> products) {
    return products
        .fold(0.0,
            (double prev, element) => prev + (element.quantity * element.price))
        .toStringAsFixed(2);
  }

  String getVatTotal(List<Product> products) {
    return products
        .fold(
          0.0,
          (double prev, next) =>
              prev + ((next.price / 100 * next.vatInPercent) * next.quantity),
        )
        .toStringAsFixed(2);
  }

  Future<void> saveAndLaunchFile(List<int> bytes, String fileName) async {
    //Get the storage folder location using path_provider package.
    String? path;
    if (Platform.isAndroid ||
        Platform.isIOS ||
        Platform.isLinux ||
        Platform.isWindows) {
      final Directory directory = await getApplicationSupportDirectory();
      path = directory.path;
    } else {
      // path = await PathProviderPlatform.instance.getApplicationSupportPath();
    }
    final File file =
        File(Platform.isWindows ? '$path\\$fileName' : '$path/$fileName');
    await file.writeAsBytes(bytes, flush: true);
    if (Platform.isAndroid || Platform.isIOS) {
      //Launch the file (used open_file package)
      try {
        await open_file.OpenFile.open('$path/$fileName');
      } catch (e) {}
    } else if (Platform.isWindows) {
      await Process.run('start', <String>['$path\\$fileName'],
          runInShell: true);
    } else if (Platform.isMacOS) {
      await Process.run('open', <String>['$path/$fileName'], runInShell: true);
    } else if (Platform.isLinux) {
      await Process.run('xdg-open', <String>['$path/$fileName'],
          runInShell: true);
    }
  }
}
