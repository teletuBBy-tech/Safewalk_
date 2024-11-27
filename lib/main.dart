import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'data.dart';

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
  const SafeWalkApp({super.key});

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
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2C6C2),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'SAFE WALK',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Empower. Protect. Connect.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                ),
              ),
              const SizedBox(height: 50),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink, // Background color
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  textStyle: const TextStyle(fontSize: 18),
                ),
                child: Text('Get Started'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

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
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
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
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink,
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                textStyle: const TextStyle(fontSize: 18),
              ),
              child: Text('Login'),
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

  const MainScreen({super.key, required this.username, required this.email});
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
          icon: const Icon(Icons.person),
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
            icon: const Icon(Icons.location_on),
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
                  icon: const Icon(Icons.phone),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HelplineScreen()),
                    );
                  },
                  iconSize: 40,
                  color: Colors.pink,
                ),
                const Text('Helpline',
                    style: TextStyle(fontSize: 14, color: Colors.black)),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => BlogScreen()),
                    );
                  },
                  child: const TabItem(
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
                  child: const TabItem(
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
                  child: const TabItem(
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
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(20),
                    child: const Column(
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
                  const SizedBox(height: 30),
                  // SOS Panic Button
                       ElevatedButton.icon(
                    onPressed: _triggerSosPanic,
                    icon: const Icon(Icons.warning),
                    label: const Text('SOS Panic'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding:
                          const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                      textStyle: const TextStyle(fontSize: 20),
                    ),
                  ),

                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      
                      Column(
                        children: [
                        IconButton(
  icon: const Icon(Icons.contact_phone),
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
                          const SizedBox(height: 5),
                          const Text(
                            'Emergency Contacts',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 50),
                      // Fake Call Icon
                      Column(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.call),
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
                          const SizedBox(height: 5),
                          const Text(
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

// =============adding chat bot=================================

class MedicalCareScreen extends StatelessWidget {
  const MedicalCareScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<MedicalCareItem> items = [
      MedicalCareItem(
        title: 'Chat with Rosa',
        description: 'Get assistance for common medical emergencies.',
        icon: Icons.chat,
        onTap: () async {
          const url = 'https://bot.dialogflow.com/0c6f1dba-16cd-439d-befe-e5de7576f27c';
          if (await canLaunchUrl(Uri.parse(url))) {
            await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
          } else {
            throw 'Could not launch $url';
          }
        },
      ),
      MedicalCareItem(
        title: 'Nearby Hospitals',
        description: 'Find the closest hospitals based on your location.',
        icon: Icons.local_hospital,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NearbyHospitalsScreen()),
          );
        },
      ),
      MedicalCareItem(
        title: 'Call Ambulance',
        description: 'Quickly call an ambulance in case of an emergency.',
        icon: Icons.call,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CallAmbulanceScreen()),
          );
        },
      ),
      MedicalCareItem(
        title: 'First Aid Tutorials',
        description: 'Learn CPR, wound care, and other essential first aid skills.',
        icon: Icons.play_circle_filled,
        onTap: () async {
          const url = 'https://youtu.be/ea1RJUOiNfQ?si=zzy0FeWuGtbb7o1u';
          if (await canLaunchUrl(Uri.parse(url))) {
            await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
          } else {
            throw 'Could not launch $url';
          }
        },
      ),
    ];

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

class NearbyHospitalsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nearby Hospitals'),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(28.6139, 77.2090), // Replace with user's location
          zoom: 12.0,
        ),
        markers: {
          Marker(
            markerId: MarkerId('aiims'),
            position: LatLng(28.5672, 77.2100),
            infoWindow: InfoWindow(title: 'AIIMS'),
          ),
          Marker(
            markerId: MarkerId('max_hospital'),
            position: LatLng(28.6391, 77.0895),
            infoWindow: InfoWindow(title: 'Max Hospital'),
          ),
          Marker(
            markerId: MarkerId('fortis'),
            position: LatLng(28.5246, 77.1853),
            infoWindow: InfoWindow(title: 'Fortis Hospital'),
          ),
        },
      ),
    );
  }
}


