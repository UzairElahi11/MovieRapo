// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:testmovie/apimanager/url_constants.dart';
import 'package:testmovie/utils/apputils.dart';

typedef void ResponseCompletion(String responseBody, bool success);

class ServerManager {
  static const int timeOutSeconds = 30;

  ServerManager._();
  static void callPostApi(String url, Map<String, String> headers,
      Map<String, dynamic> body, completion(String responseBody, bool success),
      {int timeout = timeOutSeconds}) {
    bool onCallDone = false;
    if (!url.startsWith("https")) {
      HttpClient httpClient = new HttpClient();
      httpClient.badCertificateCallback =
          ((X509Certificate cert, String host, int port) => true);

      debugPrint(
          "url: $url \nBody:${body == null ? "" : body.toString()}");
      debugPrint("url: $url \nBody:${body == null ? "" : body.toString()}");
      try {
        httpClient.postUrl(Uri.parse(url)).then((request) {
        
          request.add(utf8.encode(json.encode(body)));
          debugPrint("---------${request.contentLength.toString()}");
          request.close().then((response) {
            response.transform(utf8.decoder).join().then((responseBody) {
              logResponse(url, {}, headers, responseBody, response.statusCode);

              if (response != null &&
                  response.statusCode == 200 &&
                  responseBody != null) {
                debugPrint("responce from server $responseBody");
            
                debugPrint("responce from server $responseBody");
                callCompletion(responseBody, true, completion);
                //   if (isResponseCodeForReLoginFromResponse(responseBody)) {
                //     if (Keys.mainNavigatorKey.currentContext != null &&
                //         body.containsKey("context") &&
                //         body["context"] ==
                //             UrlConstants.appServerContextAfterLogin) {}
                //   }
              } else {
                callCompletion(responseBody, false, completion);
              }
            });
          }).catchError((error) {
            if (error != null && error.runtimeType == String) {
              debugPrint("response: " + error);
              
            }
            debugPrint('error callback catch');
            if (onCallDone == false) {
              onCallDone = true;
              callCompletion(null, false, completion);
            }
          }).whenComplete(() {
            debugPrint("Api complete");
            // ignore: unnecessary_statements
          });
        }).catchError((error) {
          if (error != null && error.runtimeType == String) {
            debugPrint("response: " + error);
           
          }
          debugPrint('error callback catch');
          if (onCallDone == false) {
            onCallDone = true;
            callCompletion(null, false, completion);
          }
        });
      } catch (e) {
        if (e != null) {}
        callCompletion(null, false, completion);
        debugPrint('catch callback');
      } finally {
//        callCompletion(null, false, completion);
        debugPrint('catch callback finally');
      }
    } else {
      var client = http.Client();
      try {
        client
            .post(Uri.parse(url),
                body: body,
                headers:  bearerToken != null
                    ? {
                        // HttpHeaders.contentTypeHeader: "application/json",
                        HttpHeaders.authorizationHeader: "Bearer $bearerToken"
                      }
                    : null)
            .timeout(Duration(seconds: timeout))
            .then((http.Response response) {
          onCallDone = true;
          debugPrint("internal reach");
          log('Response Success $url ${body.toString()} Header: ${headers.toString()}');
          if (response != null && response.statusCode == 200) {
            log("-------" + response.body.toString());
            callCompletion(response.body, true, completion);
          } else {
            debugPrint(
                "responce error code ${response.statusCode} responce code ${response.body}");
            callCompletion(response.body, false, completion);
          }
        }).catchError((Object error) {
          if (error != null && error.runtimeType == String) {
            debugPrint("response: error " + error.toString());
          }
          debugPrint('error callback catch ' + error.toString());
          if (onCallDone == false) {
            onCallDone = true;
            callCompletion(null, false, completion);
          }
        }).whenComplete(() {
          debugPrint("Api complete");
          // ignore: unnecessary_statements
          client.close;
        });
      } on Function catch (e, _) {
        if (e != null) {}
        callCompletion(null, false, completion);
        debugPrint('catch callback' + e.toString());
      }
    }
  }

  static void callCompletion(
      String? responseBody, bool success, ResponseCompletion completion) {
    if (responseBody != null && responseBody.runtimeType == String) {
    } else {
      debugPrint("Invalid response");
    }
    if (completion != null) {
      completion(responseBody ?? "", success);
    }
  }

