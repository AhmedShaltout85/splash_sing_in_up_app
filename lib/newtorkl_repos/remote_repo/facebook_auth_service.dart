// import 'dart:async';
// import 'dart:convert' show json;

// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:http/http.dart' as http;

// /// A reusable service class for handling Google Sign-In authentication
// /// and authorization flows.
// class GoogleAuthService {
//   static GoogleAuthService instance = GoogleAuthService();

//   /// Constructor
//   GoogleAuthService({
//     this.clientId,
//     this.serverClientId,
//     List<String> scopes = const [],
//   }) : _scopes = scopes;

//   final String? clientId;
//   final String? serverClientId;
//   final List<String> _scopes;

//   GoogleSignInAccount? _currentUser;
//   bool _isAuthorized = false;
//   StreamSubscription<GoogleSignInAuthenticationEvent>? _authSubscription;

//   /// Stream controller for authentication state changes
//   final StreamController<GoogleAuthState> _stateController =
//       StreamController<GoogleAuthState>.broadcast();

//   /// Public stream to listen to authentication state changes
//   Stream<GoogleAuthState> get authStateChanges => _stateController.stream;

//   /// Get the current user
//   GoogleSignInAccount? get currentUser => _currentUser;

//   /// Check if user is authorized with required scopes
//   bool get isAuthorized => _isAuthorized;

//   /// Initialize the Google Sign-In service
//   Future<void> initialize() async {
//     final GoogleSignIn signIn = GoogleSignIn.instance;

//     await signIn.initialize(clientId: clientId, serverClientId: serverClientId);

//     _authSubscription = signIn.authenticationEvents.listen(
//       _handleAuthenticationEvent,
//       onError: _handleAuthenticationError,
//     );

//     // Attempt silent sign-in
//     await signIn.attemptLightweightAuthentication();
//   }

//   /// Handle authentication events (sign in/out)
//   Future<void> _handleAuthenticationEvent(
//     GoogleSignInAuthenticationEvent event,
//   ) async {
//     final GoogleSignInAccount? user = switch (event) {
//       GoogleSignInAuthenticationEventSignIn() => event.user,
//       GoogleSignInAuthenticationEventSignOut() => null,
//     };

//     // Check for existing authorization
//     final GoogleSignInClientAuthorization? authorization = await user
//         ?.authorizationClient
//         .authorizationForScopes(_scopes);

//     _currentUser = user;
//     _isAuthorized = authorization != null;

//     _emitState(
//       user: user,
//       isAuthorized: authorization != null,
//       errorMessage: '',
//     );
//   }

//   /// Handle authentication errors
//   Future<void> _handleAuthenticationError(Object e) async {
//     _currentUser = null;
//     _isAuthorized = false;

//     final String errorMessage = e is GoogleSignInException
//         ? _errorMessageFromSignInException(e)
//         : 'Unknown error: $e';

//     _emitState(user: null, isAuthorized: false, errorMessage: errorMessage);
//   }

//   /// Sign in explicitly (shows UI)
//   Future<void> signIn() async {
//     try {
//       if (GoogleSignIn.instance.supportsAuthenticate()) {
//         await GoogleSignIn.instance.authenticate();
//       } else {
//         throw Exception('Platform does not support authentication');
//       }
//     } on GoogleSignInException catch (e) {
//       _emitState(
//         user: _currentUser,
//         isAuthorized: _isAuthorized,
//         errorMessage: _errorMessageFromSignInException(e),
//       );
//       rethrow;
//     }
//   }

//   /// Sign out the current user
//   Future<void> signOut() async {
//     await GoogleSignIn.instance.signOut();
//   }

//   /// Disconnect the current user (revokes access)
//   Future<void> disconnect() async {
//     await GoogleSignIn.instance.disconnect();
//   }

//   /// Request authorization for specific scopes
//   Future<GoogleSignInClientAuthorization> authorizeScopes(
//     List<String>? scopes,
//   ) async {
//     if (_currentUser == null) {
//       throw Exception('No user signed in');
//     }

//     final scopesToAuthorize = scopes ?? _scopes;

//     try {
//       final authorization = await _currentUser!.authorizationClient
//           .authorizeScopes(scopesToAuthorize);

//       _isAuthorized = true;
//       _emitState(user: _currentUser, isAuthorized: true, errorMessage: '');

