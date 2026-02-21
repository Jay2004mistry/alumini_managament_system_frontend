import 'package:flutter/material.dart';

class FacultyDashboard extends StatefulWidget {
  const FacultyDashboard({super.key});

  @override
  State<FacultyDashboard> createState() => _FacultyDashboardState();
}

class _FacultyDashboardState extends State<FacultyDashboard> {

  /// ------------------ SIMULATED DATABASE ------------------

  List<Map<String, dynamic>> allEvents = [
    {
      "title": "Annual Alumni Meet",
      "date": "May 15, 2023",
      "time": "10:00 AM",
      "location": "Main Auditorium",
      "description": "Networking event for all alumni.",
      "participants": 42,
      "isMine": false,
    },
    {
      "title": "Faculty Workshop",
      "date": "July 10, 2023",
      "time": "11:00 AM",
      "location": "Innovation Lab",
      "description": "Workshop conducted by faculty.",
      "participants": 25,
      "isMine": true,
    },
  ];

  List<Map<String, String>> alumniList = [
    {"name": "Rahul Verma", "batch": "Batch 2020", "role": "Software Engineer"},
    {"name": "Neha Shah", "batch": "Batch 2019", "role": "Product Manager"},
    {"name": "Amit Patel", "batch": "Batch 2021", "role": "Data Analyst"},
  ];

  List<Map<String, String>> facultyList = [
    {"name": "Dr. Mehta", "dept": "Computer Science"},
    {"name": "Prof. Sharma", "dept": "Information Technology"},
    {"name": "Dr. Joshi", "dept": "Electronics"},
  ];

  /// ------------------ DELETE EVENT ------------------

  void deleteEvent(int index) {
    setState(() {
      allEvents.removeAt(index);
    });
  }

  /// ------------------ UPDATE EVENT ------------------

  void updateEvent(int index, Map<String, dynamic> updatedEvent) {
    setState(() {
      allEvents[index] = updatedEvent;
    });
  }

  @override
  Widget build(BuildContext context) {

    List<Map<String, dynamic>> myEvents =
    allEvents.where((e) => e["isMine"] == true).toList();

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F6FA),

        appBar: AppBar(
          automaticallyImplyLeading: false,
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
          actions: const [
            Icon(Icons.notifications_none),
            SizedBox(width: 16),
            Icon(Icons.search),
            SizedBox(width: 16),
          ],
          bottom: const TabBar(
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.indigo,
            tabs: [
              Tab(text: "Events"),
              Tab(text: "My Events"),
              Tab(text: "Alumni"),
              Tab(text: "Faculty"),
            ],
          ),
        ),

        body: TabBarView(
          children: [
            buildEventList(allEvents, false),
            buildEventList(myEvents, true),
            buildAlumniList(),
            buildFacultyList(),
          ],
        ),
      ),
    );
  }

  /// ------------------ EVENT LIST ------------------

  Widget buildEventList(List<Map<String, dynamic>> events, bool isMyTab) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: events.length,
      itemBuilder: (context, index) {
        final event = events[index];

        return EventCard(
          event: event,
          showManagement: isMyTab,
          onDelete: () {
            showDialog(
              context: context,
              builder: (_) => AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                title: const Text("Delete Event"),
                content: const Text(
                  "Are you sure you want to delete this event?",
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Cancel"),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      deleteEvent(allEvents.indexOf(event));
                    },
                    style: TextButton.styleFrom(
                        foregroundColor: Colors.red),
                    child: const Text("Delete"),
                  ),
                ],
              ),
            );
          },
          onEdit: () async {
            final updated = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => EditEventPage(event: event),
              ),
            );

            if (updated != null) {
              updateEvent(allEvents.indexOf(event), updated);
            }
          },
        );
      },
    );
  }

  /// ------------------ ALUMNI LIST ------------------

  Widget buildAlumniList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: alumniList.length,
      itemBuilder: (context, index) {
        final alumni = alumniList[index];
        return ProfileCard(
          title: alumni["name"]!,
          subtitle: "${alumni["batch"]} • ${alumni["role"]}",
        );
      },
    );
  }

  /// ------------------ FACULTY LIST ------------------

  Widget buildFacultyList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: facultyList.length,
      itemBuilder: (context, index) {
        final faculty = facultyList[index];
        return ProfileCard(
          title: faculty["name"]!,
          subtitle: faculty["dept"]!,
        );
      },
    );
  }
}

