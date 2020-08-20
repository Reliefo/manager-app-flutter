import 'dart:typed_data';
import 'dart:convert';
import 'package:photo_view/photo_view.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';
import 'package:manager_app/constants.dart';
import 'package:manager_app/data.dart';
import 'package:native_pdf_renderer/native_pdf_renderer.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:manager_app/constants.dart';

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
  List<PdfPageImage> pageImages;

  bool _isLoading = true;
  int _selectedIndex;
  int _selectedPage;
  RestaurantOrderHistory selectedOrder;

  _onSelected(int index) {
    setState(() {
      _selectedIndex = index;
      _selectedPage = 1;
      selectedOrder = widget.salesHistory[index];
    });
  }

  _onSelectedPage(int pageIndex) {
    setState(() {
      _selectedPage = pageIndex;
    });
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _loadFromUrl() async {
    setState(() {
      _isLoading = true;
    });
//    Utf8Encoder uint8 = Utf8Encoder();
//    var response = await http.get(selectedOrder.pdf);
//    Uint8List uni8listData = uint8.convert(response.body);
//    final document = await PdfDocument.openData(uni8listData);
//    var pagesCount = document.pagesCount;
//    pageImages = List<PdfPageImage>();
//    for (var i = 0; i < pagesCount; i++) {
//      var page = await document.getPage(i + 1);
//      final pageImage =
//          await page.render(width: page.width, height: page.height);
//      pageImages.add(pageImage);
//      await page.close();
//    }
    if (isNative) {
      doc = await PDFDocument.fromURL(selectedOrder.pdf);
    }

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
                        : isNative
                            ? PDFViewer(
                                showPicker: false,
                                document: doc,
                              )
//                            : FlatButton(
//                                child: Text(
//                                  "Click here to \nDownload the Bill",
//                                  style: kBlueButtonStyle,
//                                ),
//                                onPressed: () {
//                                  _launchURL(selectedOrder.pdf);
//                                },
//                                height: 1000,
//                              )
                            : Align(
                                child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                    IconButton(
                                      icon: Icon(Icons.file_download),
                                      tooltip: 'Download the Bill',
                                      onPressed: () {
                                        _launchURL(selectedOrder.pdf);
                                      },
                                      iconSize: 100,
                                      alignment: Alignment.center,
                                    ),
                                    Text(
                                      'Download the Bill',
                                      style: downloadTheBill,
                                    )
                                  ]))
//                        : Image(
//                            image: MemoryImage(pageImage.bytes),
//                          )
//                        : PhotoView(
//                            backgroundDecoration: BoxDecoration(
//                              color: Color.fromRGBO(255, 255, 255, 1),
//                            ),
//                            imageProvider: MemoryImage(pageImage.bytes),
//                          )
//                            : Container(
//                                child: Row(
////                                crossAxisAlignment: CrossAxisAlignment.start,
//                                    children: <Widget>[
//                                    Expanded(
//                                      flex: 2,
//                                      child: Scrollbar(
//                                        child: SingleChildScrollView(
//                                          child: ListView.builder(
//                                            shrinkWrap: true,
//                                            primary: false,
//                                            itemCount: pageImages != null
//                                                ? pageImages.length
//                                                : 0,
//                                            itemBuilder: (context, index) {
//                                              var indexPlus = index + 1;
//                                              return Container(
//                                                color: _selectedPage != null &&
//                                                        _selectedPage ==
//                                                            indexPlus
//                                                    ? Colors.black12
//                                                    : Colors.transparent,
//                                                child: ListTile(
//                                                  title: Row(
//                                                    mainAxisAlignment:
//                                                        MainAxisAlignment
//                                                            .spaceEvenly,
//                                                    children: <Widget>[
//                                                      Expanded(
//                                                        child: Text(
//                                                          indexPlus.toString(),
//                                                          textAlign:
//                                                              TextAlign.center,
//                                                        ),
//                                                      ),
//                                                    ],
//                                                  ),
//                                                  onTap: () {
//                                                    _onSelectedPage(indexPlus);
//                                                  },
//                                                ),
//                                              );
//                                            },
//                                          ),
//                                        ),
//                                      ),
//                                    ),
//                                    Expanded(
//                                        flex: 8,
//                                        child: PhotoView(
//                                          backgroundDecoration: BoxDecoration(
//                                            color: Colors.white,
//                                          ),
//                                          imageProvider: MemoryImage(
//                                              pageImages[_selectedPage - 1]
//                                                  .bytes),
//                                        ))
//                                  ]))
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
