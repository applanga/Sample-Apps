// import 'package:flutter/material.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import 'package:weather_sample/widgets/drawer.dart';

// class AboutPage extends StatefulWidget {
//   AboutPage({
//     Key? key,
//     required this.city,
//     this.measurementUnit,
//     this.currentLanguage,
//   }) : super(key: key);
//   final String city;
//   final String? measurementUnit;
//   Locale? currentLanguage;

//   @override
//   _AboutPageState createState() => _AboutPageState();
// }

// class _AboutPageState extends State<AboutPage> {
//   late InAppWebViewController webView;
//   bool isLoading = true;
//   double progress = 0;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: _buildAppBar(),
//       drawer: MyDrawer(
//         city: widget.city,
//         measurementUnit: widget.measurementUnit,
//         currentLanguage: widget.currentLanguage,
//       ),
//       body: _createWebView(),
//     );
//   }

//   PreferredSizeWidget _buildAppBar() => AppBar(
//         iconTheme: const IconThemeData(color: Colors.blue),
//         backgroundColor: Colors.white,
//         centerTitle: true,
//         title: Text(
//           AppLocalizations.of(context)!.daily_forecast,
//           style: const TextStyle(
//             color: Colors.blue,
//           ),
//         ),
//       );

//   Widget _createWebView() => Column(
//         children: <Widget>[
//           Align(
//             alignment: Alignment.center,
//             child: _progressBar(),
//           ),
//           Expanded(
//             child: InAppWebView(
//               onProgressChanged: (controller, progress) => setState(() {
//                 setState(() {
//                   this.progress = progress / 100;
//                 });
//               }),
//               initialUrlRequest: URLRequest(
//                 url: Uri.parse(
//                   'http://localhost:8080/assets/about_page.html',
//                 ),
//               ),
//             ),
//           ),
//         ],
//       );

//   Widget _progressBar() {
//     if (progress != 1.0) {
//       return const Padding(
//         padding: EdgeInsets.all(8.0),
//         child: CircularProgressIndicator(
//           color: Colors.blue,
//         ),
//       );
//     }

//     return Container();
//   }
// }
