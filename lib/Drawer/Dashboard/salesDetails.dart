import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';
import 'package:manager_app/constants.dart';
import 'package:manager_app/data.dart';

class SalesDetails extends StatefulWidget {
  final List<RestaurantOrderHistory> salesHistory;

  SalesDetails({
    @required this.salesHistory,
  });
  @override
  _SalesDetailsState createState() => _SalesDetailsState();
}

class _SalesDetailsState extends State<SalesDetails> {
  PDFDocument doc;

  int _selectedIndex;

  RestaurantOrderHistory selectedOrder;

  _onSelected(int index) {
    setState(() {
      _selectedIndex = index;

      selectedOrder = widget.salesHistory[index];
    });
  }

  void loadFromUrl() async {
    doc = await PDFDocument.fromURL(selectedOrder.pdf.toString());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kThemeColor,
        ),
        body: Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: widget.salesHistory != null
                    ? Container(
                        color: Colors.amber[100],
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 10),
                              child: Text(
                                "Orders",
                                style: kHeaderStyleSmall,
                              ),
                            ),
                            Expanded(
                              child: Scrollbar(
                                child: SingleChildScrollView(
                                  child: ListView.builder(
                                    reverse: true,
                                    shrinkWrap: true,
                                    primary: false,
                                    itemCount: widget.salesHistory != null
                                        ? widget.salesHistory.length
                                        : 0,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        color: _selectedIndex != null &&
                                                _selectedIndex == index
                                            ? Colors.black12
                                            : Colors.transparent,
                                        child: ListTile(
                                          title: Column(
                                            children: <Widget>[
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: <Widget>[
                                                  Expanded(
                                                    child: Text(
                                                      widget.salesHistory[index]
                                                          .table,
                                                      textAlign: TextAlign.left,
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      formatDate(
                                                            (widget
                                                                .salesHistory[
                                                                    index]
                                                                .timeStamp),
                                                            [HH, ':', nn],
                                                          ) ??
                                                          " ",
                                                      textAlign: TextAlign.left,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: <Widget>[
                                                  Expanded(
                                                    child: Text(
                                                      "₹ ${widget.salesHistory[index].bill.totalAmount.toString()}",
                                                      textAlign:
                                                          TextAlign.right,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          onTap: () {
                                            _onSelected(index);
                                            loadFromUrl();
                                          },
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : Center(
                        child: Text(
                          "No Billed Order History",
                          style: kHeaderStyleSmall,
                        ),
                      ),
              ),
              Expanded(
                flex: 3,
                child: selectedOrder != null
                    ? PDFViewer(
                        showPicker: false,
                        document: doc,
                      )
                    : Center(
                        child: Text(
                          "Select the order\nTo view Bill Details ",
                          textAlign: TextAlign.center,
                          style: kHeaderStyleSmall,
                        ),
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
