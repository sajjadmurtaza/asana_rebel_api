# Asana Rebel Api

It's a simple web server application in Ruby that receives an address as a string, and outputs the longitude and latitude of the
aforementioned address via HTTP.

### Key files

    
    app
    ├── controller
    │      ├── api                             
    │      │     └── v1                        
    │      │         └── addresses_controller  
    │      │
    │      ├── application_controller
    │      └── authentication_controller
    │
    ├── models                    
    │      └── address
    ├── lib
    │      └── json_web_token
    ├── spec
    │      ├── contriller 
    │      │     └── api               
    │      │          └── v1                        
    │      │               └── addresses_controller_spec
    │      │
    │      └── models
    │             └── addresses_spec
    ├── .env   
    │  
    └── 

### Workflow - How does it work?

The following diagram show the process/workflow of the application.


    Postman/ Browser                            Server
 
    │    1. POST/authenticate with username       │ 
    ├────────────────────────────────────────────>│     
    │                                             ├ 2. Create Token                          
    │    3. Return Token with expiration date     │               
    │<────────────────────────────────────────────│
    │                                             │
    │    4. Send token on Authorization Header    │
    ├────────────────────────────────────────────>│ 
    │                                             ├ 5. Verify Token and return coordinates of the address      
    │    6. Send response to client               │ 
    │<────────────────────────────────────────────│

***
**Setup**

* first clone the directory 
                      ```
                      git clone git@github.com:sajjadmurtaza/asana_rebel_api.git'
                      ```
 *  ```cd asana_rebel_api```
 *  ```bundle install ```
 *  ```rails s ```
 
 Then open Postman or any API Testing Tool to connect with server
 
 * Enter url ```http://localhost:3000/authenticate``` and set Header, ```username=admin```. 
   * I set username so that no one can publicly access the end point. Better way was to create the User in data and send username and password.
   * For simplicity, I used the ```gem "dotenv-rails"``` to set environment variable where i set ```username: admin``` in ```.env``` file.
   * For now i am not putting ```.env``` file into ```.gitignore``` so that you can do test.
 * If username will be correct then you will get TOKEN as a output. 
 
 ```
 {
     "token": "eyJhbGciOiJIUzI1NiJ9.ImFkbWluIg.8eM8-fE4dpVz5vYvDipBaDX7uZLEWDSv-WUMNAN4AK8",
     "exp": "05-31-2019 18:18"
 }
 ```
 
![alt text](https://raw.githubusercontent.com/sajjadmurtaza/asana_rebel_api/master/public/authentication.png "api Screenshot")

 * If authentication fails then you will receive and error message.
 
![alt text](https://raw.githubusercontent.com/sajjadmurtaza/asana_rebel_api/master/public/fail.png "api Screenshot")

***

* On successful, you will get a token that will very similar to ```"eyJhbGciOiJIUzI1NiJ9.ImFkbWluIg.8eM8-fE4dpVz5vYvDipBaDX7uZLEWDSv-WUMNAN4AK8"```
  * Token have 3 parts(separated by . (dot))
    * Header
    * Payload
    * Signature
  * If anything will changed then token will not work
* Next step is to get Address Coordinate, Enter URL 
    * ```http://localhost:3000/api/v1/addresses```
      * make you entered correct url with ```/api/v1```
    * set Headers
      * ```Authorization = "TOKEN THAT YOU GOT IN PREVIOUS REQUEST"```
      * ```address = "any valid address e.g. alexanderplatz"```
* If request is fine then you will get response in ```JSON``` format which include
    * Coordinates in a array ```[]``` # latitude and longitude
      * e.g. ```[52.52194065, 13.4134889978456]```
      * Here ```52.52194065``` is latitude of the address and ```13.4134889978456``` is longitude
      
```     
 {
     "coordinates": [
         52.52194065,
         13.4134889978456
     ],
     "address": "Alexanderplatz, Spandauer Vorstadt, Mitte, Berlin, 10178, Germany",
     "status": "ok"
 }
```
  
![alt text](https://raw.githubusercontent.com/sajjadmurtaza/asana_rebel_api/master/public/api.png "api Screenshot")

### Specs

run ``` bundle exe rspec   ``` to run the tests

#### Note

* [JWT](https://github.com/jwt/ruby-jwt) - JWT tokens for authentication.
* [geocoder](http://www.rubygeocoder.com/) - geocoding library for Ruby.
* [dotenv-rails](https://github.com/bkeepers/dotenv) - use to load environment variables from .env file
* [rspec-rails](https://github.com/rspec/rspec-rails) - testing framework
* [byebug](https://github.com/deivid-rodriguez/byebug) -  debugger for Ruby