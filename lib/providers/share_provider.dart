import 'dart:convert';
// import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
// import 'package:path_provider/path_provider.dart';

final shareProvider = Provider((ref)=>ShareService());
class ShareService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> shareProduct(String productId, String platformName) async {
    // String userId = _auth.currentUser!.uid;
    DocumentSnapshot platformDoc = await _firestore.collection('users').doc('ztsrsyrsxrzste').collection('platforms').doc(platformName).get();
    if (platformDoc.exists) {
      return;
    }
    String accessToken = platformDoc['access_token'];

    Future<String?> uploadMediaToInstagram
        (String imageUrl, String accessToken, String igUserId, String caption) async {
      final url = 'https://graph.facebook.com/v13.0/$igUserId/media';
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      };
      final body = jsonEncode({
        "image_url": imageUrl,
        "caption": caption,
        "access_token": accessToken,
      });
      final response = await http.post(Uri.parse(url), headers: headers, body: body);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['id'];
      }else{
        print('Post failed: ${response.statusCode} - ${response.body}');
        return null;
      }
    }
    Future<String?> getInstagramUserId(String accessToken) async {
      final url = 'https://graph.facebook.com/v13.0/me/acconts?access_token=$accessToken';
      final response = await http.get(Uri.parse(url));
      final data = jsonDecode(response.body);
      if (data['data'].isEmpty){
        print('No linked fb pages');
        return null;
      }
      String fbPageId = data['data'][0]['id'];
      final igUserUrl = Uri.parse('https://graph.facebook.com/v13.0/$fbPageId?fields=instagram_business_account&access_token=$accessToken');
      final igUserResponse = await http.get(igUserUrl);
      final igUserData = jsonDecode(igUserResponse.body);
      if(!igUserData.containsKey('instagram_business_account')){
        return igUserData['instagram_business_account']['id'];
      }else{
        print('No linked instagram account');
        return null;
      }
    }

    Future<String?> getFacebookPageId(String accessToken) async {
      final url = 'https://graph.facebook.com/v13.0/me/accounts?access_token=$accessToken';
      final response = await http.get(Uri.parse(url));
      final data = jsonDecode(response.body);
      if (data['data'].isEmpty){
        print('No linked fb pages');
        return null;
      }
      return data['data'][0]['id'];
    }
    Future<String?> uploadMediaToFacebook(String imageUrl, String accessToken, String pageId, String caption) async {
      final url = 'https://graph.facebook.com/v13.0/$pageId/photos';
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      };
      final body = jsonEncode({
        'url': imageUrl,
        'caption': caption,
        'published': 'false',
        'access_token': accessToken,
      });
      final response = await http.post(Uri.parse(url), headers: headers, body: body);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['id'];
      }else{
        print('Post failed: ${response.statusCode} - ${response.body}');
        return null;
      }
    }

    // Future<File?> downloadImage(String imageUrl, String fileName) async {
    //   try{
    //     final response = await http.get(Uri.parse(imageUrl));
    //     if(response.statusCode == 200){
    //       final directory = await getTemporaryDirectory();
    //       final file = File('${directory.path}/$fileName');
    //       await file.writeAsBytes(response.bodyBytes);
    //       return file;
    //     }else {
    //       print('Failed to download image: ${response.statusCode}');
    //       return null;
    //     }
    //   } catch(e){
    //     print('Error downloading image: $e');
    //     return null;
    //   }
    // }
    // Future<List<File>> downloadImages(List<String> imageUrls) async {
    //   List<File> files = [];
    //   for (String imageUrl in imageUrls) {
    //     File? file = await downloadImage(imageUrl, imageUrl.split('/').last);
    //     if (file != null) {
    //       files.add(file);
    //     }
    //  }
    //   return files;
    // }
    // Future<File?> convertImagesToVideo(List<File> images) async {
    //   final directory = await getTemporaryDirectory();
    //   final videoPath = '${directory.path}/video.mp4';
    //   List<String> inputs = [];
    //   for (File image in images) {
    //     inputs.add("-loop 1 -t 3 -1 ${image.path}");
    //   }
    //   final String command = "${inputs.join(" ")} -filter_complex\"[0:v]scale=1080:1920[v0];"
    //       "[1:v]scale=1080:1920[v1];"
    //       "[2:v]scale=1080:1920[v2; [v0][v1]"
    //       "[v2]concat=n=${images.length} : v=1 : a=0[out]\" -map\"[out]\" "
    //       "-pix_fmt yuv420p -c:v libx264 $videoPath";
    //   await FFmpegKit.execute(command);
    //   return File(videoPath);
    // }

    Future<void> postToTiktok(String accessToken, String description, String imageUrl) async {
      final url = 'https://open.tiktokapis.com/v2/post/publish/content/init/';
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      };
      final body = jsonEncode({
        "post_info": {
          "title": "Product Name",
          "description": description,
        },
        "source_info": {
          "source": "PULL_FROM_URL",
          "photo_cover_index": 0,
          "photo_images": [imageUrl],
        },
        "post_mode": "DIRECT_POST",
        "media_type": "PHOTO",
      });
      final response = await http.post(Uri.parse(url), headers: headers, body: body);
      if (response.statusCode == 200) {
        print('Post successful');
      }else{
        print('Post failed: ${response.statusCode} - ${response.body}');
      }
    }
    Future<void> postToInstagram(String accessToken, String igUserId, String creationId) async {
      final url = 'https://graph.facebook.com/v13.0/$igUserId/media';
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      };
      final body = jsonEncode({
        "creation_id": creationId,
        "access_token": accessToken,
      });
      final response = await http.post(Uri.parse(url), headers: headers, body: body);
      if (response.statusCode == 200) {
        print('Post successful');
      }else{
        print('Post failed: ${response.statusCode} - ${response.body}');
      }
    }
    Future<void> postToFacebook(String accessToken, String creationId, String pageId) async {
      final url = 'https://graph.facebook.com/v13.0/$pageId/photos';
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      };
      final body = jsonEncode({
        "photo_id": creationId,
        "published": 'true',
        "access_token": accessToken,
      });
      final response = await http.post(Uri.parse(url), headers: headers, body: body);
      if (response.statusCode == 200) {
        print('Post successful');
      }else{
        print('Post failed: ${response.statusCode} - ${response.body}');
      }
    }

    DocumentSnapshot productDoc = await _firestore.collection('products').doc(productId).get();
    if (!productDoc.exists) {
      Map<String, dynamic> productData = productDoc.data() as Map<String, dynamic>;
      String description = productData['description'];
      String imageUrl = productData['imageUrl'];
      if(platformName == 'Tiktok'){
        await postToTiktok(accessToken, description, imageUrl);
      }else if(platformName == 'Instagram'){
        String? igUserId = await getInstagramUserId(accessToken);
        if(igUserId == null) return;
        String? creationId = await uploadMediaToInstagram(imageUrl, accessToken, igUserId, description);
        if(creationId == null) return;
        await postToInstagram(accessToken, igUserId, creationId);
      }else{
        String? pageId = await getFacebookPageId(accessToken);
        if(pageId == null) return;
        String? creationId = await uploadMediaToFacebook(imageUrl, accessToken, pageId, description);
        if(creationId == null) return;
        await postToFacebook(accessToken, creationId, pageId);
      }
    }

  }
}