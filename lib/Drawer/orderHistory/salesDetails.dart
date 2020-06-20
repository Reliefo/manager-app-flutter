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

  bool _isLoading = true;
  int _selectedIndex;
  RestaurantOrderHistory selectedOrder;

  _onSelected(int index) {
    setState(() {
      _selectedIndex = index;

      selectedOrder = widget.salesHistory[index];
    });
  }

  void _loadFromUrl() async {
    setState(() {
      _isLoading = true;
    });
    doc = await PDFDocument.fromURL(selectedOrder.pdf);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Order History"),
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
                                          title: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: <Widget>[
                                              Expanded(
                                                child: Text(
                                                  formatDate(
                                                        (widget
                                                            .salesHistory[index]
                                                            .timeStamp),
                                                        [
                                                          d,
                                                          '/',
                                                          M,
                                                          '/',
                                                          yy,
                                                          '  ',
                                                          HH,
                                                          ':',
                                                          nn
                                                        ],
                                                      ) ??
                                                      "",
                                                  textAlign: TextAlign.left,
                                                ),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  widget.salesHistory[index]
                                                      .table,
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  "₹ ${widget.salesHistory[index].bill.totalAmount.toString()}",
                                                  textAlign: TextAlign.right,
                                                ),
                                              ),
                                            ],
                                          ),
                                          onTap: () {
                                            _onSelected(index);
                                            _loadFromUrl();
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
                    ? _isLoading
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : PDFViewer(
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
