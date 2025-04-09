import 'package:flutter/material.dart';
import 'package:yum_gott_app/core/theme/app_theme.dart';
import 'package:yum_gott_app/features/home/domain/models/category_model.dart';

class CategoryItem extends StatelessWidget {
  final Category category;
  final bool isSelected;
  final VoidCallback onTap;

  const CategoryItem({
    Key? key,
    required this.category,
    this.isSelected = false,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 12),
        child: Column(
          children: [
            // Category icon with background
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                color: isSelected ? AppTheme.primaryColor : const Color(0xFF1F1F29),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Image.asset(
                  category.iconUrl,
                  width: 32,
                  height: 32,
                  color: isSelected ? Colors.black : AppTheme.lightTextColor,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(
                      Icons.fastfood,
                      size: 32,
                      color: isSelected ? Colors.black : AppTheme.lightTextColor,
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 8),
            // Category name
            Text(
              category.name,
              style: AppTheme.bodySmall.copyWith(
                color: isSelected ? AppTheme.primaryColor : AppTheme.lightTextColor,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}