import 'package:dis_app/models/photo_model.dart';
import 'package:dis_app/pages/account/account_screen.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import '../../../utils/constants/colors.dart';

class SellSection extends StatelessWidget {
  final List<SellPhoto> sellPhotos;
  final SellFilter selectedFilter;
  final ValueChanged<SellFilter> onFilterSelect;

  const SellSection({
    Key? key,
    required this.sellPhotos,
    required this.selectedFilter,
    required this.onFilterSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildFilterRow(),
        _buildImageGrid(context, _filterPhotos(sellPhotos, selectedFilter)),
      ],
    );
  }

  List<SellPhoto> _filterPhotos(List<SellPhoto> photos, SellFilter filter) {
    if (filter == SellFilter.all) {
      return photos;
    } else if (filter == SellFilter.available) {
      return photos.where((photo) => photo.status == 'available').toList();
    } else if (filter == SellFilter.sold) {
      return photos.where((photo) => photo.status == 'sold').toList();
    }
    return photos;
  }

  Widget _buildFilterRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
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

  Widget _buildImageGrid(BuildContext context, List<SellPhoto> photos) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 4.0,
          mainAxisSpacing: 4.0,
          mainAxisExtent: MediaQuery.of(context).size.height * 0.25,
        ),
        itemCount: photos.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => _showImageDialog(context, photos[index].url),
            child: Container(
              color: Colors.grey,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  photos[index]
                      .url, // Use Image.network to load the image from URL
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    } else {
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  (loadingProgress.expectedTotalBytes ?? 1)
                              : null,
                        ),
                      );
                    }
                  },
                  errorBuilder: (BuildContext context, Object error,
                      StackTrace? stackTrace) {
                    return const Icon(Icons
                        .error); // Display an error icon if the image fails to load
                  },
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
            child: Image.network(
              imagePath, // Use Image.network to display the image in the dialog
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    );
  }
}
