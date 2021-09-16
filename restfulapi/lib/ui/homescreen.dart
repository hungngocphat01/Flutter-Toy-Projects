// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Homescreen extends StatefulWidget {
  const Homescreen({Key? key}) : super(key: key);

  @override
  _HomescreenState createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  String? _httpMethod = "GET";
  String _httpURI = "";
  String _httpReqBody = "";
  var _httpResBodyController = TextEditingController();

  Future<Map<String, dynamic>> _makeHTTPRequest() async {
    var url = Uri.parse(_httpURI);
    var httpHeader = {
      "Access-Control-Allow-Origin": "*",
      "Content-type": "application/json"
    };
    http.Response res;

    switch (_httpMethod) {
      case "GET":
        res = await http.get(url, headers: httpHeader);
        break;
      case "POST":
        res = await http.post(url, headers: httpHeader, body: _httpReqBody);
        break;
      case "PUT":
        res = await http.put(url, headers: httpHeader, body: _httpReqBody);
        break;
      case "DELETE":
        res = await http.delete(url, headers: httpHeader);
        break;
      default:
        return {
          "status_code": -1,
          "body": "Client error",
        };
    }

    Map<String, dynamic> result = {
      "status_code": res.statusCode,
      "body": res.body
    };
    return result;
  }

  void _handleSubmitClick() {
    _httpResBodyController.text = "Waiting...";

    _makeHTTPRequest().then(
      (value) => setState(() {
        _httpResBodyController.text = "STATUS: ${value["status_code"]}";
        _httpResBodyController.text += "\nBODY: ${value["body"]}";
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Restful API practice"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DropdownButton(
                  value: _httpMethod,
                  onChanged: (String? newvalue) =>
                      setState(() => _httpMethod = newvalue),
                  items: <String>["GET", "POST", "PUT", "DELETE"]
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                Expanded(
                  child: TextField(
                    onChanged: (String value) => _httpURI = value,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "API URI",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: ElevatedButton(
                    onPressed: _handleSubmitClick,
                    child: const Text("Send request"),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextField(
              onChanged: (value) => _httpReqBody = value,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Request body (JSON)",
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextField(
              controller: _httpResBodyController,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Response body (JSON)",
              ),
            ),
          ),
        ],
      ),
    );
  }
}
