import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
class Screen1 extends StatelessWidget {
  const Screen1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () async {
                    log("message");
                    // Map<Permission, PermissionStatus> status = await[Permission.storage].request();
                    // log(status.toString());
                    if (await Permission.manageExternalStorage.isDenied) {
                      await Permission.manageExternalStorage.request();
                    }
                    // showFullScreenDialog(context);
                    // Share.share("/storage/emulated/0/Download/Taras Crunch/call.png");
                    // downloadFile("https://images.ctfassets.net/hrltx12pl8hq/01rJn4TormMsGQs1ZRIpzX/16a1cae2440420d0fd0a7a9a006f2dcb/Artboard_Copy_231.jpg?fit=fill&w=600&h=600", "dd12-13_0.png");
                    // OpenFile.open("/storage/emulated/0/Download/Taras Crunch/call.png");
                    // final result = await OpenFile.open("/storage/emulated/0/Download/Taras Crunch/save.pdf");
                    // log("Result: ${result.message}");


                  },
                  child: Container(
                    width: 200,
                    height: 400,
                    constraints: const BoxConstraints(maxHeight: 270),
                    decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(14))),
                    child: CachedNetworkImage(
                      // Use CachedNetworkImage to load and cache the network image
                      imageUrl:
                      "https://images.ctfassets.net/hrltx12pl8hq/01rJn4TormMsGQs1ZRIpzX/16a1cae2440420d0fd0a7a9a006f2dcb/Artboard_Copy_231.jpg?fit=fill&w=600&h=600",
                      // Provide the image URL
                      fit: BoxFit.fitWidth,
                      // Set the fit mode for the image
                      progressIndicatorBuilder: (context, url, downloadProgress) =>
                          Center(
                            child: CircularProgressIndicator(
                                value: downloadProgress.progress), // Show a progress indicator while loading
                          ),
                      errorWidget: (context, url, error) =>
                      const Text("data"), // Display the specified error widget on loading error
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future openFile(String url, String? fileName) async {
  final openFile = await downloadFile(url, fileName);
  if (openFile == null) return;

  OpenFile.open(openFile.path);
  log("PATH: " + openFile.path);
}

Future<File?> downloadFile(String url, String? name) async {
  final directory = Directory('/storage/emulated/0/Download/Taras Crunch');
  // final appStorage = await getExternalStorageDirectory();
  // final file = File('${appStorage?.path}/$name');

  if (await directory.exists()) {
    log("Directory Exists");
    directory;
  } else {
    log("Directory Creating");
    await directory.create(recursive: true);
  }


  log(directory!.path.toString());

  String fileName = "call.png";
  String savePath = "${directory?.path}/$fileName";
  try {
    final response = await Dio().download(url, savePath, onReceiveProgress: (count, total) {
      if (total != -1) {
        print((count / total * 100).toStringAsFixed(0) + "%");
      }
    },);
    log(response.statusCode.toString());
    if (response.statusCode == 200) {
      log("File downloaded successfully");
      log(savePath);
      OpenFile.open(savePath);
    }
  } catch (e) {
    log("Error downloading file: $e");
    return null;
  }
}

void showFullScreenDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: true, // Allows the user to dismiss the dialog by tapping outside of it
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.all(10),
        child: Center(
          child: Container(
            width: 150, // Responsive width using ScreenUtil (if enabled)
            constraints: BoxConstraints(maxHeight: 270), // Responsive height
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.all(Radius.circular(14)),
            ),
            child: CachedNetworkImage(
              imageUrl:
              "https://images.ctfassets.net/hrltx12pl8hq/01rJn4TormMsGQs1ZRIpzX/16a1cae2440420d0fd0a7a9a006f2dcb/Artboard_Copy_231.jpg?fit=fill&w=600&h=600",
              fit: BoxFit.fitWidth,
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  Center(
                    child: CircularProgressIndicator(value: downloadProgress.progress),
                  ),
              errorWidget: (context, url, error) => const Text("Error loading image"),
            ),
          ),
        ),
      );
    },
  );
}


class DownloadDirectoryManager {
  static Future<Directory?> getExternalStoragePublicDirectory() async {
    final directory = Directory('/storage/emulated/0/Download/BharatLaw AI');
    if (await directory.exists()) {
      log("Directory Exists");
      return directory;
    } else {
      log("Directory Creating");
      return await directory.create(recursive: true);
    }
  }

  static Future<Directory?> getDownloadDirectory() async {
    if (Platform.isAndroid) {
      Directory? downloadsDirectory = await getExternalStoragePublicDirectory();
      return downloadsDirectory;
    } else if (Platform.isIOS) {
      return await getApplicationDocumentsDirectory();
    }
    return null;
  }
}
