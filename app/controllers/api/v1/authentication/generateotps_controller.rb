module Api
    module V1
        module Authentication
            class GenerateotpsController< ApplicationController
                def index
                    phones=Usernumber.order('created_at DESC');
                    render json: {status: '200',message:'Success',data:phones},status: :ok
                end
      
                def create
                    
                    requestCall= Otprequest.new(otprequest_params)
                    requestCall.save
                    strNumber=requestCall.phonenumber
                    #strNumber=request.raw_post;
                    number=strNumber.to_i.abs

                    #counter=Usernumber.count(:id);
                    user = Usernumber.find_by(phone: number)
                    code =4.times.map{rand(9)}.join;

                 
                    if  user!=nil && number!=nil && user.phone.to_i == number
                        if  user.counter.to_i<=10 
                            no=user.counter.to_i + 1;
                            user.counter=no.to_s;
                            user.otpcounter="1"
                            user.otp=code.to_s;
                            user.save; 
                        end
                                
                    elsif strNumber!=nil && number!=nil && number.to_s.length == strNumber.length && number.to_s.length==10
                        num1 = Usernumber.new
                        num1.phone = number.to_s
                        num1.counter = "1"
                        num1.otpcounter="1"
                        num1.otp=code.to_s
                        num1.save

                    end
                    user = Usernumber.find_by(phone: number)
                    if strNumber!=nil && number!=nil && number.to_s.length == strNumber.length && number.to_s.length==10
                        if user.created_at < 1.day.ago;
                            user.created_at=Time.now;
                            user.counter='1';
                        end
                        if  user.counter.to_i<=10 
                            render json:{status: '200',message:'Success',otp_code:code},status: :ok
                        else
                            render json:{status: '500',message:'OTP request limit reached. Try again in 24 hours.',otp_code:''},status: :ok
                        end
                        
                    else
                    code=4.times.map{rand(10)}.join
                    render json:{status: '500',message:'PhoneNumber is Invalid.',otp_code:''},status: :ok
                    end
                
                end
                private
                def otprequest_params
                    params.permit(:phonenumber)
                end
            end
        end
    end
end