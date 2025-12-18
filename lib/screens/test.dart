import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class FacebookAuthScreen extends StatefulWidget {
  const FacebookAuthScreen({super.key});

  @override
  _FacebookAuthScreenState createState() => _FacebookAuthScreenState();
}

class _FacebookAuthScreenState extends State<FacebookAuthScreen> {
  Map<String, dynamic>? _userData;
  AccessToken? _accessToken;
  bool _isLoggedIn = false;
  bool _isChecking = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkLoginStatus();
    });
  }

  Future<void> _checkLoginStatus() async {
    if (_isChecking) return;

    setState(() {
      _isChecking = true;
    });

    try {
      print('🔄 Checking Facebook login status...');

      // Try to initialize first
      await _initializeFacebookSDK();

      // Wait a bit for initialization
      await Future.delayed(Duration(milliseconds: 500));

      // Check for access token
      final accessToken = await FacebookAuth.instance.accessToken;
      print('📱 Access Token found: ${accessToken != null}');

      if (accessToken != null) {
        // print('✅ Token valid until: ${accessToken.expires}');

        // Get user data
        final userData = await FacebookAuth.instance.getUserData(
          fields: "email,name,picture",
        );

        print('✅ User data retrieved: ${userData['name'] ?? 'No name'}');

        setState(() {
          _userData = userData;
          _accessToken = accessToken;
          _isLoggedIn = true;
        });
      } else {
        print('ℹ️ No active Facebook session');
        setState(() {
          _isLoggedIn = false;
        });
      }
    } catch (e, stackTrace) {
      print('❌ Error in _checkLoginStatus: $e');
      print('Stack trace: $stackTrace');

      // Handle specific error types
      if (e.toString().contains('MissingPluginException')) {
        print('🚨 CRITICAL: Facebook plugin not registered!');
        print('🔧 Please check:');
        print('   1. Did you run "flutter clean" and "flutter pub get"?');
        print('   2. For iOS: Did you add FBSDKCoreKit to Podfile?');
        print('   3. For Android: Did you add facebook-login dependency?');
      }
    } finally {
      setState(() {
        _isChecking = false;
      });
    }
  }

  Future<void> _initializeFacebookSDK() async {
    print('🔧 Initializing Facebook SDK...');

    // Check if we're on web
    final isWeb = FacebookAuth.i.isWebSdkInitialized;
    print('🌐 Is web platform: $isWeb');

    if (isWeb) {
      try {
        await FacebookAuth.i.webAndDesktopInitialize(
          appId: "1211526794262745",
          cookie: true,
          xfbml: true,
          version: "v19.0",
        );
        print('✅ Web SDK initialized');
      } catch (e) {
        print('⚠️ Web SDK init error: $e');
      }
    }
  }

  Future<void> _login() async {
    try {
      print('🚀 Starting Facebook login...');

      final LoginResult result = await FacebookAuth.instance.login(
        permissions: ['email', 'public_profile'],
      );

      print('📊 Login result: ${result.status}');
      print('📝 Message: ${result.message}');

      if (result.status == LoginStatus.success) {
        print('🎉 Login successful!');

        final userData = await FacebookAuth.instance.getUserData(
          fields: "email,name,picture",
        );

        print('👤 User: ${userData['name']}');

        setState(() {
          _userData = userData;
          _accessToken = result.accessToken;
          _isLoggedIn = true;
        });
      } else {
        print('❌ Login failed: ${result.message}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login failed: ${result.message}')),
        );
      }
    } catch (e, stackTrace) {
      print('💥 Login error: $e');
      print('Stack trace: $stackTrace');

      String errorMessage = 'Login error occurred';
      if (e.toString().contains('MissingPluginException')) {
        errorMessage =
            'Facebook plugin not properly installed. Please restart the app.';
      }

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(errorMessage)));
    }
  }

  Future<void> _logout() async {
    try {
      print('👋 Logging out...');
      await FacebookAuth.instance.logOut();

      setState(() {
        _userData = null;
        _accessToken = null;
        _isLoggedIn = false;
      });

      print('✅ Logged out successfully');
    } catch (e) {
      print('❌ Logout error: $e');
    }
  }

  Future<void> _debugInfo() async {
    try {
      final token = await FacebookAuth.instance.accessToken;
      final isWeb = FacebookAuth.i.isWebSdkInitialized;

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Debug Info'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Is Logged In: $_isLoggedIn'),
              Text('Token exists: ${token != null}'),
              // Text('Token expires: ${token?.expires ?? "N/A"}'),
              Text('Is Web: $isWeb'),
              Text('App ID: 1211526794262745'),
              SizedBox(height: 10),
              Text('User: ${_userData?['name'] ?? "None"}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Close'),
            ),
          ],
        ),
      );
    } catch (e) {
      print('Debug error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Facebook Auth Demo'),
        actions: [
          IconButton(icon: Icon(Icons.bug_report), onPressed: _debugInfo),
        ],
      ),
      body: _isChecking
          ? Center(child: CircularProgressIndicator())
          : Center(child: _isLoggedIn ? _buildProfile() : _buildLoginButton()),
      floatingActionButton: FloatingActionButton(
        onPressed: _checkLoginStatus,
        mini: true,
        child: Icon(Icons.refresh),
      ),
    );
  }

  Widget _buildLoginButton() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton.icon(
          icon: Icon(Icons.facebook, color: Colors.white),
          label: Text(
            'Login with Facebook',
            style: TextStyle(color: Colors.white),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF1877F2),
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          ),
          onPressed: _login,
        ),
        SizedBox(height: 20),
        Text('You are not logged in'),
        SizedBox(height: 10),
        TextButton(onPressed: _checkLoginStatus, child: Text('Check Status')),
      ],
    );
  }

  Widget _buildProfile() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_userData?['picture']?['data']?['url'] != null)
              CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage(
                  _userData!['picture']['data']['url'],
                ),
              ),
            SizedBox(height: 20),
            Text(
              _userData?['name'] ?? 'No name',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Text(
              _userData?['email'] ?? 'No email',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            SizedBox(height: 20),
            Card(
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Token Info:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    SizedBox(height: 8),
                    // Text('User ID: ${_accessToken?.userId ?? "N/A"}'),
                    // Text('Expires: ${_accessToken?.expires ?? "N/A"}'),
                    // Text('Permissions: ${_accessToken?.permissions?.join(", ") ?? "N/A"}'),
                  ],
                ),
              ),
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _logout,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  ),
                  child: Text('Logout'),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () async {
                    final token = await FacebookAuth.instance.accessToken;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Token: ${token?.tokenString ?? "No token"}',
                        ),
                        duration: Duration(seconds: 3),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  ),
                  child: Text('Show Token'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
