import 'package:flutter_bloc/flutter_bloc.dart';
import '../../presentation.dart';

class NewsScrollBloc extends Bloc<NewsScrollEvent, NewsScrollState> {
  NewsScrollBloc() : super(const NewsScrollState.initial()) {
    on<ScrollUp>((event, emit) => emit(const NewsScrollState.scrolled()));
    on<ScrollDown>((event, emit) => emit(const NewsScrollState.initial()));
    on<FixScrollState>((event, emit) => emit(const NewsScrollState.fixed()));
  }
}
