# README

Objective
Create HTTP API endpoints to generate and verify phone numbers using OTPs. You can use
a framework like Rails, Sinatra, Django or Flask.

The API
Implement a backend web application that provides two API endpoints to verify a phone
number using OTP and enters that phone number into a User table if the phone number is
verified.
1.Generates a 4 digit OTP that is valid for 30
minutes. For this assignment, you don't have to send OTP on an SMS, you can just
print it in logs. A user can request an OTP at most 10 times a day.

2.Client sends the OTP received and the phone
number on which it was received. If the OTP is valid, return success and create a
User record with that particular phone number. If not, return an error saying invalid
OTP. A user should not be allowed to send more than 3 invalid OTPs in a row. If so,
return an error saying maximum verification attempts exceeded. The user has to
generate a new OTP to verify the phone number again in that case. Come up with
appropriate success and error response structures.


Output
1. Generate OTP endpoint
POST  /api/v1/authentication/generateotps

Request Body
◉ The phone number should not have any special characters, symbols and space in between
◉ phonenumber is stored as a string value

{
  "phonenumber":"6196282446"
}

Response
◉ status -if success will be 200 
◉ message -describing what is happening
◉ otp_code -4 digit random number
{
    "status": "200",
    "message": "Success",
    "otp_code": "1270"
}

2. Validate OTP endpoint
POST /api/v1/authentication/verifyotps

Request Body
◉ otp- 4 digit number that you got from the Generate OTP response
◉ otp- is stored as string
◉ phonenum- same number you gave to Generate OTP request

{
    "otp":"1270",
    "phonenum":"6196282446"
}

Response
◉ status -if success will be 200 
◉ message -describing what is happening
{
    "status": "200",
    "message": "OTP is verified successfully"
}

*********To view the data which was inserted in the table***********

GET /api/v1/authentication/verifyotps

Response
◉ status -if success will be 200 
◉ message -describing what is happening
◉ data-The number which was inserted successfully
{
    "status": "200",
    "message": "Success",
    "data": [
              {
                "id": 2,
                "phone": "6196282446",
                "created_at": "2022-07-24T22:59:28.595Z",
                "updated_at": "2022-07-24T22:59:28.595Z"
               },
               {
                "id": 1,
                "phone": "7160797785",
                "created_at": "2022-07-24T22:51:13.837Z",
                "updated_at": "2022-07-24T22:51:13.837Z"
               }
            ]
}

* ...