//       return authorization;
//     } on GoogleSignInException catch (e) {
//       final errorMessage = _errorMessageFromSignInException(e);
//       _emitState(
//         user: _currentUser,
//         isAuthorized: _isAuthorized,
//         errorMessage: errorMessage,
//       );
//       rethrow;
//     }
//   }

//   /// Request server authorization code
//   Future<String?> getServerAuthCode(List<String>? scopes) async {
//     if (_currentUser == null) {
//       throw Exception('No user signed in');
//     }

//     final scopesToAuthorize = scopes ?? _scopes;

//     try {
//       final serverAuth = await _currentUser!.authorizationClient
//           .authorizeServer(scopesToAuthorize);
//       return serverAuth?.serverAuthCode;
//     } on GoogleSignInException catch (e) {
//       _emitState(
//         user: _currentUser,
//         isAuthorized: _isAuthorized,
//         errorMessage: _errorMessageFromSignInException(e),
//       );
//       rethrow;
//     }
//   }

//   /// Get authorization headers for API requests
//   Future<Map<String, String>?> getAuthHeaders(List<String>? scopes) async {
//     if (_currentUser == null) {
//       return null;
//     }

//     final scopesToUse = scopes ?? _scopes;
//     return await _currentUser!.authorizationClient.authorizationHeaders(
//       scopesToUse,
//     );
//   }

//   /// Make an authenticated API request
//   Future<http.Response> makeAuthenticatedRequest({
//     required String url,
//     List<String>? scopes,
//     Map<String, String>? additionalHeaders,
//   }) async {
//     final headers = await getAuthHeaders(scopes);

//     if (headers == null) {
//       throw Exception('Failed to get authorization headers');
//     }

//     if (additionalHeaders != null) {
//       headers.addAll(additionalHeaders);
//     }

//     return await http.get(Uri.parse(url), headers: headers);
//   }

//   /// Example: Get contacts from Google People API
//   Future<List<String>> getContacts() async {
//     if (_currentUser == null) {
//       throw Exception('No user signed in');
//     }

//     final response = await makeAuthenticatedRequest(
//       url:
//           '513006185811-umqfk692e0enhtv52kjh1v1eskih8p1k.apps.googleusercontent.com',
//       scopes: ['https://www.googleapis.com/auth/contacts.readonly'],
//     );

//     if (response.statusCode == 401 || response.statusCode == 403) {
//       _isAuthorized = false;
//       _emitState(
//         user: _currentUser,
//         isAuthorized: false,
//         errorMessage:
//             'API gave a ${response.statusCode} response. '
//             'Please re-authorize access.',
//       );
//       throw Exception('Authorization required');
//     }

//     if (response.statusCode != 200) {
//       throw Exception('API error: ${response.statusCode}');
//     }

//     final data = json.decode(response.body) as Map<String, dynamic>;
//     return _extractContactNames(data);
//   }

//   /// Extract contact names from API response
//   List<String> _extractContactNames(Map<String, dynamic> data) {
//     final List<dynamic>? connections = data['connections'] as List<dynamic>?;
//     if (connections == null) return [];

//     final names = <String>[];
//     for (final connection in connections) {
//       final contact = connection as Map<String, dynamic>;
//       final namesList = contact['names'] as List<dynamic>?;

//       if (namesList != null && namesList.isNotEmpty) {
//         final name = namesList.first as Map<String, dynamic>;
//         final displayName = name['displayName'] as String?;
//         if (displayName != null) {
//           names.add(displayName);
//         }
//       }
//     }

//     return names;
//   }

//   /// Emit authentication state
//   void _emitState({
//     required GoogleSignInAccount? user,
//     required bool isAuthorized,
//     required String errorMessage,
//   }) {
//     if (!_stateController.isClosed) {
//       _stateController.add(
//         GoogleAuthState(
//           user: user,
//           isAuthorized: isAuthorized,
//           errorMessage: errorMessage,
//         ),
//       );
//     }
//   }

//   /// Convert GoogleSignInException to user-friendly message
//   String _errorMessageFromSignInException(GoogleSignInException e) {
//     return switch (e.code) {
//       GoogleSignInExceptionCode.canceled => 'Sign in canceled',
//       _ => 'GoogleSignInException ${e.code}: ${e.description}',
//     };
//   }

