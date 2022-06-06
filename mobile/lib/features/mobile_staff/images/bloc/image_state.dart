import 'package:royal_cinema/features/mobile_staff/images/image.dart';
import 'package:royal_cinema/features/mobile_staff/movie/index.dart';

abstract class ImageState {}

class ImageLoading extends ImageState {}

class ImageLoaded extends ImageState {
  ImageFile image;

  ImageLoaded(this.image);
}

class ImageLoadingFailed extends MovieState {
  final String msg;
  ImageLoadingFailed(this.msg);
}

// class UpdateSuccessful extends MovieState {}
