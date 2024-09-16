import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'app/app.dart';

void main() {
  CachedNetworkImage.logLevel = CacheManagerLogLevel.debug;
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}


