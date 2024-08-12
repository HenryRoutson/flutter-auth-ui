import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';

import 'constants.dart';

class SignUp extends StatelessWidget {
  const SignUp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    void navigateHome(AuthResponse response) {
      Navigator.of(context).pushReplacementNamed('/home');
    }

    var darkModeThemeData = ThemeData.dark().copyWith(
      colorScheme: ColorScheme.dark(
        primary: Color.fromARGB(248, 183, 183, 183),
      ),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: Colors.blueGrey[300],
        selectionColor: Colors.blueGrey.withOpacity(0.3),
        selectionHandleColor: Colors.blueGrey[300],
      ),
      inputDecorationTheme: InputDecorationTheme(
        fillColor: Colors.grey[800],
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        labelStyle: TextStyle(color: Color.fromARGB(179, 255, 255, 255)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Color.fromARGB(255, 155, 155, 155),
          foregroundColor: Color.fromARGB(255, 255, 255, 255),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );

    return Scaffold(
      appBar: appBar('Sign In'),
      body: ListView(
        padding: const EdgeInsets.all(24.0),
        children: [
          SupaEmailAuth(
            redirectTo: kIsWeb ? null : 'io.supabase.flutter://',
            onSignInComplete: navigateHome,
            onSignUpComplete: navigateHome,
            metadataFields: [
              MetaDataField(
                prefixIcon: const Icon(Icons.person),
                label: 'Username',
                key: 'username',
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return 'Please enter something';
                  }
                  return null;
                },
              ),
            ],
          ),

          const Divider(),
          optionText,
          spacer,

          // Dark theme example
          Card(
              elevation: 10,
              color: const Color.fromARGB(255, 24, 24, 24),
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Theme(
                  data: darkModeThemeData,
                  child: SupaEmailAuth(
                    redirectTo: kIsWeb ? null : 'io.supabase.flutter://',
                    onSignInComplete: navigateHome,
                    onSignUpComplete: navigateHome,
                    prefixIconsEmail: null,
                    prefixIconsPassword: null,
                    localization: const SupaEmailAuthLocalization(
                        enterEmail: "email",
                        enterPassword: "password",
                        dontHaveAccount: "sign up",
                        forgotPassword: "forgot password"),
                  ),
                ),
              )),

          const Divider(),
          optionText,
          spacer,
          ElevatedButton.icon(
            icon: const Icon(Icons.email),
            onPressed: () {
              Navigator.popAndPushNamed(context, '/magic_link');
            },
            label: const Text('Sign in with Magic Link'),
          ),
          spacer,
          ElevatedButton.icon(
            onPressed: () {
              Navigator.popAndPushNamed(context, '/phone_sign_in');
            },
            icon: const Icon(Icons.phone),
            label: const Text('Sign in with Phone'),
          ),
          spacer,
          SupaSocialsAuth(
            colored: true,
            nativeGoogleAuthConfig: const NativeGoogleAuthConfig(
              webClientId: 'YOUR_WEB_CLIENT_ID',
              iosClientId: 'YOUR_IOS_CLIENT_ID',
            ),
            enableNativeAppleAuth: false,
            socialProviders: OAuthProvider.values,
            onSuccess: (session) {
              Navigator.of(context).pushReplacementNamed('/home');
            },
          ),
        ],
      ),
    );
  }
}
