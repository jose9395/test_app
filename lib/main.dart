import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:test_app/controller/fetch_leads.dart';
import 'dart:convert';

import 'package:test_app/model/lead_model.dart';

void main() => runApp(LeadApp());

class LeadApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LeadListScreen(),
    );
  }
}

class LeadListScreen extends StatefulWidget {
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
        title: Text('Leads', style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        leading: Icon(Icons.travel_explore, color: Colors.black,size: 30,),
        actions: [
          Icon(Icons.notifications_outlined, color: Colors.black),
          SizedBox(width: 8),
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: Icon(Icons.search, color: Colors.black),
          ),
          SizedBox(width: 8),
        ],
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          indicatorColor: Colors.orange,
          labelColor: Colors.orange,
          unselectedLabelColor: Colors.grey,
          tabs: [
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
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.leaderboard), label: 'Leads'),
          BottomNavigationBarItem(icon: Icon(Icons.task), label: 'Tasks'),
          BottomNavigationBarItem(icon: Icon(Icons.report), label: 'Reports'),
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
    // return Card(
    //   elevation: 3,
    //   margin: EdgeInsets.only(bottom: 16),
    //   shape: RoundedRectangleBorder(
    //     borderRadius: BorderRadius.circular(10),
    //   ),
    //   child: Padding(
    //     padding: EdgeInsets.all(16),
    //     child: Column(
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         Row(
    //           children: [
    //             Column(
    //               children: [
    //                 Text(lead.orderDate, style: TextStyle(color: Colors.red, fontSize: 12)),
    //                 // Text(lead.orderDate, style: TextStyle(color: Colors.red, fontSize: 32, fontWeight: FontWeight.bold)),
    //                 // Assuming the date and time are combined
    //               ],
    //             ),
    //             SizedBox(width: 16),
    //             Column(
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               children: [
    //                 Text(lead.movingFrom, style: TextStyle(color: Colors.grey )),

    //               ],
    //             ),
    //             // Spacer(),
    //             // Text(lead.items, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
    //           ],
    //         ),
    //         SizedBox(height: 16),
    //         Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //           children: [
    //             LeadDetail(icon: Icons.apartment, label: lead.propertySize),
    //             LeadDetail(icon: Icons.shopping_cart, label: lead.totalItems),
    //             LeadDetail(icon: Icons.inventory, label: '70 Boxes'), // Assuming you have another field
    //             LeadDetail(icon: Icons.directions_car, label: lead.distance),
    //           ],
    //         ),
    //         SizedBox(height: 16),
    //          Text(lead.movingTo, style: TextStyle(color: Colors.grey)),
    //         Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           children: [
    //             OutlinedButton(
    //               onPressed: () {},
    //               child: Text('View Details'),
    //             ),
    //             ElevatedButton(
    //               onPressed: () {},
    //               style: ElevatedButton.styleFrom(
    //                 backgroundColor: Colors.orange,
    //               ),
    //               child: Text('Submit Quote'),
    //             ),
    //           ],
    //         )
    //       ],
    //     ),
    //   ),
    // );
        DateTime dateTime = DateTime.parse(lead.orderDate);

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(2),
      ),
      margin: EdgeInsets.only(bottom: 10),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
             children: [
               Text(DateFormat.MMM().format(dateTime),style: TextStyle(fontWeight: FontWeight.bold),),
               Text(DateFormat.d().format(dateTime),style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: Colors.orange),),
                Text(DateFormat.Hm().format(dateTime),style: TextStyle(color: Colors.grey),),
             ],
            ),
            SizedBox(width:10),
            Expanded(child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  Text("Bangalore",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                  Text(lead.estimateId,style: TextStyle(fontWeight: FontWeight.bold),)
                ],),
                SizedBox(height: 7,),
                Text(lead.movingFrom,softWrap: true,overflow: TextOverflow.visible,style: TextStyle(fontSize: 13,color: Colors.grey),),
                SizedBox(height: 10,),             
             Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.arrow_downward,color: Colors.orange,),
                LeadDetail(icon: Icons.apartment, label: lead.propertySize),
                LeadDetail(icon: Icons.shopping_cart, label: lead.totalItems),
                LeadDetail(icon: Icons.inventory, label: '70 Boxes'), // Assuming you have another field
                LeadDetail(icon: Icons.directions_car, label: lead.distance),
              ],
            ),
            SizedBox(height: 10,),
             Text("Bangalore",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
             SizedBox(height: 10,),
             Text(lead.movingTo,softWrap: true,overflow: TextOverflow.visible,style: TextStyle(fontSize: 13,color: Colors.grey),),
             SizedBox(height: 10,),
             Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton(
                  style: OutlinedButton.styleFrom(side : BorderSide(color: Colors.orange),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2))
                  ),
                  onPressed: () {},
                  child: Text('View Details',style: TextStyle(color: Colors.orange),),
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2))
                  ),
                  child: Text('Submit Quote',style: TextStyle(color: Colors.white),),
                ),
              ],
            ),
            SizedBox(height: 10,),

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
        Text(label, style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey)),
      ],
    );
  }
}
