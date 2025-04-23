import 'package:flutter/material.dart';

class HeaderBannerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
            'https://in.flowercorner.vn/uploads/P67b80eac1dca11.10889059.webp',
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
