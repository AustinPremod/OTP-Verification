# README

Objective
Create HTTP API endpoints to generate and verify phone numbers using OTPs. You can use
a framework like Rails, Sinatra, Django or Flask.

The API<br />
Implement a backend web application that provides two API endpoints to verify a phone
number using OTP and enters that phone number into a User table if the phone number is
verified.<br /><br />
1.Generates a 4 digit OTP that is valid for 30
minutes. For this assignment, you don't have to send OTP on an SMS, you can just
print it in logs. A user can request an OTP at most 10 times a day.<br /><br />

2.Client sends the OTP received and the phone
number on which it was received. If the OTP is valid, return success and create a
User record with that particular phone number. If not, return an error saying invalid
OTP. A user should not be allowed to send more than 3 invalid OTPs in a row. If so,
return an error saying maximum verification attempts exceeded. The user has to
generate a new OTP to verify the phone number again in that case. Come up with
appropriate success and error response structures.<br /><br />

Output<br />
1. Generate OTP endpoint<br />
POST  /api/v1/authentication/generateotps<br /><br />

Request Body<br />
◉ The phone number should NOT have any special characters, space in between digits and symbols eg: +,-,(),-,_<br />
◉ Phone Number should not start with a 0<br />
◉ Only 10 digit Phone Number's are valid<br />
◉ phonenumber is stored as a string value<br /><br />

{
  "phonenumber":"6196282446"
}
<br /><br />
Response<br />
◉ status -if success will be 200 <br />
◉ message -detailed description of the response<br />
◉ otp_code -4 digit random number<br /><br />
{
    "status": "200",
    "message": "Success",
    "otp_code": "1270"
}
<br /><br />
2. Validate OTP endpoint<br />
POST /api/v1/authentication/verifyotps<br /><br />

Request Body<br />
◉ otp- 4 digit number that you got from the Generate OTP response<br />
◉ otp- is stored as string<br />
◉ phonenum- same number you gave to Generate OTP request<br /><br />

{
    "otp":"1270",
    "phonenum":"6196282446"
}
<br /><br />
Response<br />
◉ status -if success will be 200 <br />
◉ message -detailed description of the response<br />
<br /><br />
{
    "status": "200",
    "message": "OTP is verified successfully"
}
<br /><br />
*********To view the data which was inserted in the table***********
<br /><br />
GET /api/v1/authentication/verifyotps<br /><br />

Response<br />
◉ status -if success will be 200 <br />
◉ message -detailed description of the response<br />
◉ data-The number which was inserted successfully<br /><br />
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
<br /><br />
Gem File<br />
ruby "3.0.3"<br />
gem "rails", "~> 7.0.3", ">= 7.0.3.1"<br />
gem "sqlite3", "~> 1.4"<br />
gem "faker"
<br /><br />

* ...
