module Api
    module V1
        module Authentication
            class VerifyotpsController < ApplicationController
                def index
                    phones=Usernumber.order('created_at DESC');
                    render json: {status: '200',message:'Success',data:phones},status: :ok
                end
                def create
                    requestCall= Otpverify.new(otpverify_params)
                    requestCall.save
                    otpReq=requestCall.otp
                    phonenumber=requestCall.phonenum

                    user = Usernumber.find_by(phone: phonenumber)
                    if user!=nil
                        if user.otp == otpReq
                            render json:{status: '200',message:'Success',otp_code:user},status: :ok
                        else
                            user.otpcounter=user.otpcounter.to_i + 1;
                            user.save
                            if(user.otpcounter.to_i>3)
                                render json:{status: '500',message:'maximum verification attempts exceeded',otp_code:user},status: :ok
                            else
                                render json:{status: '500',message:'Invalid OTP',otp_code:user},status: :ok
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