//   /// Dispose of resources
//   void dispose() {
//     _authSubscription?.cancel();
//     _stateController.close();
//   }
// }

// /// Represents the current authentication state
// class GoogleAuthState {
//   const GoogleAuthState({
//     required this.user,
//     required this.isAuthorized,
//     required this.errorMessage,
//   });

//   final GoogleSignInAccount? user;
//   final bool isAuthorized;
//   final String errorMessage;

//   bool get isSignedIn => user != null;
//   bool get hasError => errorMessage.isNotEmpty;
// }

// // use example:

// // // Initialize the service
// // final authService = GoogleAuthService(
// //   clientId: '513006185811-umqfk692e0enhtv52kjh1v1eskih8p1k.apps.googleusercontent.com',
// //   scopes: ['https://www.googleapis.com/auth/contacts.readonly'],
// // );

// // await authService.initialize();

// // // Listen to auth state changes
// // authService.authStateChanges.listen((state) {
// //   if (state.isSignedIn) {
// //     print('User: ${state.user?.displayName}');
// //     print('Authorized: ${state.isAuthorized}');
// //   }
// //   if (state.hasError) {
// //     print('Error: ${state.errorMessage}');
// //   }
// // });

// // // Sign in
// // await authService.signIn();

// // // Request additional scopes
// // await authService.authorizeScopes(['scope1', 'scope2']);

// // // Get contacts
// // final contacts = await authService.getContacts();

// // // Clean up
// // authService.dispose();
import 'dart:async';
import 'dart:convert' show json;

import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

/// A reusable service class for handling Google Sign-In authentication
/// and authorization flows.
class GoogleAuthService {
  static GoogleAuthService instance = GoogleAuthService();

  /// Constructor
  GoogleAuthService({
    this.clientId,
    this.serverClientId,
    List<String> scopes = const [],
  }) : _scopes = scopes;

  final String? clientId;
  final String? serverClientId;
  final List<String> _scopes;

  GoogleSignInAccount? _currentUser;
  bool _isAuthorized = false;
  StreamSubscription<GoogleSignInAuthenticationEvent>? _authSubscription;

  /// Stream controller for authentication state changes
  final StreamController<GoogleAuthState> _stateController =
      StreamController<GoogleAuthState>.broadcast();

  /// Public stream to listen to authentication state changes
  Stream<GoogleAuthState> get authStateChanges => _stateController.stream;

  /// Get the current user
  GoogleSignInAccount? get currentUser => _currentUser;

  /// Check if user is authorized with required scopes
  bool get isAuthorized => _isAuthorized;

  /// Initialize the Google Sign-In service
  Future<void> initialize() async {
    final GoogleSignIn signIn = GoogleSignIn.instance;

    await signIn.initialize(clientId: clientId, serverClientId: serverClientId);

    _authSubscription = signIn.authenticationEvents.listen(
      _handleAuthenticationEvent,
      onError: _handleAuthenticationError,
    );

    // Attempt silent sign-in
    await signIn.attemptLightweightAuthentication();
  }

  /// Handle authentication events (sign in/out)
  Future<void> _handleAuthenticationEvent(
    GoogleSignInAuthenticationEvent event,
  ) async {
    final GoogleSignInAccount? user = switch (event) {
      GoogleSignInAuthenticationEventSignIn() => event.user,
      GoogleSignInAuthenticationEventSignOut() => null,
    };

    // FIX: Only check authorization if user exists and scopes are provided
    GoogleSignInClientAuthorization? authorization;
    if (user != null && _scopes.isNotEmpty) {
      try {
        authorization = await user.authorizationClient.authorizationForScopes(
          _scopes,
        );
      } catch (e) {
        // If authorization check fails, just continue without it
        authorization = null;
      }
    }

    _currentUser = user;
    _isAuthorized = authorization != null;

    _emitState(
      user: user,
      isAuthorized: authorization != null,
      errorMessage: '',
    );
  }

  /// Handle authentication errors
  Future<void> _handleAuthenticationError(Object e) async {
    _currentUser = null;
    _isAuthorized = false;

    final String errorMessage = e is GoogleSignInException
        ? _errorMessageFromSignInException(e)
        : 'Unknown error: $e';

    _emitState(user: null, isAuthorized: false, errorMessage: errorMessage);
  }

