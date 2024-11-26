import 'package:dis_app/pages/account/account_screen.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import '../../../utils/constants/colors.dart';

class SellSection extends StatelessWidget {
  final List<String> sellImagePaths;
  final SellFilter selectedFilter;
  final ValueChanged<SellFilter> onFilterSelect;

  const SellSection({
    Key? key,
    required this.sellImagePaths,
    required this.selectedFilter,
    required this.onFilterSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildFilterRow(),
        _buildImageGrid(context),
      ],
    );
  }

  Widget _buildFilterRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _buildFilterButton("All", SellFilter.all),
          _buildFilterButton("Available", SellFilter.available),
          _buildFilterButton("Sold", SellFilter.sold),
        ],
      ),
    );
  }

  Widget _buildFilterButton(String label, SellFilter filter) {
    final isSelected = selectedFilter == filter;
    return GestureDetector(
      onTap: () => onFilterSelect(filter),
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: isSelected ? DisColors.primary : DisColors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: DisColors.primary,
            width: 1.5,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? DisColors.black : DisColors.primary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildImageGrid(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 4.0,
          mainAxisSpacing: 4.0,
          mainAxisExtent: MediaQuery.of(context).size.height * 0.25,
        ),
        itemCount: sellImagePaths.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => _showImageDialog(context, sellImagePaths[index]),
            child: Container(
              color: Colors.grey,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.file(
                  File(sellImagePaths[index]),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _showImageDialog(BuildContext context, String imagePath) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            width: double.infinity,
            child: Image.file(
              File(imagePath),
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    );
  }
}