class CallAmbulanceScreen extends StatelessWidget {
  // Function to initiate a phone call
  void _makePhoneCall(String phoneNumber) async {
    final Uri callUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(callUri)) {
      await launchUrl(callUri);
    } else {
      // Handle the case when the phone app cannot be opened
      print('Could not launch $callUri');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Emergency Call'),
        automaticallyImplyLeading: false, // Remove back button
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Title and instructions
            Text(
              'Select the type of emergency to call:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24),
            
            // Call 108 button
            ElevatedButton.icon(
              onPressed: () {
                _makePhoneCall('108'); // Call number 108
              },
              icon: Icon(Icons.local_hospital, color: Colors.white),
              label: Text('Call 108 (General Emergency)'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue, // Button color
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                textStyle: TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(height: 16),

            // Call 102 button
            ElevatedButton.icon(
              onPressed: () {
                _makePhoneCall('102'); // Call number 102
              },
              icon: Icon(Icons.pregnant_woman, color: Colors.white),
              label: Text('Call 102 (Maternal/Child Emergency)'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.purple, // Button color
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                textStyle: TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(height: 40),

            // End Call button
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(context); // Return to the previous screen
              },
              icon: Icon(Icons.call_end),
              label: Text('End Call'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.red, // Red color for the end call button
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                textStyle: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


// Placeholder for the ChatScreen widget
class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chat with Rosa')),
      body: const Center(child: Text('This is the chat screen.')),
    );
  }
}





class TabItem extends StatelessWidget {
  final IconData icon;
  final String label;

  const TabItem({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Column(
        children: [
          Icon(icon, size: 40, color: Colors.pink),
          const SizedBox(height: 5),
          Text(label, style: const TextStyle(fontSize: 14, color: Colors.black)),
        ],
      ),
    );
  }
}



class HelplineScreen extends StatelessWidget {
  const HelplineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Helpline Numbers'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          ListTile(
            leading: const Icon(Icons.phone),
            title: const Text('National Helpline for Women'),
            subtitle: const Text('1091'),
            onTap: () {
              _makePhoneCall('tel:1091');
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.phone),
            title: const Text('Women Helpline Domestic Abuse'),
            subtitle: const Text('181'),
            onTap: () {
              _makePhoneCall('tel:181');
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.phone),
            title: const Text('Childline India Foundation'),
            subtitle: const Text('1098'),
            onTap: () {
              _makePhoneCall('tel:1098');
            },
          ),
          const Divider(),
           ListTile(
            leading: Icon(Icons.location_on),
            title: Text('Nearby Police Stations'),
            subtitle: Text('Find the closest police stations.'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LocationListScreen(
                    locationType: 'Police Stations',
                    locations: [
                      Location(name: 'Laxmi Nagar', imageUrl: 'assets/police1.png'),
                      Location(name: 'Daryaganj(Old Delhi)', imageUrl: 'assets/police2daryaganj.png'),
                      Location(name: 'Uttam Nagar(West Delhi)', imageUrl: 'assets/p3.png'),
                      Location(name: 'Defence Colony(South west Delhi)', imageUrl: 'assets/police4south.png'),
                      Location(name: 'Karol Bagh(Central Dist.)', imageUrl: 'assets/karolbagh.png'),
                      Location(name: 'Seemapuri(Shahdara Dist.)', imageUrl: 'assets/seemapuri.png'),
                    ],
                  ),
                ),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: Icon(Icons.local_hospital),
            title: Text('Nearby Hospitals'),
            subtitle: Text('Find the closest hospitals.'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LocationListScreen(
                    locationType: 'Hospitals',
                    locations: [
                      Location(name: 'MAX', imageUrl: 'assets/max1.png'),
                      Location(name: 'FORTIS', imageUrl: 'assets/fortis2.png'),
                      Location(name: 'BALAJI ACTION MEDICAL INSTITUTE', imageUrl: 'assets/balaji3.png'),
                      Location(name: 'SRI GANGA RAM', imageUrl: 'assets/ganga4.png'),
                      Location(name: 'INDRAPRASTHA APOLLO', imageUrl: 'assets/indraprashtha_apollo.png'),
                      Location(name: 'JEEVAN', imageUrl: 'assets/jeevan.png'),
                      
                    ],
                  ),
                ),
              );
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
class LocationListScreen extends StatelessWidget {
  final String locationType;
  final List<Location> locations;

  LocationListScreen({required this.locationType, required this.locations});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nearby $locationType'),
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Display two items per row
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.75, // Adjust for image size
        ),
        itemCount: locations.length,
        itemBuilder: (context, index) {
          final location = locations[index];
          return Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                    child: Image.asset(
                      location.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    location.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class Location {
  final String name;
  final String imageUrl;

  Location({required this.name, required this.imageUrl});
}




class BlogScreen extends StatelessWidget {
  const BlogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Blogs & Tutorials'),
          bottom: const TabBar(
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

// idk if this will work or not but adding defining of tut cards earlier for youtube vdo===============================
class TutorialCard extends StatelessWidget {
  final String title;
  final String description;
  final String videoUrl;

  const TutorialCard({super.key, 
    required this.title,
    required this.description,
    required this.videoUrl,
  });

  void _launchUrl() async {
    if (await canLaunch(videoUrl)) {
      await launch(videoUrl);
    } else {
      throw 'Could not launch $videoUrl';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              description,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8.0),
            ElevatedButton.icon(
              onPressed: _launchUrl,  // Launches the video URL
              icon: const Icon(Icons.play_arrow),
              label: const Text('Watch Tutorial'),
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
class SelfDefenseTab extends StatelessWidget {
  const SelfDefenseTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: const [
        TutorialCard(
          title: 'Basic Self-Defense Techniques',
          description: 'Learn the basics of self-defense to protect yourself in various situations.',
          videoUrl: 'https://youtu.be/ERMZRMqQmVI?si=boW7whOra_AB_Qps',
        ),
        TutorialCard(
          title: 'Advanced Self-Defense Moves',
          description: 'Enhance your skills with these advanced self-defense techniques.',
          videoUrl: 'https://youtu.be/B725c7vi1xk?si=WmeRWhFH5cMvuNk4',
        ),
      ],
    );
  }
}




class ScenarioTrainingTab extends StatelessWidget {
  const ScenarioTrainingTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: const [
        TutorialCard(
          title: 'Nighttime Safety',
          description: 'Learn how to stay safe during nighttime activities.',
          videoUrl: 'https://youtu.be/T2Xc4mRURkc?si=suTzFD0xD_L0RA7g',
        ),
        TutorialCard(
          title: 'Public Transport Safety',
          description: 'Techniques to ensure your safety while using public transport.',
          videoUrl: 'https://youtu.be/3c2IRKJ74HQ?si=n_dOiHtskA5oR4U7',
        ),
        TutorialCard(
          title: 'Weapons Defense',
          description: 'Techniques to defend yourself against weapons like knives, escape or disarming a gun threat, etc.',
          videoUrl: 'https://youtu.be/HMtNKZEul3E?si=t5tAewcDvvht4L10', 
        ),
        TutorialCard(
          title: 'Home Invasion',
          description: 'Techniques for defending yourself in your home.',
          videoUrl: 'https://youtu.be/gy5k6ZnXk1c?si=1oqNe4-9J9ok0fJD', 
        ),
      ],
    );
  }
}

class VirtualInstructorTab extends StatelessWidget {
  const VirtualInstructorTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: const [
        TutorialCard(
          title: 'AI-Powered Self-Defense Practice',
          description: 'Use our virtual instructor to practice self-defense techniques at home.',
          videoUrl: 'https://youtu.be/ERMZRMqQmVI?si=boW7whOra_AB_Qps',
        ),
        TutorialCard(
          title: 'Personalized Training Programs',
          description: 'Get a personalized self-defense training program powered by AI.',
          videoUrl: 'https://youtu.be/B725c7vi1xk?si=WmeRWhFH5cMvuNk4',
        ),
      ],
    );
  }
}

class FitnessConditioningTab extends StatelessWidget {
  const FitnessConditioningTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: const [
        TutorialCard(
          title: 'Strength Training Basics',
          description: 'Build strength with these essential exercises.',
          videoUrl: 'https://youtu.be/TN9i9Ni0Xr4?si=nIPaeZAOUo5XVsz9',
        ),
        TutorialCard(
          title: 'Flexibility Routines',
          description: 'Improve your flexibility with these daily routines.',
          videoUrl: 'https://youtu.be/itJE4neqDJw?si=NfQwlwjdqX_kclTU',
        ),
        TutorialCard(
          title: 'Cardio Conditioning',
          description: 'Boost your endurance with these cardio workouts.',
          videoUrl: 'https://youtu.be/3-_cOnVk0N4?si=UxR1_cYySd-FEz8Z',
        ),
      ],
    );
  }
}



class AlertsScreen extends StatelessWidget {
  final List<AlertItem> alerts = [
    AlertItem(
      title: 'Unsafe Zone Alert',
      description: 'Be cautious! You are near a reported unsafe zone.',
      icon: Icons.warning_amber_rounded,
      onTap: null, // We'll set the onTap logic inside the build method
    ),
    AlertItem(
      title: 'Legal Update',
      description: 'New laws on women\'s safety have been passed.',
      icon: Icons.gavel,
      onTap: () {
        // Navigate to Legal Updates Screen
      },
    ),
    AlertItem(
      title: 'Government Campaign',
      description: 'Participate in the new safety awareness campaign.',
      icon: Icons.campaign,
      onTap: () {
        // Navigate to Government Campaign Screen
      },
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // Set the onTap logic here to have access to context
    for (var alert in alerts) {
      if (alert.title == 'Unsafe Zone Alert') {
        alert.onTap = () {
          // Navigate to the Unsafe Zone Details screen for Chandni Chowk
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => UnsafeZoneDetailsScreen(location: 'Chandni Chowk'),
            ),
          );
        };
      }
      if (alert.title == 'Legal Update') {
        alert.onTap = () {
          // Navigate to Legal Updates screen
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LegalUpdateScreen(),
            ),
          );
        };
      }
      if (alert.title == 'Government Campaign') {
        alert.onTap = () {
          // Navigate to the Government Campaign Screen
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => GovernmentCampaignScreen(),
            ),
          );
        };
      }
    }

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
  VoidCallback? onTap;

  AlertItem({
    required this.title,
    required this.description,
    required this.icon,
    this.onTap,
  });
}

