import 'dart:convert';
import 'package:groundbooking/main.dart';
import 'package:groundbooking/memeberhome.dart';
import 'package:http/http.dart' as http;

 List<String> imageUrlsList = [];
 List<Map<String,dynamic>> newsList = [];
 String token='';
 String id='';
 List<Map<String,dynamic>>dropDownList=[];
 List<String>dateList=[];



// registrationAPI

Future<void> postDataToDjango(Map<String, dynamic> data,filePath) async {
  final String apiUrl = 'http://192.168.1.27:8000/apiclubmember'; 
  try {
    var request = http.MultipartRequest('POST', Uri.parse(apiUrl));

   
    data.forEach((key, value) {
      request.fields[key] = value.toString();
    });
    request.files.add(
      await http.MultipartFile.fromPath(
        'photo', 
        filePath,
      ),
    );
print('started');
    // Send the request
    var streamedResponse = await request.send();
    print('started');
    // Get response as string
    var response = await http.Response.fromStream(streamedResponse);

    print(response.statusCode);

    if (response.statusCode == 200) {
      // Request was successful
      print('Response from server: ${response.body}');
    } else {
      // Handle errors
      print('Failed to post data to Django server. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  } catch (e) {
    // Handle exceptions
    print('Error posting data: $e');
}
}





//loginAPI
Future<void> loginUser(String username, String password,context) async {
 
  final url = Uri.parse('http://192.168.1.27:8000/apiuserlogin');

  try {
    final response = await http.post(
      url,
      body: {
        'username': username,
        'password': password,
      },
    );
 print(response.statusCode);
    if (response.statusCode == 200) {
     
     
      final Map<String, dynamic> responseData = json.decode(response.body);
      print({'success': true, 'data': responseData}) ;
      if(responseData['token']!=null)
      {
       
        navigation(context, HomeScreen());
       
         token=responseData['token'];
         Map <String,dynamic>sessondata=responseData['session_data'];
print(sessondata);
        
        id=sessondata['user_id'].toString();
         print('$id$token');
      }
      else{
        print("sorry");
      }
      

    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to login');
    }
  } catch (e) {
    // Catch any errors during the process
    print({'success': false, 'error': e.toString()});
  }
}

// get gallery images


Future<void> fetchImagesFromDjango() async {
  final response = await http.get(Uri.parse('http://192.168.1.27:8000/apiclubgallary'));

  if (response.statusCode == 200) {
    
    Map<String, dynamic> jsonResponse = json.decode(response.body);
    print(jsonResponse); // Decode as Map
    
   
    if (jsonResponse.containsKey('data')) {
      List<Map<String, dynamic>> images = List<Map<String, dynamic>>.from(jsonResponse['data']);
      print(images);
      
      List<String> imageUrls = [];
      for (var url in images) {
        
        imageUrls.add(url['img']);
      }
      print(imageUrls);
      imageUrlsList=imageUrls;
    } else {
      throw Exception('No data field found in the response');
    }
  } else {
    // If that response was not OK, throw an error.
    throw Exception('Failed to load images');
  }
}



// get news
Future<void> fetchNewsListFromApi() async {
  final url = Uri.parse('http://192.168.1.27:8000/apinewsview');
  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
     
      List<dynamic> responseData = json.decode(response.body);
      
     
      List<Map<String, dynamic>> stringList = responseData.cast<Map<String, dynamic>>();
      print(stringList);
      
      newsList= stringList;
    } else {
      
      throw Exception('Failed to load news');
    }
  } catch (error) {
    // Throw exception if there's an error in making the request
    throw Exception('Failed to fetch data: $error');
  }
}

//Ground Booking
Future<void> storeDataToApiWithIdAndToken( Map<String, dynamic> data,context) async {
  try {
    print(data);
    final response = await http.post(
     Uri.parse('http://192.168.1.27:8000/apigroundbooking'),
      headers: {
        'Content-Type': 'application/json',
        // 'Authorization': 'Bearer $token', // Assuming token-based authentication
        // 'user_id': id, // Assuming you need to include an ID header
      },
      body: json.encode(data),
    );

    if (response.statusCode == 200) {
      showSnackbar(context, 'ground Booked successfully');
      print(response.body);
    } else {
      
      print(response.statusCode);
      throw Exception('Failed to store data: ${response.reasonPhrase}');
    }
  } catch (e) {
    
    print('Error: $e');
   
  }
}

//getDropdownlist
Future<void> getDropdownListFromApi() async {
  final url = Uri.parse('http://192.168.1.27:8000/apiviewpurpose');
  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      
      List<dynamic> responseData = json.decode(response.body);
      
      
      List<Map<String, dynamic>> stringList = responseData.cast<Map<String, dynamic>>();
      print(stringList);

      
      dropDownList= stringList;
    } else {
     
      throw Exception('Failed to load news');
    }
  } catch (error) {
    throw Exception('Failed to fetch data: $error');
  }
}


//get Booked dates slots(dates)
Future<void> getDatesFromApi() async {
  final url = Uri.parse('http://192.168.1.27:8000/apiviewbookeddate');
  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      
      List<dynamic> responseData = json.decode(response.body);
      print(responseData);
     
      List<String> stringList = json.decode(response.body).cast<String>();
      print(stringList);
      
      
      dateList= stringList;
    } else {
      throw Exception('Failed to load news');
    }
  } catch (error) {
    throw Exception('Failed to fetch data: $error');
  }
}
