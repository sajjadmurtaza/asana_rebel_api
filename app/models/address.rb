class Address
  require 'geocoder'

  def self.details(address)
    location = Geocoder.search(address).first

    location ?
        { coordinates: location.coordinates, address: location.address, status: :ok }
        :
        { error: 'Oops, something went wrong! Please double check that you entered correct address', status: :bad_request }
  end

end