  /// Sign in explicitly (shows UI)
  Future<void> signIn() async {
    try {
      if (GoogleSignIn.instance.supportsAuthenticate()) {
        await GoogleSignIn.instance.authenticate();
      } else {
        throw Exception('Platform does not support authentication');
      }
    } on GoogleSignInException catch (e) {
      _emitState(
        user: _currentUser,
        isAuthorized: _isAuthorized,
        errorMessage: _errorMessageFromSignInException(e),
      );
      rethrow;
    }
  }

  /// Sign out the current user
  Future<void> signOut() async {
    await GoogleSignIn.instance.signOut();
  }

  /// Disconnect the current user (revokes access)
  Future<void> disconnect() async {
    await GoogleSignIn.instance.disconnect();
  }

  /// Request authorization for specific scopes
  Future<GoogleSignInClientAuthorization> authorizeScopes(
    List<String>? scopes,
  ) async {
    if (_currentUser == null) {
      throw Exception('No user signed in');
    }

    final scopesToAuthorize = scopes ?? _scopes;

    // FIX: Ensure scopes are not empty
    if (scopesToAuthorize.isEmpty) {
      throw Exception('No scopes provided for authorization');
    }

    try {
      final authorization = await _currentUser!.authorizationClient
          .authorizeScopes(scopesToAuthorize);

      _isAuthorized = true;
      _emitState(user: _currentUser, isAuthorized: true, errorMessage: '');

      return authorization;
    } on GoogleSignInException catch (e) {
      final errorMessage = _errorMessageFromSignInException(e);
      _emitState(
        user: _currentUser,
        isAuthorized: _isAuthorized,
        errorMessage: errorMessage,
      );
      rethrow;
    }
  }

  /// Request server authorization code
  Future<String?> getServerAuthCode(List<String>? scopes) async {
    if (_currentUser == null) {
      throw Exception('No user signed in');
    }

    final scopesToAuthorize = scopes ?? _scopes;

    // FIX: Ensure scopes are not empty
    if (scopesToAuthorize.isEmpty) {
      throw Exception('No scopes provided for server authorization');
    }

    try {
      final serverAuth = await _currentUser!.authorizationClient
          .authorizeServer(scopesToAuthorize);
      return serverAuth?.serverAuthCode;
    } on GoogleSignInException catch (e) {
      _emitState(
        user: _currentUser,
        isAuthorized: _isAuthorized,
        errorMessage: _errorMessageFromSignInException(e),
      );
      rethrow;
    }
  }

  /// Get authorization headers for API requests
  Future<Map<String, String>?> getAuthHeaders(List<String>? scopes) async {
    if (_currentUser == null) {
      return null;
    }

    final scopesToUse = scopes ?? _scopes;

    // FIX: Ensure scopes are not empty
    if (scopesToUse.isEmpty) {
      throw Exception('No scopes provided for authorization headers');
    }

    return await _currentUser!.authorizationClient.authorizationHeaders(
      scopesToUse,
    );
  }

  /// Make an authenticated API request
  Future<http.Response> makeAuthenticatedRequest({
    required String url,
    List<String>? scopes,
    Map<String, String>? additionalHeaders,
  }) async {
    final headers = await getAuthHeaders(scopes);

    if (headers == null) {
      throw Exception('Failed to get authorization headers');
    }

    if (additionalHeaders != null) {
      headers.addAll(additionalHeaders);
    }

    return await http.get(Uri.parse(url), headers: headers);
  }

  /// Example: Get contacts from Google People API
  Future<List<String>> getContacts() async {
    if (_currentUser == null) {
      throw Exception('No user signed in');
    }

    // FIX: Ensure we have authorization before making the request
    if (!_isAuthorized) {
      // Request authorization if not already authorized
      await authorizeScopes([
        'https://www.googleapis.com/auth/contacts.readonly',
      ]);
    }

    // FIX: Correct API URL for Google People API
    final response = await makeAuthenticatedRequest(
      url:
          'https://people.googleapis.com/v1/people/me/connections'
          '?requestMask.includeField=person.names',
      scopes: ['https://www.googleapis.com/auth/contacts.readonly'],
    );

    if (response.statusCode == 401 || response.statusCode == 403) {
      _isAuthorized = false;
      _emitState(
        user: _currentUser,
        isAuthorized: false,
        errorMessage:
            'API gave a ${response.statusCode} response. '
            'Please re-authorize access.',
      );
      throw Exception('Authorization required');
    }

    if (response.statusCode != 200) {
      throw Exception('API error: ${response.statusCode}');
    }

    final data = json.decode(response.body) as Map<String, dynamic>;
    return _extractContactNames(data);
  }

