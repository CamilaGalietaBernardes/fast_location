import 'package:flutter/material.dart';
import '../colors/app_colors.dart';
import '../metrics/app_metrics.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final IconData? icon;

  const CustomButton({
    super.key,
    required this.label,
    this.onPressed,
    this.isLoading = false,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: AppMetrics.buttonHeight,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.surface,
          disabledBackgroundColor: AppColors.divider,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppMetrics.radiusMedium),
          ),
          elevation: AppMetrics.elevationLow,
        ),
        child: isLoading
            ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  color: AppColors.surface,
                  strokeWidth: 2.5,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null) ...[
                    Icon(icon, size: AppMetrics.iconMedium),
                    const SizedBox(width: AppMetrics.paddingSmall),
                  ],
                  Text(
                    label,
                    style: const TextStyle(
                      fontSize: AppMetrics.fontLarge,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
