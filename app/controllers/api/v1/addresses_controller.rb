class Api::V1::AddressesController < ApplicationController

  def index

    request.headers[:address] ?
      (render json: Address.details(request.headers[:address]))
    :
      (render json: { errors: 'Your header must contain address.' }, status: :not_acceptable)

  end

end