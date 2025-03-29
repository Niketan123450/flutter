abstract class NavbarEvent {}

class OnNavbarTapEvent extends NavbarEvent {
  final int newIndex;
  OnNavbarTapEvent({required this.newIndex});
}
