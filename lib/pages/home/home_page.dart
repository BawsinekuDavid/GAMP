// lib/pages/home_page.dart
import 'package:flutter/material.dart';
import 'package:gmarket_app/ADMIN/system_admin_dashboard.dart';
import 'package:gmarket_app/Endpoints/vendors_api.dart';
import 'package:gmarket_app/components/text_field.dart';
import 'package:gmarket_app/constant.dart';
import '../../models/vendors_module.dart';
import 'grid.dart';
import '../Vendors/venor_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  
  late TabController _tabController;
  final List<String> _tabs = ['All', 'Fruits', 'Vegetables', 'Meat & Fish'];
  late Future<List<Vendor>> _futureVendors;
  final VendorsApi _vendorsApi = VendorsApi();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
    _futureVendors = _vendorsApi.fetchAllVendors();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade50,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 180,
         backgroundColor: Colors.green.shade50,
        elevation: 0,
        title: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Find Fresh Produce",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                IconButton(
                  icon: const Row(
                    children: [
                      Icon(Icons.location_on, color: Colors.green),
                      SizedBox(width: 4),
                      Text(
                        "Current Location",
                        style: TextStyle(color: Colors.green),
                      ),
                    ],
                  ),
                  onPressed: () {
                    // Add location fetching logic here
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: SearchField(
                    icon: const Icon(Icons.search, color: Colors.green),
                    hintText: "Search for produce...",
                    bgColor: Colors.white,
                  ),
                ),
                const SizedBox(width: 10),
                MySearchBtn(
                  lab: "Search",
                  colorState: colors,
                  onPressed: () {},
                  textColorState: Colors.white,
                ),
              ],
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // Categories Title
          const Padding(
            padding: EdgeInsets.only(left: 16, top: 8),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Categories",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          
         TabBar(
          
          controller: _tabController,
          tabs: _tabs.map((tab) => Tab(text: tab)).toList(),
          labelColor: Colors.white,
          unselectedLabelColor: Colors.black,
          dividerColor: Colors.white,
          indicatorSize: TabBarIndicatorSize.tab,
          indicator: BoxDecoration(
            shape: BoxShape.rectangle,
            color: colors,
            borderRadius: BorderRadius.circular(10)
          ),
          
        ),
          
          // Main Content Area
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const [
                ProductGrid(category: 'All'),
                ProductGrid(category: 'Fruit'),
                ProductGrid(category: 'Vegetables'),
                ProductGrid(category: 'Meat'),
              ],
            ),
          ),
          
          // Vendors Section
       // Replace the existing Vendors Section with this:
Container(
  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.1),
        blurRadius: 8,
        offset: const Offset(0, -4),
      ),
    ],
  ),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        "Featured Vendors",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(height: 8),
      SizedBox(
        height: 120,
        child: FutureBuilder<List<Vendor>>(
          future: _futureVendors,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No vendors available'));
            } else {
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: VendorCard(vendor: snapshot.data![index]),
                  );
                },
              );
            }
          },
        ),
      ),
    ],
  ),
),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SystemAdminDashboard(),
            ),
          );
        },
        backgroundColor: colors,
        foregroundColor: Colors.white,
        child: const Icon(Icons.settings),
      ),
    );
  }
}

