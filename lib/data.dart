import 'dart:async';

class ApiService {
  // Mock method for fetching unsafe zone data for Chandni Chowk
  Future<Map<String, dynamic>> fetchUnsafeZoneData(String location) async {
    // Simulating a network request with mock data
    await Future.delayed(Duration(seconds: 2)); // Simulating network delay

    return {
      "protests": [
        {"name": "Protest at Chandni Chowk", "time": "10:00 AM", "description": "Protests against government policies."},
        {"name": "Student Protest", "time": "2:00 PM", "description": "Students protesting for education rights."}
      ],
      "unsafe_zones": [
        {"name": "Chandni Chowk Main Road", "description": "High risk area due to recent incidents."},
        {"name": "Chawri Bazaar", "description": "Unsafe due to local gang activity."}
      ],
      "events": [
        {"name": "Safety Awareness Campaign", "time": "5:00 PM", "description": "Join the awareness campaign to stay safe."},
        {"name": "Community Gathering", "time": "7:00 PM", "description": "A gathering to discuss community safety."}
      ],
    };
  }
}
