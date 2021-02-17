import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:testing_app/headers.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key key}) : super(key: key);

  @override
  _EditProfileState createState() => new _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  File _imgProfile;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Foto'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _buildProfilePhoto(),
          SizedBox(height: 10),
          FlatButton(
            onPressed: _uploadImg,
            child: Text('Simpan'),
            color: Colors.blue,
          )
        ],
      ),
    );
  }

  Future<void> _selectImageSource(BuildContext context) {
    return showDialog<void>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(new Radius.circular(8.0))),
            title: Text('Pilih sumber photo'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  FlatButton(
                    onPressed: () {
                      ImageSource src = ImageSource.gallery;
                      _pickImage(src).then((onValue) {
                        print('IMG PROFILE: $_imgProfile');
                        Navigator.pop(context);
                      });
                    },
                    child: Text(
                      'GALERI',
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.all(new Radius.circular(8.0)),
                        side: BorderSide(color: Colors.black, width: 0.5)),
                  ),
                  FlatButton(
                    onPressed: () async {
                      ImageSource src = ImageSource.camera;
                      print('PRINT: $src');
                      _pickImage(src).then((onValue) {
                        print('PRINT: $onValue');
                        Navigator.pop(context);
                      });
                    },
                    child: Text(
                      'CAMERA',
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.all(new Radius.circular(8.0)),
                        side: BorderSide(color: Colors.black, width: 0.5)),
                  ),
                  FlatButton(
                    child: Text(
                      'TUTUP',
                      style: TextStyle(color: Colors.teal),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future<File> _pickImage(src) async {
    final File img = await ImagePicker.pickImage(
        source: src, imageQuality: 60, maxWidth: 300.0);
    print('PRINT: $img');
    setState(() {
      this._imgProfile = img;
    });
    return img;
  }

  Widget _buildProfilePhoto() {
    return Center(
      child: Stack(children: <Widget>[
        _imgProfile != null
            ? Container(
                height: 140,
                width: 140,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100.0),
                  border: Border.all(
                    color: Colors.black38,
                    style: BorderStyle.solid,
                  ),
                  image: DecorationImage(
                    image: FileImage(this._imgProfile),
                    fit: BoxFit.cover,
                  ),
                ),
              )
            : Container(
                height: 140,
                width: 140,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Container(
                      width: 80,
                      height: 80,
                    )),
              ),
        Positioned(
            bottom: 0.0,
            right: 0.0,
            child: Container(
              height: 40.0,
              width: 40.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100.0),
                  color: Colors.teal),
              child: IconButton(
                  icon: Icon(
                    Icons.photo_camera,
                    color: Colors.white,
                  ),
                  color: Colors.teal,
                  onPressed: () async {
                    await _selectImageSource(context);
                  }),
            )),
      ]),
    );
  }

  ApiProvider _provider = ApiProvider();

  _uploadImg() async {
    var response = await _provider.uploadImg(_imgProfile);
    print('RES: $response');
  }

  String _handleError(Error error) {
    String errorDescription = "";
    if (error is DioError) {
      DioError dioError = error as DioError;
      switch (dioError.type) {
        case DioErrorType.CANCEL:
          errorDescription = "Request to API server was cancelled";
          break;
        case DioErrorType.CONNECT_TIMEOUT:
          errorDescription = "Connection timeout with API server";
          break;
        case DioErrorType.DEFAULT:
          errorDescription =
              "Connection to API server failed due to internet connection";
          break;
        case DioErrorType.RECEIVE_TIMEOUT:
          errorDescription = "Receive timeout in connection with API server";
          break;
        case DioErrorType.RESPONSE:
          errorDescription =
              "Received invalid status code: ${dioError.response.statusCode}";
          break;
        case DioErrorType.SEND_TIMEOUT:
          errorDescription = "Send timeout in connection with API server";
          break;
      }
    } else {
      errorDescription = "Unexpected error occured";
    }
    return errorDescription;
  }
}

