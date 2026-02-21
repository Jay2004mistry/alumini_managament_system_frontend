import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      initialIndex: 0, // Default = All Events
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F6FA),

        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text(
            "GLS Connect",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          iconTheme: const IconThemeData(color: Colors.black),

          bottom: const TabBar(
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.indigo,
            indicatorWeight: 3,
            tabs: [
              Tab(text: "All"),
              Tab(text: "Upcoming"),
              Tab(text: "Joined"),
              Tab(text: "Alumni"),
              Tab(text: "Faculty"),
            ],
          ),

          actions: const [
            Icon(Icons.notifications_none, color: Colors.black),
            SizedBox(width: 16),
            Icon(Icons.search, color: Colors.black),
            SizedBox(width: 16),
          ],
        ),

        body: const TabBarView(
          children: [
            AllEventsPage(),
            UpcomingPage(),
            JoinedPage(),
            AlumniPage(),
            FacultyPage(),
          ],
        ),
      ),
    );
  }
}

/// ================= ALL EVENTS =================
class AllEventsPage extends StatelessWidget {
  const AllEventsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const EventList();
  }
}

/// ================= UPCOMING =================
class UpcomingPage extends StatelessWidget {
  const UpcomingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const EventList(showOnlyUpcoming: true);
  }
}

/// ================= JOINED =================
class JoinedPage extends StatelessWidget {
  const JoinedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const EventList(showOnlyPast: true);
  }
}

/// ================= ALUMNI =================
class AlumniPage extends StatelessWidget {
  const AlumniPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ProfileList(title: "Alumni Directory");
  }
}

/// ================= FACULTY =================
class FacultyPage extends StatelessWidget {
  const FacultyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ProfileList(title: "Faculty Members");
  }
}

/// ================= EVENT LIST =================
class EventList extends StatelessWidget {
  final bool showOnlyUpcoming;
  final bool showOnlyPast;

  const EventList({
    super.key,
    this.showOnlyUpcoming = false,
    this.showOnlyPast = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        EventCard(
          title: "Alumni Meet 2023",
          date: "May 15, 2023",
          location: "Campus Auditorium",
          isPast: false,
        ),
        EventCard(
          title: "Networking Night",
          date: "April 05, 2023",
          location: "Alumni Hall",
          isPast: true,
        ),
      ],
    );
  }
}

/// ================= EVENT CARD =================
class EventCard extends StatelessWidget {
  final String title;
  final String date;
  final String location;
  final bool isPast;

  const EventCard({
    super.key,
    required this.title,
    required this.date,
    required this.location,
    required this.isPast,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// IMAGE
          ClipRRect(
            borderRadius:
            const BorderRadius.vertical(top: Radius.circular(18)),
            child: Stack(
              children: [

                Image.network(
                  "https://picsum.photos/600/300?random=$title",
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),

                if (isPast)
                  Positioned(
                    top: 12,
                    right: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        "PAST",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),

          /// DETAILS
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),

                const SizedBox(height: 8),

                Row(
                  children: [
                    const Icon(Icons.calendar_today,
                        size: 14, color: Colors.grey),
                    const SizedBox(width: 6),
                    Text(
                      date,
                      style: const TextStyle(
                          color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),

                const SizedBox(height: 6),

                Row(
                  children: [
                    const Icon(Icons.location_on,
                        size: 14, color: Colors.grey),
                    const SizedBox(width: 6),
                    Text(
                      location,
                      style: const TextStyle(
                          color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// ================= PROFILE LIST =================
class ProfileList extends StatelessWidget {
  final String title;

  const ProfileList({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        ProfileCard(name: "Alex Thompson", role: "Software Engineer"),
        ProfileCard(name: "Jessica Martinez", role: "Product Manager"),
      ],
    );
  }
}

/// ================= PROFILE CARD =================
class ProfileCard extends StatelessWidget {
  final String name;
  final String role;

  const ProfileCard({
    super.key,
    required this.name,
    required this.role,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
          )
        ],
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 22,
            backgroundColor: Color(0xFFE0E7FF),
            child: Icon(Icons.person, color: Colors.indigo),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}