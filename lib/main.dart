import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';
import 'map.dart';
//import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';




void main() {
  runApp(SafeWalkApp());
}

class SafeWalkApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Safe Walk',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        fontFamily: 'Roboto',
      ),
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2C6C2),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'SAFE WALK',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Empower. Protect. Connect.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                ),
              ),
              SizedBox(height: 50),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
                child: Text('Get Started'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink, // Background color
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  textStyle: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Save user details
                final String username = _usernameController.text;
                final String email = _emailController.text;

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MainScreen(
                      username: username,
                      email: email,
                    ),
                  ),
                );
              },
              child: Text('Login'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                textStyle: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class MainScreen extends StatelessWidget {
  final String username;
  final String email;

  MainScreen({required this.username, required this.email});
  void _triggerSosPanic() {
    _playAlarmSound();
    _sendSosAlerts();
  }

  
  void _playAlarmSound() async {
    final AudioPlayer audioPlayer = AudioPlayer();
    await audioPlayer.play(AssetSource('assets/Ishq - From _Lost;Found_.mp3'));
  }

  
  void _sendSosAlerts() {
   
    print('SOS Alerts sent to emergency contacts!');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.person),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProfileScreen(
                  username: username,
                  email: email,
                ),
              ),
            );
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.location_on),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MapPage()),
              );
            },
          ),
        ],
      ),
      body: Row(
        children: [
          
          Container(
            width: 100,
            color: Colors.pink[50],
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.phone),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HelplineScreen()),
                    );
                  },
                  iconSize: 40,
                  color: Colors.pink,
                ),
                Text('Helpline',
                    style: TextStyle(fontSize: 14, color: Colors.black)),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => BlogScreen()),
                    );
                  },
                  child: TabItem(
                    icon: Icons.article,
                    label: 'Blogs',
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AlertsScreen()),
                    );
                  },
                  child: TabItem(
                    icon: Icons.notifications,
                    label: 'Alerts',
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MedicalCareScreen()),
                    );
                  },
                  child: TabItem(
                    icon: Icons.medical_services,
                    label: 'Medical Care',
                  ),
                ),
              ],
            ),
          ),
          
          
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        DefaultTabController(
                          length: 1,
                          child: TabBar(
                            indicatorColor: Colors.pink,
                            tabs: [
                              Tab(text: "Start Your Safe Journey"),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Empowering you with tools and support to feel secure and confident, always.',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xffd30d70),
                            fontStyle: FontStyle.italic,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 5),
                        Text(
                          '- Team SafeWalk',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30),
                  // SOS Panic Button
                       ElevatedButton.icon(
                    onPressed: _triggerSosPanic,
                    icon: Icon(Icons.warning),
                    label: Text('SOS Panic'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding:
                          EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                      textStyle: TextStyle(fontSize: 20),
                    ),
                  ),

                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      
                      Column(
                        children: [
                        IconButton(
  icon: Icon(Icons.contact_phone),
  iconSize: 50,
  color: Colors.pink,
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => EmergencyContactsScreen()),
    );
  },
),
                          SizedBox(height: 5),
                          Text(
                            'Emergency Contacts',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 50),
                      // Fake Call Icon
                      Column(
                        children: [
                          IconButton(
                            icon: Icon(Icons.call),
                            iconSize: 50,
                            color: Colors.pink,
                            onPressed: () {
                              
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => FakeCallScreen()),
                              );
                            
                              // Trigger fake call
                            },
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Fake Call',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}




class MedicalCareScreen extends StatelessWidget {
  final List<MedicalCareItem> items = [
    MedicalCareItem(
      title: 'Chat with Rosa',
      description: 'Get assistance for common medical emergencies.',
      icon: Icons.chat,
      onTap: () {
        
      },
    ),
    MedicalCareItem(
      title: 'Nearby Hospitals',
      description: 'Find the closest hospitals based on your location.',
      icon: Icons.local_hospital,
      onTap: () {
        
      },
    ),
    MedicalCareItem(
      title: 'Call Ambulance',
      description: 'Quickly call an ambulance in case of an emergency.',
      icon: Icons.call,
      onTap: () {
        // Call ambulance
      },
    ),
    MedicalCareItem(
      title: 'First Aid Tutorials',
      description: 'Learn CPR, wound care, and other essential first aid skills.',
      icon: Icons.play_circle_filled,
      onTap: () {
        // Navigate to first aid video tutorials
      },
    ),
    MedicalCareItem(
      title: 'Mental Health Support',
      description: 'Access mental health resources and helpline.',
      icon: Icons.support,
      onTap: () {
        // Show mental health support options
      },
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Medical Care'),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        padding: EdgeInsets.all(16.0),
        children: items.map((item) {
          return Card(
            child: InkWell(
              onTap: item.onTap,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(item.icon, size: 40, color: Colors.pink),
                  SizedBox(height: 10),
                  Text(
                    item.title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    item.description,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class MedicalCareItem {
  final String title;
  final String description;
  final IconData icon;
  final VoidCallback onTap;

  MedicalCareItem({
    required this.title,
    required this.description,
    required this.icon,
    required this.onTap,
  });
}


class TabItem extends StatelessWidget {
  final IconData icon;
  final String label;

  const TabItem({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Column(
        children: [
          Icon(icon, size: 40, color: Colors.pink),
          SizedBox(height: 5),
          Text(label, style: TextStyle(fontSize: 14, color: Colors.black)),
        ],
      ),
    );
  }
}



class HelplineScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Helpline Numbers'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          ListTile(
            leading: Icon(Icons.phone),
            title: Text('National Helpline for Women'),
            subtitle: Text('1091'),
            onTap: () {
              _makePhoneCall('tel:1091');
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.phone),
            title: Text('Women Helpline Domestic Abuse'),
            subtitle: Text('181'),
            onTap: () {
              _makePhoneCall('tel:181');
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.phone),
            title: Text('Childline India Foundation'),
            subtitle: Text('1098'),
            onTap: () {
              _makePhoneCall('tel:1098');
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.location_on),
            title: Text('Nearby Police Stations'),
            subtitle: Text('Find the closest police stations.'),
            onTap: () {
              
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.local_hospital),
            title: Text('Nearby Hospitals'),
            subtitle: Text('Find the closest hospitals.'),
            onTap: () {
              
            },
          ),
        ],
      ),
    );
  }

  //  initiate a phone call
  void _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}


class BlogScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Blogs & Tutorials'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Self-Defense Techniques'),
              Tab(text: 'Scenario-Based Training'),
              Tab(text: 'Virtual Instructor'),
              Tab(text: 'Fitness & Conditioning'),
            ],
            indicatorColor: Colors.pink,
          ),
        ),
        body: TabBarView(
          children: [
            SelfDefenseTab(),
            ScenarioTrainingTab(),
            VirtualInstructorTab(),
            FitnessConditioningTab(),
          ],
        ),
      ),
    );
  }
}

class SelfDefenseTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16.0),
      children: [
        TutorialCard(
          title: 'Basic Self-Defense Techniques',
          description: 'Learn the basics of self-defense to protect yourself in various situations.',
          videoUrl: 'https://youtu.be/vPrdl0VaOHE?si=58me6iHfKmTuubxg',
        ),
        TutorialCard(
          title: 'Advanced Self-Defense Moves',
          description: 'Enhance your skills with these advanced self-defense techniques.',
          videoUrl: 'https://youtu.be/vPrdl0VaOHE?si=58me6iHfKmTuubxg',
        ),
      ],
    );
  }
}

class ScenarioTrainingTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16.0),
      children: [
        TutorialCard(
          title: 'Nighttime Safety',
          description: 'Learn how to stay safe during nighttime activities.',
          videoUrl: 'https://youtu.be/vPrdl0VaOHE?si=58me6iHfKmTuubxg',
        ),
        TutorialCard(
          title: 'Public Transport Safety',
          description: 'Techniques to ensure your safety while using public transport.',
          videoUrl: 'https://youtu.be/vPrdl0VaOHE?si=58me6iHfKmTuubxg',
        ),
        TutorialCard(
          title: 'Weapons Defense',
          description: 'Techniques to defend yourself against weapons like knives, escape or disarming a gun threat, etc.',
          videoUrl: 'https://youtu.be/vPrdl0VaOHE?si=58me6iHfKmTuubxg', 
        ),
        TutorialCard(
          title: 'Home Invasion',
          description: 'Techniques for defending yourself in your home.',
          videoUrl: 'https://youtu.be/vPrdl0VaOHE?si=58me6iHfKmTuubxg', 
        ),
      ],
    );
  }
}

class VirtualInstructorTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16.0),
      children: [
        TutorialCard(
          title: 'AI-Powered Self-Defense Practice',
          description: 'Use our virtual instructor to practice self-defense techniques at home.',
          videoUrl: 'https://www.example.com/ai-practice',
        ),
        TutorialCard(
          title: 'Personalized Training Programs',
          description: 'Get a personalized self-defense training program powered by AI.',
          videoUrl: 'https://www.example.com/personalized-program',
        ),
      ],
    );
  }
}

class FitnessConditioningTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16.0),
      children: [
        TutorialCard(
          title: 'Strength Training Basics',
          description: 'Build strength with these essential exercises.',
          videoUrl: 'https://www.example.com/strength-training-basics',
        ),
        TutorialCard(
          title: 'Flexibility Routines',
          description: 'Improve your flexibility with these daily routines.',
          videoUrl: 'https://www.example.com/flexibility-routines',
        ),
        TutorialCard(
          title: 'Cardio Conditioning',
          description: 'Boost your endurance with these cardio workouts.',
          videoUrl: 'https://www.example.com/cardio-conditioning',
        ),
      ],
    );
  }
}

class TutorialCard extends StatelessWidget {
  final String title;
  final String description;
  final String videoUrl;

  const TutorialCard({
    required this.title,
    required this.description,
    required this.videoUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              description,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8.0),
            ElevatedButton.icon(
              onPressed: () {
                // Open video tutorial in browser
              },
              icon: Icon(Icons.play_arrow),
              label: Text('Watch Tutorial'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AlertsScreen extends StatelessWidget {
  final List<AlertItem> alerts = [
    AlertItem(
      title: 'Unsafe Zone Alert',
      description: 'Be cautious! You are near a reported unsafe zone.',
      icon: Icons.warning_amber_rounded,
      onTap: () {
        // Action 
      },
    ),
    AlertItem(
      title: 'Event Alert: Protest',
      description: 'Avoid the area near Central Square due to a protest.',
      icon: Icons.event_available,
      onTap: () {
        // Action 
      },
    ),
    AlertItem(
      title: 'Local News Alert',
      description: 'A curfew has been imposed in the city from 10 PM.',
      icon: Icons.newspaper,
      onTap: () {
        // Action
      },
    ),
    AlertItem(
      title: 'Legal Update',
      description: 'New laws on women\'s safety have been passed.',
      icon: Icons.gavel,
      onTap: () {
        // Action 
      },
    ),
    AlertItem(
      title: 'Government Campaign',
      description: 'Participate in the new safety awareness campaign.',
      icon: Icons.campaign,
      onTap: () {
        // Action 
      },
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Alerts'),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        padding: EdgeInsets.all(16.0),
        children: alerts.map((alert) {
          return Card(
            child: InkWell(
              onTap: alert.onTap,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(alert.icon, size: 40, color: Colors.pink),
                  SizedBox(height: 10),
                  Text(
                    alert.title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    alert.description,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class AlertItem {
  final String title;
  final String description;
  final IconData icon;
  final VoidCallback onTap;

  AlertItem({
    required this.title,
    required this.description,
    required this.icon,
    required this.onTap,
  });
}
class ProfileScreen extends StatelessWidget {
  final String username;
  final String email;

  ProfileScreen({required this.username, required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Username: $username', style: TextStyle(fontSize: 20)),
            SizedBox(height: 10),
            Text('Email: $email', style: TextStyle(fontSize: 20)),
            SizedBox(height: 30),
            Divider(),
            ListTile(
              title: Text('Settings'),
              onTap: () { 
              },
            ),
            ListTile(
              title: Text('About'),
              onTap: () {
                
              },
            ),
          ],
        ),
      ),
    );
  }
}
// fake_call_screen.dart
class FakeCallScreen extends StatefulWidget {
  @override
  _FakeCallScreenState createState() => _FakeCallScreenState();
}

class _FakeCallScreenState extends State<FakeCallScreen> {
  late AudioPlayer _audioPlayer;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _playRingtone();
  }

  @override
  void dispose() {
    _audioPlayer.stop(); // Stop the ringtone when leaving the screen
    _audioPlayer.dispose();
    super.dispose();
  }

  void _playRingtone() async {
    await _audioPlayer.play(AssetSource('assets/Ishq - From _Lost;Found_.mp3'));
  }
  void _stopRingtone() async {
    await _audioPlayer.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 60,
              backgroundColor: Colors.pink,
              child: Icon(
                Icons.person,
                size: 50,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Incoming Call',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Emergency',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.call_end),
                  color: Colors.red,
                  iconSize: 50,
                  onPressed: () {
                    Navigator.pop(context); // End call
                  },
                ),
                SizedBox(width: 50),
                IconButton(
                  icon: Icon(Icons.call),
                  color: Colors.green,
                  iconSize: 50,
                  onPressed: () {
                    _stopRingtone();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ActiveCallScreen(),
                      ),
                    );
                   },
                 ), // Answer call
              ],
            ),
          ],
        ),
      ),
    );
  }
}
class ActiveCallScreen extends StatefulWidget {
  @override
  _ActiveCallScreenState createState() => _ActiveCallScreenState();
}

