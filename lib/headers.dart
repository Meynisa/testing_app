import 'dart:convert';
import 'dart:developer';

// HEADER IN API PROVIDER

Future<Map<String, String>> getHeaders({bool auth = true, bool contentType = true, String contentString = 'application/json', isBasicAuth = false}) async {

  var token = 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIyIiwianRpIjoiMDEwMWY4ZjIzNTFkNDY3MDRlZmMxNzM0YzgyMmQzMjYyZmNiZDVmMmFkNWMwOGM3YTIwYTQ2ZDU0MGI5Y2U3MDI2NTBiZDExYmNiNDNiNDkiLCJpYXQiOjE2MDYyOTA1NjMsIm5iZiI6MTYwNjI5MDU2MywiZXhwIjoxNjA4ODgyNTYzLCJzdWIiOiIxMTkiLCJzY29wZXMiOltdfQ.BrM8scUVQECTI8Y4TCqmRk8qfPPt2yvSM_WASAK0tf8grjaSf_XWmVSQHdxeR_E9RODugWDJ8u3Se1AqvGOPsoSZjpsd5VMjjxfsACMrB3hCr0vU_ES93pABEM4yEmIfmY-Cm9DsVRjfDgqk9npGVVBw-vAQclQHvu7e94fzvYF-wEtucV2lqEb-Dx3zaYA_Pt6Z-6tCYQp3rwEuS8haIZdM9gq5Dr1X7I4-qANi0KvaflB5gvFhrQGYWsf5_TUVLuZ7tWoF0O-aY9XMckXS0TVMf1c13BsP_w574ss-qtYIQjxcOXrMxLniDOxvVhXOK7v_WJx032QdceDtLcTNmziDsDd54u3lsktJKo0_sxfJcoqPCWLo-7aiYqjrbvyPHAGG8CJ8bhfQNzG0gIY79OuEXjphypQw3RRkhKThr-rh5WP4INYdIofotcajTrRVBZqGr_4D03tm9EUzCTp9w3ktbAzIARBCmJc7jJYVzz-J2K94-oGacKnUI_WJ2wFY0U5f0R61Kdx4VftfqGJcTrLMhUUwuaMdp9wI-OMV8IWdCPiFSp6H8YqYYmZnagWQyNe3bxQ--XuvT0h88wmv_TGUctQXIrdUkYMFqyrZiVqUPOFevM-q0nmA6qS3T8BoeiEU52-S1-RGcIwSRal_W3EzJg34xTomOoVOIN4q19U';
  var headers;
  if(contentType == true){
    headers = {
      'Content-Type': contentString,
      'Accept': 'application/x.paruh.waktu.v2+json',
      'Accept-Language': 'id',
    };
  }else{
    headers = {
      'Accept': 'application/x.paruh.waktu.v2+json',
      'Accept-Language': 'id',
    };
  }

  if (auth) headers['Authorization'] = "Bearer " + token;

  // if (isBasicAuth == true) headers['authorization'] = 'Basic ' + base64Encode(utf8.encode('${Url.usernameContent}:${Url.passwordContent}'));

  log("HEADERS: $headers");

  return headers;
}