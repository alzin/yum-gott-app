import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yum_gott_app/core/theme/app_theme.dart';
import 'package:yum_gott_app/routes.dart';

class SearchBarWidget extends StatelessWidget {
  final VoidCallback? onFilterTap;
  
  const SearchBarWidget({
    Key? key,
    this.onFilterTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F29),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          // Search icon
          const Padding(
            padding: EdgeInsets.only(left: 16),
            child: Icon(
              Icons.search,
              color: Colors.grey,
            ),
          ),
          
          // Search input field
          Expanded(
            child: GestureDetector(
              onTap: () {
                // Navigate to search screen
                Get.toNamed(AppRoutes.search);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Text(
                  'Search for restaurants or dishes',
                  style: AppTheme.bodyMedium.copyWith(
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          ),
          
          // Filter button
          GestureDetector(
            onTap: onFilterTap,
            child: Container(
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                color: AppTheme.primaryColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.tune,
                color: Colors.black,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}