class _ActiveCallScreenState extends State<ActiveCallScreen> {
  late Timer _timer;
  int _secondsElapsed = 0;
  bool _isMuted = false;
  bool _isSpeakerOn = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _secondsElapsed++;
      });
    });
  }

  String _formatDuration(int seconds) {
    final int minutes = seconds ~/ 60;
    final int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 60,
              backgroundColor: Colors.pink,
              child: Icon(
                Icons.person,
                size: 50,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Maa',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Calling...',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 20),
            Text(
              _formatDuration(_secondsElapsed),
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(_isMuted ? Icons.mic_off : Icons.mic),
                  color: Colors.white,
                  iconSize: 40,
                  onPressed: () {
                    setState(() {
                      _isMuted = !_isMuted;
                    });
                  },
                ),
                SizedBox(width: 50),
                IconButton(
                  icon: Icon(Icons.call_end),
                  color: Colors.red,
                  iconSize: 50,
                  onPressed: () {
                    Navigator.pop(context); // End call
                  },
                ),
                SizedBox(width: 50),
                IconButton(
                  icon: Icon(_isSpeakerOn ? Icons.volume_up : Icons.volume_off),
                  color: Colors.white,
                  iconSize: 40,
                  onPressed: () {
                    setState(() {
                      _isSpeakerOn = !_isSpeakerOn;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
class EmergencyContactsScreen extends StatelessWidget {
  final List<ContactItem> contacts = [
    ContactItem(name: 'Mother', phone: '1234567890'),
    ContactItem(name: 'Father', phone: '0987654321'),
    ContactItem(name: 'Brother', phone: '1122334455'),
    ContactItem(name: 'Trustee', phone: '2233445566'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Emergency Contacts'),
      ),
      body: ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          final contact = contacts[index];
          return ListTile(
            title: Text(contact.name),
            subtitle: Text(contact.phone),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.call),
                  onPressed: () {
                    _makePhoneCall('tel:${contact.phone}');
                  },
                ),
                IconButton(
                  icon: Icon(Icons.location_on),
                  onPressed: () {
                    _shareLocation(contact.phone);
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _shareLocation(String phone) {
   
    print('Sharing location to: $phone');
    
  }
}

class ContactItem {
  final String name;
  final String phone;

  ContactItem({required this.name, required this.phone});
}



