import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

abstract class PhotoEvent extends Equatable {
  const PhotoEvent();

  @override
  List<Object?> get props => [];
}

class AddSellPhotoEvent extends PhotoEvent {
  final String name;
  final double basePrice;
  final double sellPrice;
  final String description;
  final XFile file;

  const AddSellPhotoEvent({
    required this.name,
    required this.basePrice,
    required this.sellPrice,
    required this.description,
    required this.file,
  });

  @override
  List<Object> get props => [name, basePrice, sellPrice, description, file];
}

class AddPostPhotoEvent extends PhotoEvent {
  final String name;
  final String description;
  final XFile file;

  const AddPostPhotoEvent({
    required this.name,
    required this.description,
    required this.file,
  });

  @override
  List<Object> get props => [name, description, file];
}

class GetPhotoEvent extends PhotoEvent {
  final String id;

  const GetPhotoEvent({
    required this.id,
  });

  @override
  List<Object> get props => [id];
}

class ListPhotoEvent extends PhotoEvent {
  final int? page;
  final int? size;

  const ListPhotoEvent({
    this.page,
    this.size,
  });

  @override
  List<Object?> get props => [page, size];
}

class UpdateSellPhotoEvent extends PhotoEvent {
  final String id;
  final String name;
  final double basePrice;
  final double sellPrice;
  final String description;

  const UpdateSellPhotoEvent({
    required this.id,
    required this.name,
    required this.basePrice,
    required this.sellPrice,
    required this.description,
  });

  @override
  List<Object> get props => [id, name, basePrice, sellPrice, description];
}

class UpdatePostPhotoEvent extends PhotoEvent {
  final String id;
  final String name;
  final String description;

  const UpdatePostPhotoEvent({
    required this.id,
    required this.name,
    required this.description,
  });

  @override
  List<Object> get props => [id, name, description];
}

class LikePhotoEvent extends PhotoEvent {
  final String id;
  final bool liked;

  const LikePhotoEvent({
    required this.id,
    required this.liked,
  });

  @override
  List<Object> get props => [id, liked];
}

class SamplePhotoEvent extends PhotoEvent {
  const SamplePhotoEvent();
}

class CollectionPhotoEvent extends PhotoEvent {
  final String buyerId;
  final int? page;
  final int? size;

  const CollectionPhotoEvent({
    required this.buyerId,
    this.page,
    this.size,
  });

  @override
  List<Object?> get props => [buyerId, page, size];
}

class FindmePhotoEvent extends PhotoEvent {
  final int? page;
  final int? size;

  const FindmePhotoEvent({
    this.page,
    this.size,
  });

  @override
  List<Object?> get props => [page, size];
}

class AddToFavoritesEvent extends PhotoEvent {
  final String imageUrl;

  const AddToFavoritesEvent({required this.imageUrl});

  @override
  List<Object> get props => [imageUrl];
}
