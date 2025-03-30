abstract class NavbarEvent {}

class NavbarTapEvent extends NavbarEvent {
  final int newIndex;
  NavbarTapEvent({required this.newIndex});
}
