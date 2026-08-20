import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healing/presentation/model/common/doc_model.dart';
import 'package:healing/presentation/model/response/enquiries_response_model.dart';
import 'package:healing/presentation/model/response/error_response_model.dart';
import 'package:healing/repository/enquiries_and_booking_repository.dart';
import 'package:healing/common/common_methods.dart';

class ConsultationRequestController extends GetxController {
  final EnquiriesAndBookingRepository _repository = EnquiriesAndBookingRepository();

  final TextEditingController searchController = TextEditingController();
  final List<DocModel> allEnquiries = [];
  List<DocModel> filteredEnquiries = [];

  String selectedStatus = 'All Status';
  bool isLoading = false;

  @override
  void onInit() {
    super.onInit();
    fetchEnquiries();
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  Future<void> fetchEnquiries() async {
    isLoading = true;
    update();
    try {
      await Future.delayed(const Duration(milliseconds: 200));

      final List<Map<String, dynamic>> mockData = [
        {
          "id": 31,
          "status": "pending",
          "createdAt": "2026-05-04T10:00:00Z",
          "user": {
            "name": "Pappu Kumar Yadav"
          },
          "doctors": [
            {
              "name": "Dr. Abhishek Shukla"
            }
          ]
        },
        {
          "id": 30,
          "status": "pending",
          "createdAt": "2026-05-01T10:00:00Z",
          "user": {
            "name": "Pappu Kumar Yadav"
          },
          "doctors": [
            {
              "name": "Dr. Abhishek Shukla"
            }
          ]
        },
        {
          "id": 29,
          "status": "converted",
          "createdAt": "2026-04-30T10:00:00Z",
          "user": {
            "name": "Pappu Kumar Yadav"
          },
          "doctors": [
            {
              "name": "Dr. Karan"
            }
          ]
        }
      ];

      allEnquiries.clear();
      for (var item in mockData) {
        allEnquiries.add(DocModel.fromJson(item));
      }
      applyFilters();
    } catch (e) {
      log('ConsultationRequestController: Error loading enquiries: $e');
    } finally {
      isLoading = false;
      update();
    }
  }

  void onSearchChanged(String query) {
    applyFilters();
  }

  void onStatusChanged(String? status) {
    if (status != null) {
      selectedStatus = status;
      applyFilters();
    }
  }

  void applyFilters() {
    final query = searchController.text.trim().toLowerCase();
    filteredEnquiries = allEnquiries.where((doc) {
      // 1. Search Query Match (matches ID e.g. ENQ-31, or guest name)
      final idText = 'enq-${doc.id ?? ''}';
      
      String guestNameText = '';
      if (doc.user?.name != null) {
        guestNameText = doc.user!.name!.toLowerCase();
      } else if (doc.enquiries?.guestDetails != null && doc.enquiries!.guestDetails!.isNotEmpty) {
        guestNameText = (doc.enquiries!.guestDetails!.first.name ?? '').toLowerCase();
      }

      final matchesQuery = query.isEmpty ||
          idText.contains(query) ||
          guestNameText.contains(query);

      // 2. Status Match
      final matchesStatus = selectedStatus == 'All Status' ||
          (doc.status ?? '').toLowerCase() == selectedStatus.toLowerCase();

      return matchesQuery && matchesStatus;
    }).toList();
    
    update();
  }
}
