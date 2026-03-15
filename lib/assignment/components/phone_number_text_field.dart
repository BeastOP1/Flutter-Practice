import 'package:flutter/material.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/services.dart';

class PhoneInputWithPackage extends StatefulWidget {
  const PhoneInputWithPackage({super.key});

  @override
  _PhoneInputWithPackageState createState() {
    return _PhoneInputWithPackageState();
  }
}

class _PhoneInputWithPackageState extends State<PhoneInputWithPackage> {
  final TextEditingController _phoneController = TextEditingController();
  String _countryCode = '+62';
  String _countryFlag = '🇮🇩';

  @override
  Widget build(BuildContext context) {
    return Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[100]!),
            borderRadius: BorderRadius.circular(16),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                blurRadius: 10,
                spreadRadius: 1,
                offset: Offset(0, 5),
                color: Colors.grey.shade200
              )
            ]
          ),
          margin: EdgeInsetsDirectional.all(40),
          padding: EdgeInsetsGeometry.all(8),
          child: Row(
            children: [
              // Country Code Picker
              CountryCodePicker(
                onChanged: (country) {
                  setState(() {
                    _countryCode = country.dialCode!;
                    _countryFlag = country.flagUri!;
                  });
                },
                flagDecoration:BoxDecoration(
                  shape: BoxShape.rectangle,
                ),
                initialSelection: 'PK',
                favorite: ['+92', 'PK'],
                showCountryOnly: false,
                showOnlyCountryWhenClosed: false,
                alignLeft: false,
                showDropDownButton: true,
                textStyle: TextStyle(fontSize: 16, color: Colors.black),
                padding: EdgeInsets.zero,
              ),

              Expanded(
                child: TextField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    hintText: "82227580727",
                    border: InputBorder.none,
                    hintMaxLines: 1,
                    // contentPadding: EdgeInsets.symmetric(horizontal: 16),
                  ),
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(13),
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  maxLines: 1,
                ),
              ),
            ],
          ),
        );
  }
}