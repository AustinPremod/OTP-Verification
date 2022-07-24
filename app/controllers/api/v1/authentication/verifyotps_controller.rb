module Api
    module V1
        module Authentication
            class VerifyotpsController < ApplicationController
                def index
                    
                    phones=Userrecord.order('created_at DESC');
                    render json: {status: '200',message:'Success',data:phones},status: :ok
                end
                def create
                    requestCall= Otpverify.new(otpverify_params)
                    requestCall.save
                    otpReq=requestCall.otp
                    phonenumber=requestCall.phonenum

                    user = Usernumber.find_by(phone: phonenumber)
                    num1 = Userrecord.new
                    if user!=nil
                        if user.otp == otpReq 
                            num1.phone = user.phone
                            num1.save
                            render json:{status: '200',message:'OTP is verified successfully'},status: :ok
                        else
                            user.otpcounter=user.otpcounter.to_i + 1;
                            user.save
                            if(user.otpcounter.to_i>3)
                                render json:{status: '500',message:'maximum verification attempts exceeded'},status: :ok
                            else
                                render json:{status: '500',message:'Invalid OTP'},status: :ok
                            end
                            
                        end
                        
                    else
                        render json:{status: '500',message:'Invalid PhoneNumber',otp_code:''},status: :ok
                    end

                end
                private
                
                def otpverify_params
                    params.permit(:otp, :phonenum)
                end
            end
        end
    end
end