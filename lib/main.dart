

import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:test_app/controller/fetch_leads.dart';

import 'package:test_app/model/lead_model.dart';
import 'package:test_app/views/view_details_page.dart';

void main() => runApp(const LeadApp());

class LeadApp extends StatelessWidget {
  const LeadApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LeadListScreen(),
    );
  }
}

class LeadListScreen extends StatefulWidget {
  const LeadListScreen({super.key});

  @override
  _LeadListScreenState createState() => _LeadListScreenState();
}

class _LeadListScreenState extends State<LeadListScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late Future<List<Estimate>> _leads;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
    _leads = fetchLeads();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Leads',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400)),
        backgroundColor: Colors.white,
        leading: const Icon(
          Icons.travel_explore,
          color: Colors.black,
          size: 30,
        ),
        actions: const [
          Icon(Icons.notifications_outlined, color: Colors.black,size: 24,),
          SizedBox(width: 12),
          Padding(
            padding: EdgeInsets.only(right: 18),
            child: Icon(Icons.search_sharp, color: Colors.black,size: 24,),
          ),
         
        ],
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          indicatorColor: Colors.orange,
          labelColor: Colors.orange,
          unselectedLabelColor: Colors.grey,
          tabs: const [
            Tab(text: 'All'),
            Tab(text: 'New'),
            Tab(text: 'Follow Up'),
            Tab(text: 'Booked'),
            Tab(text: 'In Transit'),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.sort), label: 'Leads'),
          BottomNavigationBarItem(icon: Icon(Icons.task), label: 'Tasks'),
          BottomNavigationBarItem(icon: Icon(Icons.report), label: 'Reports'),
           BottomNavigationBarItem(icon: Icon(Icons.more), label: 'more'),
        ],
        currentIndex: 1,
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey,
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildAllPage(),
          FutureBuilder<List<Estimate>>(
            future: _leads,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text("No leads available"));
              } else {
                return ListView.builder(
                  padding: EdgeInsets.all(10),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return LeadCard(lead: snapshot.data![index]);
                  },
                );
              }
            },
          ),
          _buildFollowUpPage(),
          _buildBookedPage(),
          _buildInTransitPage(),
        ],
      ),
    );
  }

  Widget _buildAllPage() {
    return Center(
      child: Text("All leads not available", style: TextStyle(fontSize: 18)),
    );
  }

  Widget _buildFollowUpPage() {
    return Center(
      child:
          Text("No follow-up leads available", style: TextStyle(fontSize: 18)),
    );
  }

  Widget _buildBookedPage() {
    return Center(
      child: Text("No booked leads available", style: TextStyle(fontSize: 18)),
    );
  }

  Widget _buildInTransitPage() {
    return Center(
      child:
          Text("No in-transit leads available", style: TextStyle(fontSize: 18)),
    );
  }
}

class LeadCard extends StatelessWidget {
  final Estimate lead;

  LeadCard({required this.lead});

  @override
  Widget build(BuildContext context) {
    DateTime dateTime = DateTime.parse(lead.orderDate);

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(2),
      ),
      margin: EdgeInsets.only(bottom: 7),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Text(
                  DateFormat.MMM().format(dateTime),
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  DateFormat.d().format(dateTime),
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange),
                ),
                Text(
                  DateFormat.Hm().format(dateTime),
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
            SizedBox(width: 10),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Bangalore",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    Text(
                      lead.estimateId,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                SizedBox(
                  height: 7,
                ),
                Text(
                  lead.movingFrom,
                  softWrap: true,
                  overflow: TextOverflow.visible,
                  style: TextStyle(fontSize: 13, color: Colors.grey),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.arrow_downward,
                      color: Colors.orange,
                    ),
                    LeadDetail(icon: Icons.apartment, label: lead.propertySize),
                    LeadDetail(
                        icon: Icons.shopping_cart, label: lead.totalItems),
                    LeadDetail(
                        icon: Icons.inventory,
                        label: '${int.parse(lead.totalItems) * 2 + 2}'), // Assuming you have another field
                    LeadDetail(
                        icon: Icons.directions_car, label: lead.distance),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text("Bangalore",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 10,
                ),
                Text(
                  lead.movingTo,
                  softWrap: true,
                  overflow: TextOverflow.visible,
                  style: TextStyle(fontSize: 13, color: Colors.grey),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            side: BorderSide(color: Colors.orange),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(2))),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LeadDetailsPage()),
                          );
                        },
                        child: Text(
                          'View Details',
                          style: TextStyle(color: Colors.orange),
                        ),
                      ),
                    ),
                    SizedBox(width: 10,),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(2))),
                        child: Text(
                          'Submit Quote',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }
}

class LeadDetail extends StatelessWidget {
  final IconData icon;
  final String label;

  LeadDetail({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: Colors.orange),
        SizedBox(height: 4),
        Text(label,
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
      ],
    );
  }
}