  static void getApiCalling(String url, Map<String, String> headers,
      Map<String, dynamic> body, completion(String responseBody, bool success),
      {int timeout = timeOutSeconds}) {
    bool onCallDone = false;
    if (!url.startsWith("https")) {
      HttpClient httpClient = new HttpClient();
      httpClient.badCertificateCallback =
          ((X509Certificate cert, String host, int port) => true);


      debugPrint(
          "url: " + url + " \nBody:" + (body == null ? "" : body.toString()));
    
      try {
        httpClient.postUrl(Uri.parse(url)).then((request) {
         
          request.add(utf8.encode(json.encode(body)));
          debugPrint("---------${request.contentLength.toString()}");
          request.close().then((response) {
            response.transform(utf8.decoder).join().then((responseBody) {
              logResponse(url, {}, headers, responseBody, response.statusCode);

              if (response != null &&
                  response.statusCode == 200 &&
                  responseBody != null) {
                debugPrint("responce from server $responseBody");
               
                callCompletion(responseBody, true, completion);
               
              } else {
                callCompletion(responseBody, false, completion);
              }
            });
          }).catchError((error) {
            if (error != null && error.runtimeType == String) {
              debugPrint("response: " + error ?? "");
              
            }
            debugPrint('error callback catch');
            if (onCallDone == false) {
              onCallDone = true;
              callCompletion(null, false, completion);
            }
          }).whenComplete(() {
            print("Api complete");
            // ignore: unnecessary_statements
          });
        }).catchError((error) {
          if (error != null && error.runtimeType == String) {
            debugPrint("response: " + error);
         
          }
          print('error callback catch');
          if (onCallDone == false) {
            onCallDone = true;
            callCompletion(null, false, completion);
          }
        });
      } catch (e) {
        if (e != null) {}
        callCompletion(null, false, completion);
        debugPrint('catch callback');
      } finally {
//        callCompletion(null, false, completion);
        debugPrint('catch callback finally');
      }
    } else {
      var client = http.Client();
      try {
        client
            .get(Uri.parse(url), headers: {
              HttpHeaders.contentTypeHeader: "application/json",
              HttpHeaders.authorizationHeader: "Bearer ${bearerToken!}"
            })
            .timeout(Duration(seconds: timeout))
            .then((http.Response response) {
              onCallDone = true;
              log("internal reach");
              log('Response Success $url ${body?.toString()} Header: ${headers?.toString() ?? ""}');
              if (response != null && response.statusCode == 200) {
                log("-------${response.body}");
                callCompletion(response.body, true, completion);
              } else {
                debugPrint(
                    "responce error code ${response.statusCode} responce code ${response.body}");
                callCompletion(response.body, false, completion);
              }
            })
            .catchError((Object error) {
              if (error != null && error.runtimeType == String) {
                debugPrint("response: error $error");
              }
              debugPrint('error callback catch $error');
              if (onCallDone == false) {
                onCallDone = true;
                callCompletion(null, false, completion);
              }
            })
            .whenComplete(() {
              debugPrint("Api complete");
              // ignore: unnecessary_statements
              client.close;
            });
      } on Function catch (e, _) {
        if (e != null) {}
        callCompletion(null, false, completion);
        debugPrint('catch callback$e');
      }
    }
  }

  static void logResponse(String url, Map<String, dynamic> body,
      Map<String, String> headers, String? responseBody, int? responseCode) {
    try {
      bool success = responseCode == 200;
      if (success) {
        debugPrint("\n✅✅✅ ------- Success Response Start ------- ✅✅✅ \n");
      } else {
        debugPrint("\n❌❌❌❌ ------- Failure Response Start ------- ❌❌❌❌\n\n");
      }
      debugPrint('Url::: $url');
      debugPrint('Headers::: ${headers.toString()}');
      debugPrint('Body::: $body');
      try {
        debugPrint(
            'API Response Code::: ${(responseCodeFromResponse(responseBody!) ?? "")}');
      } catch (e) {}
      debugPrint('Response Code::: ${(responseCode?.toString() ?? "")}');
      debugPrint('Response::: ${responseBody!}');
      if (success) {
        debugPrint("\n✅✅✅ ------- Success Response End ------- ✅✅✅ \n");
      } else {
        debugPrint("\n❌❌❌❌ ------- Failure Response End ------- ❌❌❌❌\n\n");
      }
    } catch (e) {}
  }

  static String? responseCodeFromResponse(String responseBody) {
    try {
      if (responseBody != null) {
        dynamic content = AppUtil.decodeString(responseBody);
        if (content is Map) {
          return responseCode(content);
        }
      }
    } on Exception catch (e) {
      // TODO
    }
    return null;
  }

  static String? responseCode(Map<dynamic, dynamic> json) {
    String responseCode = "empty";
    try {
      if (json != null && json.isNotEmpty) {
        responseCode = json['responseCode'];
      }
      debugPrint("Response code :: " + responseCode);
    } on Exception catch (e) {
      // TODO
    }
    return null;
  }
    static _defaultHeader() {
    Map<String, String> requestHeaders = {};

    return requestHeaders;
  }

  // static void register(String email, String password, String name, String apple,
  //     String facebook, String google, ResponseCompletion completion) {
  //   Map<String, dynamic> json = {
     
  //   };
  //   callPostApi(UrlConstants.register, _defaultHeader(), json, completion);
  // }

 
   static void fetchRatedMovies(ResponseCompletion completion) {
    Map<String, dynamic> json = {};
    getApiCalling(
        UrlConstants.fetchRatedMovies, _defaultHeader(), json, completion);
  }

    static void fetchGenere(ResponseCompletion completion) {
    Map<String, dynamic> json = {};
    getApiCalling(
        UrlConstants.generes, _defaultHeader(), json, completion);
  }

   static void fetchMovieDetail(String id, ResponseCompletion completion) {
    Map<String, dynamic> json = {};
    getApiCalling(
        UrlConstants.fetchMovieDetail.replaceFirst("id", id), _defaultHeader(), json, completion);
  }
  
 
}
