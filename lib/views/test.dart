// import 'package:flutter/material.dart';
// import 'package:test_app/model/lead_model.dart';
// import 'package:test_app/views/floor_info.dart';

// class LeadDetailsPage extends StatefulWidget {
//   final Estimate lead;
//   LeadDetailsPage({required this.lead});

//   @override
//   _LeadDetailsPageState createState() => _LeadDetailsPageState();
// }

// class _LeadDetailsPageState extends State<LeadDetailsPage> with SingleTickerProviderStateMixin {
//   late TabController _tabController;

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 3, vsync: this);
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('New Leads', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
//         backgroundColor: Colors.white,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back, color: Colors.black),
//           onPressed: () => Navigator.pop(context),
//         ),
//         actions: [
//           Icon(Icons.notifications_outlined, color: Colors.black),
//           SizedBox(width: 8),
//           Padding(
//             padding: const EdgeInsets.only(right: 15),
//             child: Icon(Icons.search, color: Colors.black),
//           ),
//           SizedBox(width: 8),
//         ],
//         bottom: TabBar(
//           controller: _tabController,
//           tabs: [
//             Tab(text: 'Items'),
//             Tab(text: 'Floor Info'),
//             Tab(text: 'Send Quote'),
//           ],
//           indicatorColor: Colors.orange,
//           labelColor: Colors.orange,
//           unselectedLabelColor: Colors.grey,
//         ),
//       ),
//       body: TabBarView(
//         controller: _tabController,
//         children: [
//           _buildItemsTab(),
//          buildFloorInfoTab(lead : widget.lead),
//           Center(child: Text('Send Quote Tab')),
//         ],
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         items: [
//           BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
//           BottomNavigationBarItem(icon: Icon(Icons.leaderboard), label: 'Leads'),
//           BottomNavigationBarItem(icon: Icon(Icons.task), label: 'Tasks'),
//           BottomNavigationBarItem(icon: Icon(Icons.report), label: 'Reports'),
//         ],
//         currentIndex: 1,
//         selectedItemColor: Colors.orange,
//         unselectedItemColor: Colors.grey,
//       ),
//     );
//   }

//   Widget _buildItemsTab() {
//     return SingleChildScrollView(
//       padding: EdgeInsets.all(16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           _buildSectionTitle('Living Room'),
//           _buildFurnitureList([
//             _buildFurnitureItem('L Type Sofa', 'Small | Leather', '1', Icons.weekend),
//             _buildFurnitureItem('Single Seater Sofa', 'Large | Leather', '1', Icons.weekend),
//             _buildFurnitureItem('Tea Table', 'Medium | Wooden', '1', Icons.table_bar),
//             _buildFurnitureItem('Entertainment Unit', 'Medium | Wooden', '1', Icons.tv),
//             _buildFurnitureItem('Wooden Chairs', 'Small', '2', Icons.chair),
//             _buildFurnitureItem('Swing', 'Large | Wooden', '1', Icons.toys),
//             _buildFurnitureItem('Foldable Chairs', 'Small | Steel', '4', Icons.chair),
//           ]),
//           _buildSectionTitle('Bed Room'),
//           _buildExpandableSection('Custom Items', [
//             _buildCustomItem('Antique Clock', '200 year old British Period wooden perpetual clock, very unique and rare clock.', 'L: 6 ft', 'W: 6 ft', 'H: 6 ft'),
//             _buildCustomItem('Antique Clock', '200 year old British Period wooden perpetual clock, very unique and rare clock.', 'L: 6 ft', 'W: 6 ft', 'H: 6 ft'),
//           ]),
//         ],
//       ),
//     );
//   }

//   Widget _buildSectionTitle(String title) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 16.0),
//       child: Row(
//         children: [
//           Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.orange)),
//           Spacer(),
//           Icon(Icons.expand_more, color: Colors.grey),
//         ],
//       ),
//     );
//   }

//   Widget _buildFurnitureList(List<Widget> items) {
//     return Column(
//       children: items,
//     );
//   }

//   Widget _buildFurnitureItem(String name, String details, String count, IconData icon) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Row(
//         children: [
//           Icon(icon, color: Colors.grey),
//           SizedBox(width: 10),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
//               Text(details, style: TextStyle(color: Colors.grey)),
//             ],
//           ),
//           Spacer(),
//           Text(count, style: TextStyle(fontWeight: FontWeight.bold)),
//         ],
//       ),
//     );
//   }

//   Widget _buildExpandableSection(String title, List<Widget> items) {
//     return ExpansionTile(
//       title: Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.orange)),
//       children: items,
//     );
//   }

//   Widget _buildCustomItem(String name, String description, String length, String width, String height) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
//           SizedBox(height: 8),
//           Text(description, style: TextStyle(color: Colors.grey)),
//           SizedBox(height: 8),
//           Row(
//             children: [
//               _buildMeasurement('L', length),
//               SizedBox(width: 16),
//               _buildMeasurement('W', width),
//               SizedBox(width: 16),
//               _buildMeasurement('H', height),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildMeasurement(String label, String value) {
//     return RichText(
//       text: TextSpan(
//         text: '$label: ',
//         style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
//         children: [
//           TextSpan(text: value, style: TextStyle(color: Colors.grey)),
//         ],
//       ),
//     );
//   }
// }


