import 'package:flutter/material.dart';
import 'package:yum_gott_app/core/theme/app_theme.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final String? actionText;
  final VoidCallback? onActionTap;

  const SectionHeader({
    Key? key,
    required this.title,
    this.actionText,
    this.onActionTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: AppTheme.headingSmall.copyWith(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          if (actionText != null && onActionTap != null)
            GestureDetector(
              onTap: onActionTap,
              child: Text(
                actionText!,
                style: AppTheme.bodyMedium.copyWith(
                  color: AppTheme.primaryColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
        ],
      ),
    );
  }
}