import 'package:flutter/material.dart';

dynamic label;
dynamic hintText;

var inputDecoration = InputDecoration(
  contentPadding: const EdgeInsets.symmetric(
    vertical: 10,
    horizontal: 10,
  ),
  hintText: hintText,
  label: label,
  border: const OutlineInputBorder(
    borderSide: BorderSide(color: Colors.black, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(15.0)),
  ),
  focusedBorder: const OutlineInputBorder(
    borderSide: BorderSide(color: Colors.lightBlue, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(15.0)),
  ),
  hintStyle: const TextStyle(fontSize: 14),
  labelStyle: const TextStyle(fontSize: 14),
);

FadeInImage fadeInImage(
  url,
  placeholderUrl,
  errorUrl,
  double width,
  double height,
) =>
    FadeInImage(
      image: NetworkImage(url),
      placeholder: AssetImage(
        placeholderUrl,
      ),
      imageErrorBuilder: (context, error, stackTrace) {
        return Image.asset(
          errorUrl,
          width: width,
        );
      },
      fit: BoxFit.cover,
      width: width,
      height: height,
    );
