import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DescriptionScreen extends StatefulWidget {
  final String title;
  final String description;
  final String content;
  final String author;
  final String sourse;
  final String image;

  const DescriptionScreen({
    super.key,
    required this.title,
    required this.description,
    required this.content,
    required this.author,
    required this.sourse,
    required this.image,
  });

  @override
  State<DescriptionScreen> createState() => _DescriptionScreenState();
}

class _DescriptionScreenState extends State<DescriptionScreen> {
  @override
  Widget build(BuildContext context) {
    log(widget.content);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.sourse, style: GoogleFonts.inter(
          fontSize: 28, fontWeight: FontWeight.w600,
          color: Colors.black54
        ),),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(widget.title, style: GoogleFonts.inter(
                color: Colors.black54, fontWeight: FontWeight.bold,
                fontSize: 24
              )),
            ),
            Text('${widget.author}, ${widget.sourse}'),

            const SizedBox(height: 20),
            Container(
              height: 400,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(image: NetworkImage(widget.image), fit: BoxFit.contain),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Text(
                widget.description,
                style: GoogleFonts.inter(
                  fontSize: 16, fontWeight: FontWeight.w700
                ),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Text(widget.content),
            ),
          ],
        ),
      ),
    );
  }
}