class GovernmentCampaignScreen extends StatelessWidget {
  final List<Map<String, String>> governmentCampaigns = [
    {
      'title': 'Beti Bachao Beti Padhao',
      'description': '''This campaign focuses on saving and educating the girl child. It encourages the protection of girls and empowers them through education.
      **Key Features**:
      - Awareness on gender equality.
      - Focus on education for girls.
      - Financial aid for underprivileged girls.
      - Participation options: Donate, volunteer, or spread the word.''',
      'link': 'https://www.bbbp.gov.in/',
    },
    {
      'title': 'Nirbhaya Fund',
      'description': '''This fund aims to improve women's safety in public spaces and tackle issues like harassment and sexual violence.
      **Key Features**:
      - Establishment of emergency response systems (112 helpline).
      - Setting up surveillance cameras and improving street lighting.
      - Women safety apps and tools.
      - Participation options: Support initiatives, donate, and volunteer.''',
      'link': 'https://wcd.nic.in/nirbhaya-fund',
    },
    {
      'title': 'Swachh Bharat Abhiyan',
      'description': '''While focusing on cleanliness, this campaign also emphasizes creating safe public spaces for women by making public toilets more accessible and safer.
      **Key Features**:
      - Public toilets designed with safety features for women.
      - Awareness campaigns to create a cleaner and safer environment.
      - Participation options: Cleanliness drives, awareness programs, and support campaigns.''',
      'link': 'https://swachhbharatmission.gov.in/',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Government Campaigns for Women\'s Safety'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: governmentCampaigns.map((campaign) {
            return Card(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      campaign['title']!,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      campaign['description']!,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        // Open the link to the campaign for more details
                        _openCampaignLink(campaign['link']!);
                      },
                      child: Text('Learn More and Participate'),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  void _openCampaignLink(String url) {
    // Add logic to open the campaign link in a browser or within the app
    print("Opening link: $url");
  }
}


class LegalUpdateScreen extends StatelessWidget {
  final List<Map<String, String>> legalUpdates = [
    {
      'year': '2020',
      'law': 'The Sexual Harassment of Women at Workplace (Prevention, Prohibition and Redressal) Act',
      'details': 'This law mandates strict penalties for workplace harassment, providing a clear framework for dealing with complaints.',
    },
    {
      'year': '2021',
      'law': 'The Prohibition of Child Marriage (Amendment) Act',
      'details': 'This amendment increases the legal marriage age for women from 18 to 21 years to ensure better protection and opportunities.',
    },
    {
      'year': '2023',
      'law': 'The Women Safety (Public Spaces) Act',
      'details': 'A law that strengthens the protection of women in public spaces by enhancing penalties for offenders and increasing surveillance.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Legal Updates on Women\'s Safety'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: legalUpdates.map((update) {
            return Card(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Year: ${update['year']}',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      '${update['law']}',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '${update['details']}',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class UnsafeZoneDetailsScreen extends StatefulWidget {
  final String location;

  UnsafeZoneDetailsScreen({required this.location});

  @override
  _UnsafeZoneDetailsScreenState createState() => _UnsafeZoneDetailsScreenState();
}

class _UnsafeZoneDetailsScreenState extends State<UnsafeZoneDetailsScreen> {
  late Future<Map<String, dynamic>> _unsafeZoneData;

  @override
  void initState() {
    super.initState();
    _unsafeZoneData = ApiService().fetchUnsafeZoneData(widget.location);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.location} Unsafe Zone Alerts'),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _unsafeZoneData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            var data = snapshot.data!;
            List protests = data['protests'] ?? [];
            List unsafeZones = data['unsafe_zones'] ?? [];
            List events = data['events'] ?? [];

            return ListView(
              children: [
                _buildSectionTitle('Protests'),
                _buildList(protests),
                _buildSectionTitle('Unsafe Zones'),
                _buildList(unsafeZones),
                _buildSectionTitle('Events'),
                _buildList(events),
              ],
            );
          } else {
            return Center(child: Text('No data available'));
          }
        },
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        title,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildList(List items) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: items.length,
      itemBuilder: (context, index) {
        var item = items[index];
        return Card(
          margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: ListTile(
            title: Text(item['name']),
            subtitle: Text('${item['description']}\nTime: ${item['time']}'),
          ),
        );
      },
    );
  }
}


class ProfileScreen extends StatelessWidget {
  final String username;
  final String email;

  const ProfileScreen({super.key, required this.username, required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Username: $username', style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 10),
            Text('Email: $email', style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 30),
            const Divider(),
            ListTile(
              title: const Text('Settings'),
              onTap: () { 
              },
            ),
            ListTile(
              title: const Text('About'),
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
  const FakeCallScreen({super.key});

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
            const CircleAvatar(
              radius: 60,
              backgroundColor: Colors.pink,
              child: Icon(
                Icons.person,
                size: 50,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Incoming Call',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Emergency',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.call_end),
                  color: Colors.red,
                  iconSize: 50,
                  onPressed: () {
                    Navigator.pop(context); // End call
                  },
                ),
                const SizedBox(width: 50),
                IconButton(
                  icon: const Icon(Icons.call),
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
  const ActiveCallScreen({super.key});

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
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
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
            const CircleAvatar(
              radius: 60,
              backgroundColor: Colors.pink,
              child: Icon(
                Icons.person,
                size: 50,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Maa',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Calling...',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              _formatDuration(_secondsElapsed),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),
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
                const SizedBox(width: 50),
                IconButton(
                  icon: const Icon(Icons.call_end),
                  color: Colors.red,
                  iconSize: 50,
                  onPressed: () {
                    Navigator.pop(context); // End call
                  },
                ),
                const SizedBox(width: 50),
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
  EmergencyContactsScreen({super.key});

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
        title: const Text('Emergency Contacts'),
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
                  icon: const Icon(Icons.call),
                  onPressed: () {
                    _makePhoneCall('tel:${contact.phone}');
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.location_on),
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

  Future<void> _makePhoneCall(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _shareLocation(String phone) {
    // Simulate location sharing logic
    print('Sharing location with: $phone');
  }
}

class ContactItem {
  final String name;
  final String phone;

  ContactItem({required this.name, required this.phone});
}


