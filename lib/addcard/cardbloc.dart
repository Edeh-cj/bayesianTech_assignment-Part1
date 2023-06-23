import 'package:bayesiantech_assignment_part1/classes/comment.dart';
import 'package:bloc/bloc.dart';

class CardBloc extends Bloc<CardEvent, List<MyComment>> {
  CardBloc() : super([MyComment('This is the first comment')]) {
    on<AddCardEvent>((event, emit) {
      state.add(event.addedcomment);
      state.where((element) => element.id == event.callingcomment.id).first.toggle = 'l';
      emit(state);
    });
  }
}

abstract class CardEvent {}

class AddCardEvent implements CardEvent {
  final MyComment callingcomment;
  final MyComment addedcomment;

  AddCardEvent({ required this.callingcomment, required this.addedcomment});
  
}