class LoggingInterceptor extends Interceptor {
  int _maxCharactersPerLine = 200;

  @override
  Future onRequest(RequestOptions options) {
    print("--> ${options.method} ${options.path}");
    print("Content type: ${options.contentType}");
    print("<-- END HTTP");
    return super.onRequest(options);
  }

  @override
  Future onResponse(Response response) {
    print(
        "<-- ${response.statusCode} ${response.request.method} ${response.request.path}");
    String responseAsString = response.data.toString();
    if (responseAsString.length > _maxCharactersPerLine) {
      int iterations =
          (responseAsString.length / _maxCharactersPerLine).floor();
      for (int i = 0; i <= iterations; i++) {
        int endingIndex = i * _maxCharactersPerLine + _maxCharactersPerLine;
        if (endingIndex > responseAsString.length) {
          endingIndex = responseAsString.length;
        }
        print(
            responseAsString.substring(i * _maxCharactersPerLine, endingIndex));
      }
    } else {
      print(response.data);
    }
    print("<-- END HTTP");

    return super.onResponse(response);
  }

  @override
  Future onError(DioError err) {
    print("<-- Error -->");
    print(err.error);
    print(err.message);
    return super.onError(err);
  }
}

class ApiProvider {
  final String _endpoint = "https://apiv2-pw.s45.in/storage/files/profile";
  Dio _dio;

  Response response;

  // var headers = {
  //   'Content-Type': 'application/x-www-form-urlencoded',
  //   'Accept': 'application/x.paruh.waktu.v2+json',
  //   'Accept-Language': 'id',
  //   'Authorization':
  //       "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIyIiwianRpIjoiMDEwMWY4ZjIzNTFkNDY3MDRlZmMxNzM0YzgyMmQzMjYyZmNiZDVmMmFkNWMwOGM3YTIwYTQ2ZDU0MGI5Y2U3MDI2NTBiZDExYmNiNDNiNDkiLCJpYXQiOjE2MDYyOTA1NjMsIm5iZiI6MTYwNjI5MDU2MywiZXhwIjoxNjA4ODgyNTYzLCJzdWIiOiIxMTkiLCJzY29wZXMiOltdfQ.BrM8scUVQECTI8Y4TCqmRk8qfPPt2yvSM_WASAK0tf8grjaSf_XWmVSQHdxeR_E9RODugWDJ8u3Se1AqvGOPsoSZjpsd5VMjjxfsACMrB3hCr0vU_ES93pABEM4yEmIfmY-Cm9DsVRjfDgqk9npGVVBw-vAQclQHvu7e94fzvYF-wEtucV2lqEb-Dx3zaYA_Pt6Z-6tCYQp3rwEuS8haIZdM9gq5Dr1X7I4-qANi0KvaflB5gvFhrQGYWsf5_TUVLuZ7tWoF0O-aY9XMckXS0TVMf1c13BsP_w574ss-qtYIQjxcOXrMxLniDOxvVhXOK7v_WJx032QdceDtLcTNmziDsDd54u3lsktJKo0_sxfJcoqPCWLo-7aiYqjrbvyPHAGG8CJ8bhfQNzG0gIY79OuEXjphypQw3RRkhKThr-rh5WP4INYdIofotcajTrRVBZqGr_4D03tm9EUzCTp9w3ktbAzIARBCmJc7jJYVzz-J2K94-oGacKnUI_WJ2wFY0U5f0R61Kdx4VftfqGJcTrLMhUUwuaMdp9wI-OMV8IWdCPiFSp6H8YqYYmZnagWQyNe3bxQ--XuvT0h88wmv_TGUctQXIrdUkYMFqyrZiVqUPOFevM-q0nmA6qS3T8BoeiEU52-S1-RGcIwSRal_W3EzJg34xTomOoVOIN4q19U",
  // };

  ApiProvider() {
    // _dio.interceptors.add(LoggingInterceptor());
  }

