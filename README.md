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
 * If username will be correct then you will get TOKEN as a output. If authentication fails then you will receive and error message.
 
 
![alt text](https://raw.githubusercontent.com/sajjadmurtaza49/asana_rebel_api/master/app/public/authentication.png "api Screenshot")