////////////////////////////////////////////////////////
/// EVENT CARD
////////////////////////////////////////////////////////

class EventCard extends StatelessWidget {
  final Map<String, dynamic> event;
  final bool showManagement;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const EventCard({
    super.key,
    required this.event,
    required this.showManagement,
    required this.onDelete,
    required this.onEdit,
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
            blurRadius: 8,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          ClipRRect(
            borderRadius:
            const BorderRadius.vertical(top: Radius.circular(18)),
            child: Image.network(
              "https://picsum.photos/600/300?random=${event["title"]}",
              height: 170,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(event["title"],
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 15)),

                const SizedBox(height: 6),
                Text("${event["date"]} • ${event["time"]}",
                    style: const TextStyle(color: Colors.grey)),

                const SizedBox(height: 4),
                Text(event["location"],
                    style: const TextStyle(color: Colors.grey)),

                const SizedBox(height: 6),
                Text(event["description"]),

                if (showManagement) ...[
                  const SizedBox(height: 12),
                  Row(
                    children: [

                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ParticipantsPage(
                                eventTitle: event["title"],
                                count: event["participants"],
                              ),
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.indigo.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            "Participants (${event["participants"]})",
                            style: const TextStyle(
                              color: Colors.indigo,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),

                      const Spacer(),

                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: onEdit,
                      ),

                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: onDelete,
                      ),
                    ],
                  )
                ]
              ],
            ),
          )
        ],
      ),
    );
  }
}

////////////////////////////////////////////////////////
/// EDIT EVENT PAGE
////////////////////////////////////////////////////////

class EditEventPage extends StatefulWidget {
  final Map<String, dynamic> event;

  const EditEventPage({super.key, required this.event});

  @override
  State<EditEventPage> createState() => _EditEventPageState();
}

class _EditEventPageState extends State<EditEventPage> {

  late TextEditingController title;
  late TextEditingController date;
  late TextEditingController time;
  late TextEditingController location;
  late TextEditingController description;

  @override
  void initState() {
    super.initState();
    title = TextEditingController(text: widget.event["title"]);
    date = TextEditingController(text: widget.event["date"]);
    time = TextEditingController(text: widget.event["time"]);
    location = TextEditingController(text: widget.event["location"]);
    description =
        TextEditingController(text: widget.event["description"]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Event")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            TextField(controller: title, decoration: const InputDecoration(labelText: "Title")),
            const SizedBox(height: 16),

            TextField(controller: date, decoration: const InputDecoration(labelText: "Date")),
            const SizedBox(height: 16),

            TextField(controller: time, decoration: const InputDecoration(labelText: "Time")),
            const SizedBox(height: 16),

            TextField(controller: location, decoration: const InputDecoration(labelText: "Location")),
            const SizedBox(height: 16),

            TextField(controller: description, maxLines: 4, decoration: const InputDecoration(labelText: "Description")),
            const SizedBox(height: 24),

            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, {
                  "title": title.text,
                  "date": date.text,
                  "time": time.text,
                  "location": location.text,
                  "description": description.text,
                  "participants": widget.event["participants"],
                  "isMine": widget.event["isMine"],
                });
              },
              child: const Text("Save Changes"),
            )
          ],
        ),
      ),
    );
  }
}

////////////////////////////////////////////////////////
/// PARTICIPANTS PAGE
////////////////////////////////////////////////////////

class ParticipantsPage extends StatelessWidget {
  final String eventTitle;
  final int count;

  const ParticipantsPage({
    super.key,
    required this.eventTitle,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("$eventTitle Participants")),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: count,
        itemBuilder: (context, index) {
          return ListTile(
            leading: const CircleAvatar(child: Icon(Icons.person)),
            title: Text("Participant ${index + 1}"),
            subtitle: const Text("student@example.com"),
          );
        },
      ),
    );
  }
}

////////////////////////////////////////////////////////
/// PROFILE CARD
////////////////////////////////////////////////////////

class ProfileCard extends StatelessWidget {
  final String title;
  final String subtitle;

  const ProfileCard({
    super.key,
    required this.title,
    required this.subtitle,
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
              blurRadius: 8)
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(subtitle,
                    style: const TextStyle(
                        color: Colors.grey, fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}