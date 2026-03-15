import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OtpField extends StatelessWidget {
  final int fieldCount;
  final ValueChanged<String>? onCompleted;
  final TextEditingController? controller;

  const OtpField({
    Key? key,
    this.fieldCount = 4,
    this.onCompleted,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: List.generate(fieldCount, (index) {
          return SizedBox(
            height: 50,
            width: 50,
            child: TextFormField(
              style: Theme.of(context).textTheme.headlineMedium,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              onChanged: (value) {
                if (value.length == 1) {
                  if (index < fieldCount - 1) {
                    FocusScope.of(context).nextFocus();
                  } else {
                    // Last field - get complete OTP
                    String otp = '';
                    // Aap yahan apna logic laga sakte ho OTP collect karne ka
                    if (onCompleted != null) {
                      onCompleted!(otp);
                    }
                  }
                } else if (value.isEmpty && index > 0) {
                  FocusScope.of(context).previousFocus();
                }
              },
              onSaved: (pin) {},
              autofocus: index == 0,
              inputFormatters: [
                LengthLimitingTextInputFormatter(1),
                FilteringTextInputFormatter.digitsOnly,
              ],
              decoration: InputDecoration(
                hintText: "0",
                  hintMaxLines: 1,
                hintStyle: TextStyle(
                  color: Colors.grey.shade400
                ),
                filled: true,
                fillColor: Colors.transparent,
                contentPadding: EdgeInsets.zero,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(35),
                  borderSide: BorderSide(color: Colors.grey.shade300, width: 2),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(35),
                  // borderSide: BorderSide(color: Colors.grey.shade300, width: 2),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(35),
                  borderSide: BorderSide(color: Colors.orange, width: 3),
                )
              ),
            ),
          );
        }),
      ),
    );
  }
}


class OTPWidget extends StatefulWidget {
  final int otpLength;
  final Function(String) onComplete;
  final Color filledColor;
  final Color emptyColor;
  final double fieldSize;

  const OTPWidget({
    Key? key,
    this.otpLength = 4,
    required this.onComplete,
    this.filledColor = const Color(0xFF2C2C2C),
    this.emptyColor = const Color(0xFFE0D5F0),
    this.fieldSize = 60,
  }) : super(key: key);

  @override
  State<OTPWidget> createState() => _OTPWidgetState();
}

class _OTPWidgetState extends State<OTPWidget> {
  late List<TextEditingController> controllers;
  late List<FocusNode> focusNodes;
  late List<String> otpValues;

  @override
  void initState() {
    super.initState();
    controllers = List.generate(
      widget.otpLength,
          (index) => TextEditingController(),
    );
    focusNodes = List.generate(
      widget.otpLength,
          (index) => FocusNode(),
    );
    otpValues = List.generate(widget.otpLength, (index) => '');
  }

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    for (var focusNode in focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  void _onOTPFieldChanged(String value, int index) {
    if (value.length > 1) {
      // Handle paste
      String pastedValue = value.replaceAll(RegExp(r'[^0-9]'), '');
      for (int i = 0; i < pastedValue.length && i < widget.otpLength; i++) {
        if (i < controllers.length) {
          controllers[i].text = pastedValue[i];
          otpValues[i] = pastedValue[i];
        }
      }
      _checkOTPComplete();
      return;
    }

    if (value.isEmpty) {
      otpValues[index] = '';
      if (index > 0) {
        focusNodes[index - 1].requestFocus();
      }
    } else if (value.isNotEmpty && RegExp(r'[0-9]').hasMatch(value)) {
      otpValues[index] = value;
      if (index < widget.otpLength - 1) {
        focusNodes[index + 1].requestFocus();
      }
      _checkOTPComplete();
    } else {
      controllers[index].clear();
    }
  }

  void _checkOTPComplete() {
    String otp = otpValues.join();
    if (otp.length == widget.otpLength) {
      widget.onComplete(otp);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Enter OTP',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Color(0xFF2C2C2C),
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              widget.otpLength,
                  (index) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: SizedBox(
                  width: widget.fieldSize,
                  height: widget.fieldSize,
                  child: TextField(
                    controller: controllers[index],
                    focusNode: focusNodes[index],
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(1),
                    ],
                    onChanged: (value) => _onOTPFieldChanged(value, index),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: controllers[index].text.isNotEmpty
                          ? widget.filledColor
                          : widget.emptyColor,
                      counterText: '',
                      contentPadding: EdgeInsets.zero,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(
                          color: controllers[index].text.isNotEmpty
                              ? widget.filledColor
                              : Colors.transparent,
                          width: 2,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(
                          color: controllers[index].text.isNotEmpty
                              ? widget.filledColor
                              : Colors.transparent,
                          width: 2,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(
                          color: widget.filledColor,
                          width: 2,
                        ),
                      ),
                    ),
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: controllers[index].text.isNotEmpty
                          ? Colors.white
                          : widget.emptyColor,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              String otp = otpValues.join();
              if (otp.length == widget.otpLength) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('OTP Submitted: $otp')),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Please enter complete OTP')),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2C2C2C),
              padding: const EdgeInsets.symmetric(
                horizontal: 48,
                vertical: 12,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'Verify',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
