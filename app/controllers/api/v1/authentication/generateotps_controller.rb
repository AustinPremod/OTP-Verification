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
                    number=strNumber.to_i
                    counter=Usernumber.count(:id);
                    

                    code =4.times.map{rand(9)}.join;
                    flag=0;
                    i=1
                    while counter>=i
                        num=Usernumber.find(i);
                        phoneData=num.phone;
                        
                        if phoneData.to_i == number
                            no=num.counter.to_i + 1;
                            num.counter=no.to_s;
                            num.otpcounter="1"
                            num.otp=code.to_s;
                            num.save; 
                            flag=1;
                            break
                        end
                        i=i+1;
                    end
                    
                        if i==counter+1 && number.to_s.length == strNumber.length && flag==0
                            num1 = Usernumber.new
                            num1.phone = number.to_s
                            num1.counter = "1"
                            num1.otpcounter="1"
                            num1.otp=code.to_s
                            num1.save
                        end

                    user = Usernumber.find_by(phone: number)
                    if number.to_s.length == strNumber.length 
                        if user.created_at <= 1.day.ago;
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