  /// Extract contact names from API response
  List<String> _extractContactNames(Map<String, dynamic> data) {
    final List<dynamic>? connections = data['connections'] as List<dynamic>?;
    if (connections == null) return [];

    final names = <String>[];
    for (final connection in connections) {
      final contact = connection as Map<String, dynamic>;
      final namesList = contact['names'] as List<dynamic>?;

      if (namesList != null && namesList.isNotEmpty) {
        final name = namesList.first as Map<String, dynamic>;
        final displayName = name['displayName'] as String?;
        if (displayName != null) {
          names.add(displayName);
        }
      }
    }

    return names;
  }

  /// Emit authentication state
  void _emitState({
    required GoogleSignInAccount? user,
    required bool isAuthorized,
    required String errorMessage,
  }) {
    if (!_stateController.isClosed) {
      _stateController.add(
        GoogleAuthState(
          user: user,
          isAuthorized: isAuthorized,
          errorMessage: errorMessage,
        ),
      );
    }
  }

  /// Convert GoogleSignInException to user-friendly message
  String _errorMessageFromSignInException(GoogleSignInException e) {
    return switch (e.code) {
      GoogleSignInExceptionCode.canceled => 'Sign in canceled',
      _ => 'GoogleSignInException ${e.code}: ${e.description}',
    };
  }

  /// Dispose of resources
  void dispose() {
    _authSubscription?.cancel();
    _stateController.close();
  }
}

/// Represents the current authentication state
class GoogleAuthState {
  const GoogleAuthState({
    required this.user,
    required this.isAuthorized,
    required this.errorMessage,
  });

  final GoogleSignInAccount? user;
  final bool isAuthorized;
  final String errorMessage;

  bool get isSignedIn => user != null;
  bool get hasError => errorMessage.isNotEmpty;
}


// USAGE EXAMPLE - COMPLETE FLOW:

// // 1. Initialize the service
// final authService = GoogleAuthService(
//   // For Android: serverClientId is REQUIRED (use your Web Client ID)
//   serverClientId: '513006185811-umqfk692e0enhtv52kjh1v1eskih8p1k.apps.googleusercontent.com',
//   // For iOS: clientId may be needed (use your iOS Client ID)
//   clientId: 'YOUR_IOS_CLIENT_ID.apps.googleusercontent.com', // Optional on Android
//   // IMPORTANT: Always provide scopes when creating the service
//   scopes: ['https://www.googleapis.com/auth/contacts.readonly'],
// );

// await authService.initialize();

// // 2. Listen to auth state changes
// authService.authStateChanges.listen((state) {
//   if (state.isSignedIn) {
//     print('User: ${state.user?.displayName}');
//     print('Email: ${state.user?.email}');
//     print('Authorized: ${state.isAuthorized}');
//   }
//   if (state.hasError) {
//     print('Error: ${state.errorMessage}');
//   }
// });

// // 3. Sign in
// await authService.signIn();

// // 4. Request authorization for scopes (REQUIRED!)
// // This step is CRITICAL - it must be done after sign in and before API calls
// await authService.authorizeScopes([
//   'https://www.googleapis.com/auth/contacts.readonly'
// ]);

// // 5. Now you can get contacts (getContacts will auto-request authorization if needed)
// try {
//   final contacts = await authService.getContacts();
//   print('Contacts: $contacts');
// } catch (e) {
//   print('Error getting contacts: $e');
// }

// // 6. Clean up when done
// authService.dispose();


// ALTERNATIVE USAGE - Let getContacts handle authorization:

// final authService = GoogleAuthService(
//   serverClientId: '513006185811-umqfk692e0enhtv52kjh1v1eskih8p1k.apps.googleusercontent.com',
//   scopes: ['https://www.googleapis.com/auth/contacts.readonly'],
// );

// await authService.initialize();
// await authService.signIn();

// // getContacts() will automatically request authorization if needed
// final contacts = await authService.getContacts();
// print('Contacts: $contacts');