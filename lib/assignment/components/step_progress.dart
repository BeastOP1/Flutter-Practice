import 'dart:math';

import 'package:flutter/material.dart';

class StepProgressBar extends StatefulWidget {
  final String buttonText;
  final int currentStep;
  final int totalSteps;
  final bool showButton;
  final VoidCallback? onButtonTap;
  final VoidCallback? onPreviousTap;

  const StepProgressBar({
    super.key,
    this.buttonText = "Next",
    required this.currentStep,
    this.showButton = true,
    this.onButtonTap,
    required this.totalSteps,
    this.onPreviousTap,
  });

  @override
  State<StepProgressBar> createState() => _StepProgressBarState();
}

class _StepProgressBarState extends State<StepProgressBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _progressAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500), // microseconds nahi, milliseconds
    );

    _progressAnimation = Tween<double>(
      begin: 0,
      end: widget.currentStep / widget.totalSteps,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.fastLinearToSlowEaseIn,
      ),
    );

    _animationController.forward();
  }

  @override
  void didUpdateWidget(StepProgressBar oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.currentStep != widget.currentStep) {
      _animationController.reset();
      _progressAnimation = Tween<double>(
        begin: oldWidget.currentStep / oldWidget.totalSteps,
        end: widget.currentStep / widget.totalSteps,
      ).animate(
        CurvedAnimation(
          parent: _animationController,
          curve: Curves.easeInOut,
        ),
      );
      _animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Row(
        children: [
          // Back Button
          GestureDetector(
            onTap: widget.onPreviousTap ?? () {
              // Default behavior: pop current screen
              Navigator.pop(context);
            },
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.transparent,
              ),
              child: Icon(
                Icons.arrow_back_ios,
                size: 30,
                color: Colors.black87,
              ),
            ),
          ),

          SizedBox(width: 65),

          // Progress Bar - Expanded dena zaroori hai
          Expanded(
            child: AnimatedBuilder(
              animation: _progressAnimation,
              builder: (context, child) {
                return
                    LinearProgressIndicator(
                      value: _progressAnimation.value,
                      backgroundColor: Colors.grey[200],
                      valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF7265E3)),
                      minHeight: 8,
                      borderRadius: BorderRadius.circular(8),
                    );
              },

            ),
          ),

          SizedBox(width: 65),

          // Next Button
          if (widget.showButton)
            TextButton(
              onPressed: widget.onButtonTap,
              style: TextButton.styleFrom(
                foregroundColor: Color(0xFF7265E3),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(
                widget.buttonText,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18
                ),
              ),
            ),

          if(widget.showButton ==false)
            SizedBox(width: 65),


        ],
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}