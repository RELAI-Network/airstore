import 'package:flutter/material.dart';

import '../models/book.dart';

class BookDetailScreen extends StatefulWidget {
  const BookDetailScreen(this.data, {super.key});
  static const String id = 'book_details';
  final BookModel data;

  @override
  State<BookDetailScreen> createState() => _BookDetailScreenState();
}

class _BookDetailScreenState extends State<BookDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              ListTile(
                leading: const FlutterLogo(
                  size: 40,
                ),
                title: Text(widget.data.title),
                trailing: ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.green),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                  ),
                  child: const Text('Get'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  'Edition date: ${widget.data.publicationDate!}',
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text(widget.data.description),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  'Book Type: ${widget.data.typeName}',
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  'Language : ${widget.data.publicationLanguage}',
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text('Price: ${widget.data.price}'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
