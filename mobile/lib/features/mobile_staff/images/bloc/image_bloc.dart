// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../image.dart';
// class ImageBloc extends Bloc<ImageEvent, ImageState> {
//   final ImageRepository imageRepository;

//   ImageBloc(this.imageRepository) : super(ImageLoading()) {
//     on<LoadImage>(_onLoadImage);
//     // on<UpdateMovie>(_onUpdateMovie);
//   }

//   void _onLoadImage(LoadImage event, Emitter emit) async {
//     emit(ImageLoading());
//     // await Future.delayed(const Duration(seconds: 3));
//     final image = await imageRepository.getImage(event.imageUrl);
//     if (image.hasError) {
//       emit(ImageLoadingFailed(image.error!));
//     } else {
//       emit(ImageLoaded(image.val!));
//     }
//   }

//   // void _onUpdateMovie(UpdateMovie event, Emitter emit) async {
//   //   // await movieRepository.editMovie(event.movie.id, event.movie);
//   //   emit(UpdateSuccessful());
//   // }
// }
