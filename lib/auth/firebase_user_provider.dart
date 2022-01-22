import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class BuddiesFirebaseUser {
  BuddiesFirebaseUser(this.user);
  User user;
  bool get loggedIn => user != null;
}

BuddiesFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<BuddiesFirebaseUser> buddiesFirebaseUserStream() => FirebaseAuth.instance
    .authStateChanges()
    .debounce((user) => user == null && !loggedIn
        ? TimerStream(true, const Duration(seconds: 1))
        : Stream.value(user))
    .map<BuddiesFirebaseUser>(
        (user) => currentUser = BuddiesFirebaseUser(user));
