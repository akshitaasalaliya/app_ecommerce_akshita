import 'package:flutter/material.dart';

void hideKeyboard() {
  FocusManager.instance.primaryFocus?.unfocus();
}

Widget emptyState() {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.search_off_rounded, size: 80, color: Colors.grey[300]),
        const SizedBox(height: 16),
        Text(
          'No products found',
          style: TextStyle(color: Colors.grey[600], fontSize: 16, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        Text(
          'Try searching for something else',
          style: TextStyle(color: Colors.grey[400], fontSize: 13),
        ),
      ],
    ),
  );
}

Widget networkImageUrl(String stUrl, double stSize){
  return Image.network(
    stUrl,
    width: stSize,
    height: stSize,
    fit: BoxFit.fill,
    loadingBuilder: (context, child, loadingProgress) {
      if (loadingProgress == null) return child;
      return Center(
        child: SizedBox(
          width: 24,
          height: 24,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF4F46E5)),
          ),
        ),
      );
    },
    errorBuilder: (context, error, stackTrace) {
      return Icon(Icons.image_not_supported_outlined, size: 25,);
    },
  );
}