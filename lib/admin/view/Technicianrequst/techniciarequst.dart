import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mobile_servies/admin/controller/tech_rqst_provider.dart';
import 'package:mobile_servies/admin/view/DragBtn/draggable_button.dart';
import 'package:mobile_servies/admin/view/Technicianrequst/reqst_widget.dart';
import 'package:mobile_servies/tech/widgets/shimmer.dart';
import 'package:mobile_servies/tech/widgets/textField.dart';
import 'package:mobile_servies/user/View/UserHome/homeHeader.dart';
import 'package:provider/provider.dart';

class Techniciarequstpage extends StatefulWidget {
  const Techniciarequstpage({super.key});

  @override
  _TechniciarequstpageState createState() => _TechniciarequstpageState();
}

class _TechniciarequstpageState extends State<Techniciarequstpage> {
  bool _hasFetched = false;
  final TextEditingController searchCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = context.read<TechnicianRequestProvider>();
      if (!provider.isLoading && provider.requests.isEmpty && !_hasFetched) {
        provider.fetchRequests();
        _hasFetched = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    const validStatuses = ['All', 'Pending', 'Approved', 'Rejected'];

    return Scaffold(
      body: Consumer<TechnicianRequestProvider>(
        builder: (context, provider, child) {
          if (provider.errorMessage != null) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(provider.errorMessage!),
                  backgroundColor: provider.errorMessage!.contains('Approved')
                      ? Colors.green
                      : provider.errorMessage!.contains('Rejected')
                          ? Colors.red
                          : Colors.green[600],
                  duration: const Duration(seconds: 3),
                ),
              );
              provider.clearErrorMessage();
            });
          }

          if (!validStatuses.contains(provider.statusFilter)) {
            provider.setStatusFilter('All');
          }

          return Stack(
            children: [
              SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppLogo(),
                          const SizedBox(height: 24),
                          const Text(
                            "Technician Requests",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              fontSize: 28,
                            ),
                          ),
                          const Text(
                            "Manage bookings, services, devices, and technicians",
                            style: TextStyle(color: Colors.grey, fontSize: 14),
                          ),
                          const SizedBox(height: 16),
                          techRequestSearchField(
                            context: context,
                            onChanged: (value) {
                              provider.searchFn(value);
                            },
                            controller: searchCtrl,
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "All Requests",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                              DropdownButton<String>(
                                value: provider.statusFilter,
                                dropdownColor: const Color(0xFF718355),
                                style: const TextStyle(color: Colors.white, fontSize: 14),
                                items: validStatuses
                                    .map((String value) => DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value, style: const TextStyle(color: Colors.white)),
                                        ))
                                    .toList(),
                                onChanged: (value) {
                                  if (value != null && validStatuses.contains(value)) {
                                    provider.setStatusFilter(value);
                                    _hasFetched = false;
                                    searchCtrl.clear();
                                    provider.searchFn('');
                                  }
                                },
                                icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
                                underline: Container(height: 1, color: Colors.white70),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: provider.isLoading
                              ? buildShimmerList()
                              : provider.searchedList.isEmpty
                                  ? Center(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.search_off,
                                            size: 50,
                                            color: Colors.grey[400],
                                          ),
                                          const SizedBox(height: 10),
                                          Text(
                                            'No technician requests found',
                                            style: TextStyle(
                                              color: Colors.grey[600],
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          if (provider.errorMessage != null)
                                            Padding(
                                              padding: const EdgeInsets.only(top: 10),
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  provider.fetchRequests();
                                                  _hasFetched = false;
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: const Color(0xFF718355),
                                                  foregroundColor: Colors.white,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(8),
                                                  ),
                                                ),
                                                child: const Text('Retry'),
                                              ),
                                            ),
                                        ],
                                      ),
                                    )
                                  : RefreshIndicator(
                                    onRefresh: () => provider.refreshRqsts(),
                                    child: ListView.builder(
                                        itemCount: provider.searchedList.length,
                                        itemBuilder: (context, index) {
                                          final request = provider.searchedList[index];
                                          return Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(10),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black.withOpacity(0.1),
                                                  blurRadius: 5,
                                                  offset: const Offset(0, 2),
                                                ),
                                              ],
                                            ),
                                            child: buildTechnicianRequestCard(
                                              context: context,
                                              request: request,
                                            ),
                                          );
                                        },
                                      ),
                                  ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              DraggableFabMenu(adminDashboardKey: GlobalKey()),
            ],
          );
        },
      ),
    );
  }
}