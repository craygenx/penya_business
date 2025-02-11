import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:url_launcher/url_launcher.dart';

final socialAuthProvider = Provider((ref)=>SocialAuthService());

class SocialAuthService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> authenticatePlatform(String platformName) async {
    String authUrl;

    if (platformName == 'Tiktok') {
      authUrl = 'https://www.tiktok.com/auth?client_id=CLIENT_ID';
    }else if (platformName == 'Instagram') {
      authUrl = 'https://www.instagram.com/oauth/authorize/?client_id=CLIENT_ID';
    }else{
      authUrl = 'https://www.facebook.com/v16.0/dialog/oauth?client_id=CLIENT_ID';
    }
    await launchUrl(Uri.parse(authUrl));
  }

  Future<void> handleOAuthCallback(Uri uri,  String platformName) async {
    String? code = uri.queryParameters['code'] ?? "";
    if (code.isEmpty) return;
    Map<String, String> tokens = await getTokens(code, platformName);
    String userId = _auth.currentUser!.uid;
    await _firestore.collection('users').doc('ztsrsyrsxrzste')
        .collection('platforms').doc(platformName).set({
      "access_token": tokens["access_token"],
      "refresh_token": tokens["refresh_token"],
      "expires_at": DateTime.now().add(Duration(hours: 1)).toIso8601String(),
    });
  }
  Future<String?> loginWithFacebook() async {
    try {
      final result = await FacebookAuth.instance.login(
        permissions: ['public_profile', 'email', 'instagram_basic', 'instagram_content_publish', 'pages_show_list', 'pages_manage_metadata',
          'pages_manage_posts', 'pages_read_engagement', 'pages_read_user_content'],
      );
      if(result.status == LoginStatus.success){
        final accessToken = result.accessToken!;
        return accessToken.tokenString;
      }else{
        return null;
      }
    }catch(e){
      return null;
    }
  }
  Future<String?> authenticateWithTiktok() async {
    final clientId = 'CLIENT_ID';
    final redirectUri = 'https://example.com/callback';
    final scopes = 'video_upload';
    final authUrl = 'https://www.tiktok.com/auth/authorize/?client_key=$clientId&scope=$scopes&response_type=code&redirect_uri=$redirectUri';
    final result = await FlutterWebAuth2.authenticate(
      url: authUrl,
      callbackUrlScheme: 'http',
    );
    final code = Uri.parse(result).queryParameters['code'];
    if (code != null) {
      final tokenUrl = 'https://open.tiktokapis.com/v2/oauth/token/';
      final response = await http.post(
        Uri.parse(tokenUrl),
        body: {
          'client_key': '',
          'client_secret': '',
          'grant_type': 'authorization_code',
          'code': code,
          'redirect_uri': 'https://example.com/callback'
        });
      final data = jsonDecode(response.body);
      return data['data']['access_token'];
    }
    return null;

  }
  Future<Map<String, String>> getTokens(String code, String platformName) async {
    String tokenUrl;
    Map<String, String> body;
    if (platformName == 'Tiktok') {
      tokenUrl = 'https://open.tiktokapis.com/v2/oauth/token/';
      body = {
        'grant_type': 'authorization_code',
        'code': code,
        'client_id': 'CLIENT_ID',
        'client_secret': 'CLIENT_SECRET',
      };
    } else if (platformName == 'Instagram') {
      tokenUrl = 'https://api.instagram.com/oauth/access_token';
      body = {
        'grant_type': 'authorization_code',
        'code': code,
        'client_id': 'CLIENT_ID',
        'client_secret': 'CLIENT_SECRET',
      };
    } else {
      loginWithFacebook();
      tokenUrl = '';
      body={};
    }
    final response = await http.post(
      Uri.parse(tokenUrl),
      body: body,
    );
    final Map<String, dynamic> data = json.decode(response.body);

    return {
      "access_token": data["access_token"],
      "refresh_token": data["refresh_token"] ?? "",
    };
  }
}