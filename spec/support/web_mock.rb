require 'webmock/rspec'

WebMock.disable_net_connect!(allow_localhost: true)
RSpec.describe 'API Request' do
    it 'returns stubbed response' do
        stub_request(:get, 'http://localhost:3000/').to_return(status: 200, body: 'Hello, World!')

        response = Net::HTTP.get('localhost', '/', 3000)
        expect(response).to eq('Hello, World!')
    end
end