  uploadImg(File image) async {
    var headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Accept': 'application/x.paruh.waktu.v2+json',
      'Accept-Language': 'id',
      'Authorization':
          "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIyIiwianRpIjoiMDEwMWY4ZjIzNTFkNDY3MDRlZmMxNzM0YzgyMmQzMjYyZmNiZDVmMmFkNWMwOGM3YTIwYTQ2ZDU0MGI5Y2U3MDI2NTBiZDExYmNiNDNiNDkiLCJpYXQiOjE2MDYyOTA1NjMsIm5iZiI6MTYwNjI5MDU2MywiZXhwIjoxNjA4ODgyNTYzLCJzdWIiOiIxMTkiLCJzY29wZXMiOltdfQ.BrM8scUVQECTI8Y4TCqmRk8qfPPt2yvSM_WASAK0tf8grjaSf_XWmVSQHdxeR_E9RODugWDJ8u3Se1AqvGOPsoSZjpsd5VMjjxfsACMrB3hCr0vU_ES93pABEM4yEmIfmY-Cm9DsVRjfDgqk9npGVVBw-vAQclQHvu7e94fzvYF-wEtucV2lqEb-Dx3zaYA_Pt6Z-6tCYQp3rwEuS8haIZdM9gq5Dr1X7I4-qANi0KvaflB5gvFhrQGYWsf5_TUVLuZ7tWoF0O-aY9XMckXS0TVMf1c13BsP_w574ss-qtYIQjxcOXrMxLniDOxvVhXOK7v_WJx032QdceDtLcTNmziDsDd54u3lsktJKo0_sxfJcoqPCWLo-7aiYqjrbvyPHAGG8CJ8bhfQNzG0gIY79OuEXjphypQw3RRkhKThr-rh5WP4INYdIofotcajTrRVBZqGr_4D03tm9EUzCTp9w3ktbAzIARBCmJc7jJYVzz-J2K94-oGacKnUI_WJ2wFY0U5f0R61Kdx4VftfqGJcTrLMhUUwuaMdp9wI-OMV8IWdCPiFSp6H8YqYYmZnagWQyNe3bxQ--XuvT0h88wmv_TGUctQXIrdUkYMFqyrZiVqUPOFevM-q0nmA6qS3T8BoeiEU52-S1-RGcIwSRal_W3EzJg34xTomOoVOIN4q19U",
    };
    BaseOptions options = BaseOptions(
        receiveTimeout: 30000, connectTimeout: 30000, headers: headers);
    _dio = Dio(options);
    _dio.interceptors.add(LoggingInterceptor());

    // Options opsi = Options(
    //     headers: await getHeaders(
    //         contentString: 'application/x-www-form-urlencoded'));

    try {
      String fileName = image.path.split('/').last;
      FormData formData = FormData.fromMap({
        "filename":
            await MultipartFile.fromFile(image.path, filename: fileName),
      });

      response = await _dio.post(_endpoint, data: formData);
      print('response $response');
      return response;
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return _handleError(error);
    }
  }

  String _handleError(Error error) {
    String errorDescription = "";
    if (error is DioError) {
      DioError dioError = error as DioError;
      switch (dioError.type) {
        case DioErrorType.CANCEL:
          errorDescription = "Request to API server was cancelled";
          break;
        case DioErrorType.CONNECT_TIMEOUT:
          errorDescription = "Connection timeout with API server";
          break;
        case DioErrorType.DEFAULT:
          errorDescription =
              "Connection to API server failed due to internet connection";
          break;
        case DioErrorType.RECEIVE_TIMEOUT:
          errorDescription = "Receive timeout in connection with API server";
          break;
        case DioErrorType.RESPONSE:
          errorDescription =
              "Received invalid status code: ${dioError.response.statusCode}";
          break;
        case DioErrorType.SEND_TIMEOUT:
          errorDescription = "Send timeout in connection with API server";
          break;
      }
    } else {
      errorDescription = "Unexpected error occured";
    }
    return errorDescription;
  }
}
