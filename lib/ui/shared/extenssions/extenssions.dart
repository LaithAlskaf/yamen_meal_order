import 'package:flutter/material.dart';

extension Padd on num {
  Padding get pdt => Padding(padding: EdgeInsets.only(top: toDouble()));
  Padding get pdb => Padding(padding: EdgeInsets.only(bottom: toDouble()));
  Padding get pdl =>
      Padding(padding: EdgeInsetsDirectional.only(start: toDouble()));
  Padding get pdr =>
      Padding(padding: EdgeInsetsDirectional.only(end: toDouble()));
}

extension EmptySpace on num {
  SizedBox get sbh => SizedBox(height: toDouble());
  SizedBox get sbw => SizedBox(width: toDouble());
}
  