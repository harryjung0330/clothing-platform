import 'dart:convert';

import 'package:clothing_platform/Model/Dto/AnalysisRequestDto.dart';
import 'package:clothing_platform/Model/Dto/LogInRequestDto.dart';
import 'package:clothing_platform/Model/Dto/LogInResponseDto.dart';
import 'package:clothing_platform/Model/Dto/MessageFormat.dart';
import 'package:clothing_platform/Model/SalesPost.dart';
import 'package:http/http.dart' as http;

import '../Model/Dto/AnalysisDto.dart';
import '../Model/Dto/SalesPostCreateDto.dart';

class TotalRepository
{
  static final TotalRepository _totalRepository = TotalRepository._privTotalRepository();
  static final String AUTHORITY = "clothing-load-1899487240.ap-northeast-2.elb.amazonaws.com";

  static final LOG_IN_PATH = "/user/login";
  static final SALES_POST = "/sales-post";
  static final ANALYSIS = "/analysis";

  String token  = "";
  int userId = -1;

  factory TotalRepository()
  {
    return _totalRepository;
  }

  TotalRepository._privTotalRepository()
  {

  }



  Future<bool> logIn(LogInRequestDto logInRequestDto) async
  {
    late http.Response result;
    Map<String, String> header = {
      "Content-type":"application/json"
    };

    try {
      Uri url = Uri.http(AUTHORITY, LOG_IN_PATH);
      result = await http.post(
          url, body: json.encode(logInRequestDto.toJson()), headers: header);

      print("login:");
      print(result.body);

      if(result.statusCode == 200){

        Map<String, dynamic> res = json.decode(utf8.decode(result.bodyBytes));
        MessageFormat msg = MessageFormat.fromJson(res);
        LogInResponseDto logInResponseDto = LogInResponseDto.fromJson(msg.data as Map<String, dynamic>);
        this.token = logInResponseDto.accessToken;
        this.userId = logInResponseDto.userId;

        return true;

      }
      else{

        return false;

      }
    }
    catch(e)
    {
      print(e);
      return false;
    }
  }

  Future<List<SalesPost>> getSalesPosts() async
  {
    late http.Response result;
    Map<String, String> header = {
      "Content-type":"application/json"
    };

    var queryParameters = {
      'page': 0.toString(),
      'size': 20.toString(),
    };

    try {
      print("before sending request!");

      Uri url = Uri.parse("http://" + AUTHORITY  +SALES_POST + "?page=0&size=20");//Uri.http(AUTHORITY,  SALES_POST, queryParameters);
      print(url);

      result = await http.get(
          url,  headers: header, );



      if(result.statusCode == 200){

        Map<String, dynamic> res = json.decode(utf8.decode(result.bodyBytes));;
        MessageFormat msg = MessageFormat.fromJson(res);

        List<SalesPost> salesPosts = (msg.data as List).map((e)
        {
          print(e);
          return SalesPost.fromJson(e);
        }
            ).toList();

        print(salesPosts);

        return salesPosts;

      }
      else{
        return [];
      }
    }
    catch(e)
    {
      print(e);
      return [];
    }
  }

  Future<List<SalesPost>> searchPosts({required String keyword}) async
  {
    print("keyword: " + keyword);
    late http.Response result;
    Map<String, String> header = {
      "Content-type":"application/json"
    };

    try {
      print("before sending request!");

      Uri url = Uri.parse("http://" + AUTHORITY  + SALES_POST + "?page=0&size=20&keyword="+keyword);//Uri.http(AUTHORITY,  SALES_POST, queryParameters);
      print(url);

      result = await http.get(
        url,  headers: header, );



      if(result.statusCode == 200){

        Map<String, dynamic> res = json.decode(utf8.decode(result.bodyBytes));;
        MessageFormat msg = MessageFormat.fromJson(res);

        List<SalesPost> salesPosts = (msg.data as List).map((e)
        {
          print(e);
          return SalesPost.fromJson(e);
        }
        ).toList();

        print(salesPosts);

        return salesPosts;

      }
      else{
        return [];
      }
    }
    catch(e)
    {
      print(e);
      return [];
    }
  }

  Future<bool> uploadeSalesPost({required SalesPostCreateDto salesPostCreateDto}) async
  {
    Map<String, String> header = {
      "Content-type":"application/json",
      "Authorization": token
    };

    print("sending traffic for adding salesPost");

    try {
      Uri url = Uri.http(AUTHORITY, SALES_POST);
      var request = http.MultipartRequest('POST', url);

      request.fields.addAll({
        "sales_price": salesPostCreateDto.price!.toString(),
        "content": salesPostCreateDto.content!,
        "brand":jsonEncode(salesPostCreateDto.brand!.name),
        "model": salesPostCreateDto.model!,
        "recommended_price":salesPostCreateDto.recommendedPrice!.toString(),
        "userId": userId.toString()
      }, );


      request.files.add(await http.MultipartFile.fromPath('front', salesPostCreateDto.front!));
      request.files.add(await http.MultipartFile.fromPath('back', salesPostCreateDto.back!));
      request.files.add(await http.MultipartFile.fromPath('left', salesPostCreateDto.left!));
      request.files.add(await http.MultipartFile.fromPath('right', salesPostCreateDto.right!));

  request.headers.addAll(header);

  http.StreamedResponse result = await request.send();


  Map<String, dynamic> res = json.decode(await utf8.decodeStream(result.stream));

  print(res);
  if(result.statusCode == 200){

  print("upload salesPost response:");
  print(res);

  return true;
  }
    else{

  return false;
  }
    }
    catch(e)
    {
    print(e);
    return false;
    }
  }

  Future<AnalysisDto> getAIAnalysis({required AnalysisRequestDto analysisRequestDto}) async {
    Map<String, String> header = {
      "Content-type":"application/json",
      "Authorization": token
    };

    print("sending traffic for adding salesPost");

    try {
      Uri url = Uri.http(AUTHORITY, SALES_POST);
      var request = http.MultipartRequest('POST', url);


      request.files.add(await http.MultipartFile.fromPath('front', analysisRequestDto.front!));
      request.files.add(await http.MultipartFile.fromPath('back', analysisRequestDto.back!));
      request.files.add(await http.MultipartFile.fromPath('left', analysisRequestDto.left!));
      request.files.add(await http.MultipartFile.fromPath('right', analysisRequestDto.right!));

    request.headers.addAll(header);

    http.StreamedResponse result = await request.send();


    Map<String, dynamic> res = json.decode(await utf8.decodeStream(result.stream));

    print(res);
    if(result.statusCode == 200){

      print("upload analysis response:");
      print(res);

    return AnalysisDto.fromJson(res);
    }
    else{

    return AnalysisDto(model: null, recommendedPrice: null);
    }
    }
    catch(e)
    {
    print(e);
    return AnalysisDto(model: null, recommendedPrice: null);
    }
  }

}