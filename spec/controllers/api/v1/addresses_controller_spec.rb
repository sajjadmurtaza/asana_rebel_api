require "spec_helper"
require "rails_helper"
require 'jwt'
require 'byebug'

describe 'POST /authenticate', type: :request do
  let(:user) { 'admin' }
  let(:url)  { '/authenticate' }

  context 'when params are correct' do
    before do
      post url, headers: {username: user}
    end

    it 'returns 200' do
      expect(response).to have_http_status(200)
    end

    it 'check JTW token is present' do
      expect(response.body['token']).to be_present
    end
  end

  context 'when params are incorrect' do
    before { post url }

    it 'returns unathorized status without username' do
      expect(response.status).to eq 401
    end

    it 'returns unathorized status with wrong username' do
      post url, headers: {username: 'another_user'}
      expect(response.status).to eq 401
    end
  end

end