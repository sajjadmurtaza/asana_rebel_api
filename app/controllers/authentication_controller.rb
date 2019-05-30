class AuthenticationController < ApplicationController
  skip_before_action :authorize_request

  def authenticate
    if request.headers[:username] == ENV['username']

      token = JsonWebToken.encode(ENV['username'])
      time  = Time.now + 24.hours.to_i

      render json: { token: token, exp: time.strftime("%m-%d-%Y %H:%M") }, status: 200
    else
      render json: { errors: 'Unauthorized user! Please contact to Admin' }, status: 401
    end

  end

end