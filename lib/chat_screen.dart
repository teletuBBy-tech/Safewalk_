// import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart'; // Make sure to add this import

// class ChatScreen extends StatefulWidget {
//   @override
//   _ChatScreenState createState() => _ChatScreenState();
// }

// class _ChatScreenState extends State<ChatScreen> {
//   final String chatbotUrl = 'https://bot.dialogflow.com/0c6f1dba-16cd-439d-befe-e5de7576f27c'; // Your chatbot URL

//   // Function to launch the URL
//   void _launchURL() async {
//     if (await canLaunch(chatbotUrl)) {
//       await launch(chatbotUrl); // Launch the URL in a browser
//     } else {
//       throw 'Could not launch $chatbotUrl';
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Chat with Rosa'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               'Click the link below to chat with Rosa:',
//               style: TextStyle(fontSize: 18),
//             ),
//             SizedBox(height: 20),
//             GestureDetector(
//               onTap: _launchURL, // When the text is tapped, launch the URL
//               child: Text(
//                 'Chat with Rosa',
//                 style: TextStyle(
//                   color: Colors.blue,
//                   fontSize: 20,
//                   decoration: TextDecoration.underline,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
