import 'package:sec_2/images/model/image.dart';
import 'package:sec_2/movie/index.dart';

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
