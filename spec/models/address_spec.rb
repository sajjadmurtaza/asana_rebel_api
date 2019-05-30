require "spec_helper"
require "rails_helper"
require 'jwt'

describe Address do

  context 'when address is correct' do
    subject { Address.details('alexanderplatz') }

    it 'return alexanderplatz correct coordinates e.g longitude and latitude' do
      expect(subject[:coordinates]).to eq [52.52194065, 13.4134889978456]
      end

    it 'check result has a address' do
      expect(subject[:address]).to be_present
    end

    it 'return ok status' do
      expect(subject[:status]).to eq :ok
    end

  end

  context 'when address is wrong or empty' do
    subject { Address.details('wrongAddress') }

    it 'return bad request as status' do
      expect(subject[:status]).to eq :bad_request
    end

    it 'return error message' do
      expect(subject[:error]).to eq 'Oops, something went wrong! Please double check that you entered correct address'
    end

  end
end