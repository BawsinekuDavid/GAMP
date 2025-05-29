import 'package:flutter/material.dart';
import 'package:gmarket_app/constant.dart';

import 'package:gmarket_app/models/vendors_module.dart';
import '../../Endpoints/vendors_api.dart';
import 'venor_card.dart';

class VendorsSection extends StatefulWidget {
  const VendorsSection({super.key});

  @override
  State<VendorsSection> createState() => _VendorsSectionState();
}

class _VendorsSectionState extends State<VendorsSection> {
  late Future<List<Vendor>> _vendorsFuture;
  final VendorsApi _vendorsApi = VendorsApi();

  @override
  void initState() {
    super.initState();
    _vendorsFuture = _vendorsApi.fetchAllVendors();
  }

  Future<void> _refreshVendors() async {
    setState(() {
      _vendorsFuture = _vendorsApi.fetchAllVendors();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: colors,
          foregroundColor: Colors.white,
          title: const Text("Featured Vendors"),
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: _refreshVendors,
            ),
          ],
        ),
        body: Container(
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
              SizedBox(
                height: 130,
                child: FutureBuilder<List<Vendor>>(
                  future: _vendorsFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Error loading vendors',
                              style: TextStyle(color: Colors.red[400]),
                            ),
                            TextButton(
                              onPressed: _refreshVendors,
                              child: const Text('Retry'),
                            ),
                          ],
                        ),
                      );
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(child: Text('No vendors available'));
                    }

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
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
