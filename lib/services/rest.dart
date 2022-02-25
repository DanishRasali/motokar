//-----------------------------------------------------------------------------------------------------------------------------
//? This class is fully given. It is used for handling the actual REST calls
// Note that, the methods in this class are declared as 'static' so that
//  they can be called to directly from the class (that means, no need to create an object first).
//-----------------------------------------------------------------------------------------------------------------------------

// https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=[API_KEY]

import 'dart:convert';
import 'package:http/http.dart' as http;

class Rest {
  static final Rest _instance = Rest._constructor();
  factory Rest() {
    return _instance;
  }

  Rest._constructor();

  //? Change the baseUrl according to your PC's IP address. Remain the port as 3000
  static const String _baseUrl =
      'https://us-central1-motokar-map-98149.cloudfunctions.net/api';

  // Send a GET request to retrieve data from a REST server
  static Future get(String endpoint) async {
    final response = await http.get(Uri.parse('$_baseUrl/$endpoint'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    throw response;
  }

  // Send a POST request to add a new in the REST server
  static Future post(String endpoint, {dynamic data}) async {
    final response = await http.post(Uri.parse('$_baseUrl/$endpoint'),
        headers: {'Content-Type': 'application/json'}, body: jsonEncode(data));

    if (response.statusCode == 201) {
      return jsonDecode(response.body);
    }
    throw response;
  }

  // Send a PUT request to update an existing data in the REST server.
  static Future put(String endpoint, {dynamic data}) async {
    final response = await http.put(Uri.parse('$_baseUrl/$endpoint'),
        headers: {'Content-Type': 'application/json'}, body: jsonEncode(data));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    throw response;
  }

  // Send a PATCH request to update parts of an existing data in the REST server.
  static Future patch(String endpoint, {dynamic data}) async {
    final response = await http.patch(Uri.parse('$_baseUrl/$endpoint'),
        headers: {'Content-Type': 'application/json'}, body: jsonEncode(data));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    throw response;
  }

  // Send a DELETE request to remove an existing data from the REST server.
  static Future delete(String endpoint) async {
    final response = await http.delete(Uri.parse('$_baseUrl/$endpoint'));

    if (response.statusCode == 200) {
      return;
    }
    throw response;
  }
}
