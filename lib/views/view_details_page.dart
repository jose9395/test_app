import 'package:flutter/material.dart';
import 'package:test_app/model/lead_model.dart';
import 'package:test_app/views/floor_info.dart';

class LeadDetailsPage extends StatefulWidget {
  final Estimate lead;
  LeadDetailsPage({required this.lead});

  @override
  _LeadDetailsPageState createState() => _LeadDetailsPageState();
}

class _LeadDetailsPageState extends State<LeadDetailsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Leads',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: const [
          Icon(Icons.notifications_outlined, color: Colors.black),
          SizedBox(width: 12),
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: Icon(Icons.search, color: Colors.black),
          ),
          SizedBox(width: 8),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Items'),
            Tab(text: 'Floor Info'),
            Tab(text: 'Send Quote'),
          ],
          indicatorColor: Colors.orange,
          labelColor: Colors.orange,
          unselectedLabelColor: Colors.grey,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildItemsTab(),
          buildFloorInfoTab(lead: widget.lead),
          const Center(child: Text('Send Quote Tab')),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.leaderboard), label: 'Leads'),
          BottomNavigationBarItem(icon: Icon(Icons.task), label: 'Tasks'),
          BottomNavigationBarItem(icon: Icon(Icons.report), label: 'Reports'),
          BottomNavigationBarItem(icon: Icon(Icons.more), label: 'More'),
        ],
        currentIndex: 1,
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
      ),
    );
  }

  Widget _buildItemsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildExpandableSection(
              'Living Room',
              [
                _buildFurnitureList([
                  _buildFurnitureItem(
                      'L Type Sofa', 'Small | Leather', '1', Icons.weekend),
                  _buildFurnitureItem('Single Seater Sofa', 'Large | Leather',
                      '1', Icons.weekend),
                  _buildFurnitureItem(
                      'Tea Table', 'Medium | Wooden', '1', Icons.table_bar),
                  _buildFurnitureItem(
                      'Entertainment Unit', 'Medium | Wooden', '1', Icons.tv),
                  _buildFurnitureItem(
                      'Wooden Chairs', 'Small', '2', Icons.chair),
                  _buildFurnitureItem(
                      'Swing', 'Large | Wooden', '1', Icons.toys),
                  _buildFurnitureItem(
                      'Foldable Chairs', 'Small | Steel', '4', Icons.chair),
                ]),
              ],
              initiallyExpanded: true),
          _buildExpandableSection('Bed Room', [
            _buildFurnitureList([
              _buildFurnitureItem(
                  'Double Bed', 'Large | Wooden', '1', Icons.bed),
              _buildFurnitureItem(
                  'Wardrobe', 'Large | Wooden', '1', Icons.storage),
              _buildFurnitureItem('Dressing Table', 'Medium | Glass', '1',
                  Icons.table_bar_outlined),
              _buildFurnitureItem(
                  'Nightstand', 'Small | Wooden', '2', Icons.table_bar),
            ]),
          ]),
          _buildExpandableSection('Custom Items', [
            _buildCustomItem(
                'Antique Clock',
                '200 year old British Period wooden perpetual clock, very unique and rare clock.',
                'L: 6 ft',
                'W: 6 ft',
                'H: 6 ft'),
            _buildCustomItem(
                'Antique Clock',
                '200 year old British Period wooden perpetual clock, very unique and rare clock.',
                'L: 6 ft',
                'W: 6 ft',
                'H: 6 ft'),
          ]),
        ],
      ),
    );
  }

  Widget _buildExpandableSection(String title, List<Widget> items,
      {bool initiallyExpanded = false}) {
    return ExpansionTile(
      title: Text(title,
          style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: Colors.deepOrange)),
      children: items,
      initiallyExpanded: initiallyExpanded,
      // iconColor: Colors.grey[300],
      // collapsedIconColor: Colors.grey[300],
    );
  }

  Widget _buildFurnitureList(List<Widget> items) {
    return Column(
      children: items,
    );
  }

  Widget _buildFurnitureItem(
      String name, String details, String count, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
      child: Row(
        children: [
          Icon(icon, color: Colors.grey),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(details, style: const TextStyle(color: Colors.grey)),
            ],
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: Text(count,
                style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomItem(String name, String description, String length,
      String width, String height) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(description, style: const TextStyle(color: Colors.grey)),
          const SizedBox(height: 8),
          Row(
            children: [
              _buildMeasurement('L', length),
              const SizedBox(width: 16),
              _buildMeasurement('W', width),
              const SizedBox(width: 16),
              _buildMeasurement('H', height),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMeasurement(String label, String value) {
    return RichText(
      text: TextSpan(
        text: '$label: ',
        style:
            const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        children: [
          TextSpan(text: value, style: const TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}
