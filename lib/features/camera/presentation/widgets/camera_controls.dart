import 'package:flutter/material.dart';
import 'package:yum_gott_app/core/theme/app_theme.dart';

class CameraControls extends StatelessWidget {
  final bool isRecording;
  final bool isFlashOn;
  final bool isFrontCamera;
  final VoidCallback onSwitchCamera;
  final VoidCallback onToggleFlash;
  final VoidCallback onStartRecording;
  final VoidCallback onStopRecording;
  final VoidCallback onClose;

  const CameraControls({
    Key? key,
    required this.isRecording,
    required this.isFlashOn,
    required this.isFrontCamera,
    required this.onSwitchCamera,
    required this.onToggleFlash,
    required this.onStartRecording,
    required this.onStopRecording,
    required this.onClose,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Close button (top left)
        Positioned(
          top: 60,
          left: 16,
          child: _buildControlButton(
            icon: Icons.close,
            onTap: onClose,
          ),
        ),
        
        // Flash button (top right)
        Positioned(
          top: 60,
          right: 16,
          child: _buildControlButton(
            icon: isFlashOn ? Icons.flash_on : Icons.flash_off,
            onTap: onToggleFlash,
          ),
        ),
        
        // Switch camera button (below flash)
        Positioned(
          top: 110,
          right: 16,
          child: _buildControlButton(
            icon: Icons.flip_camera_ios,
            onTap: onSwitchCamera,
          ),
        ),
        
        // Bottom controls
        Positioned(
          bottom: 40,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Record button
              GestureDetector(
                onTap: isRecording ? onStopRecording : onStartRecording,
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: 5,
                    ),
                  ),
                  child: Center(
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: isRecording ? Colors.red : AppTheme.primaryColor,
                        shape: BoxShape.circle,
                      ),
                      child: isRecording
                          ? const Icon(
                              Icons.stop,
                              color: Colors.white,
                              size: 30,
                            )
                          : null,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
  
  Widget _buildControlButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.5),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          icon,
          color: Colors.white,
          size: 24,
        ),
      ),
    );
  }
}