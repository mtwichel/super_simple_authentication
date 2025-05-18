# Super Simple Authentication

A really quite simple authentication system for Dart meant to be easily self-host-able and contain all the authentication methods you would need. Works with [postgres](https://www.postgresql.org) databases.


## Features

- [x] Create an account with email/password
- [x] Login with email/password
- [x] Logout
- [ ] Sign in with Google
- [ ] Sign in with Apple
- [ ] Sign in with email magic link
- [ ] Sign in with email OTP
- [ ] Sign in with phone number OTP
- [ ] Two factor authentication


## Packages
### [Super Simple Authentication Server](./super_simple_authentication_server)

The backend server to control authentication. Written in Dart and works with [postgres](https://www.postgresql.org).


### [Super Simple Authentication Client](./super_simple_authentication_client)

A Dart client to interact with the Super Simple Authentication Server.


### [Super Simple Authentication Flutter](./super_simple_authentication_flutter)

A Flutter client to interact with the Super Simple Authentication Server. Auto refreshes tokens and stores them in [secure storage](https://pub.dev/packages/flutter_secure_storage).







