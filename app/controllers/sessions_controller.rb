class SessionsController < ApplicationController

    def new
    end

    def create
        @user = User.find_by({ "email" => params["email"] })
        if @user
            if BCrypt::Password.new(@user["password"]) == params["password"]
                session["user_id"] = @user["id"]
                flash["notice"] = "You're in!"
                redirect_to "/" 
            else
                flash["notice"] = "Incorrect credentials!"
                redirect_to "/login"     
            end 
        else
            flash["notice"] = "Incorrect credentials!"
            redirect_to "/login"
        end
    end

    def destroy
        flash["notice"] = "You are logged out"
        session["user_id"] = nil
        redirect_to "/login"
    end

end