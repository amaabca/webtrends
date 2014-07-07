describe Webtrends::Visitor do
  let(:successful_response) { OpenStruct.new({response: '10.62.80.61-2450180400.29991975', code: 200}) }
  let(:default_configuration) do
    OpenStruct.new(
      customer_id: 'whereevermd',
      verbose: false,
      format: 'xml')
  end

  before(:each) do
    Webtrends.configure do |c|
      c.customer_id = default_configuration.customer_id
    end
  end

  describe '#track' do
    context 'successful response' do
      it 'returns success code' do
        RestClient.stub(:post).and_return(successful_response)
        response = subject.track
        expect(response.code).to eq(200)
      end

      it 'returns a valid id' do
        RestClient.stub(:post).and_return(successful_response)
        response = subject.track
        expect(response.response).to eq('10.62.80.61-2450180400.29991975')
      end
    end

    context 'unsuccessful response' do
      it 'triggers an exception' do
        RestClient.stub(:post).and_raise(RestClient::BadRequest.new '400 Bad Request')
        begin
          response = subject.track
        rescue Exception => e
          expect(e).to be_kind_of(RestClient::BadRequest)
        end
        expect(response).to be_nil
      end
    end
  end

  describe '.initialize' do
    context 'not passing custom configuration' do
      it 'uses default configuration' do
        expect(subject.customer_id).to eq(default_configuration.customer_id)
        expect(subject.verbose).to eq(default_configuration.verbose)
        expect(subject.format).to eq(default_configuration.format)
      end
    end

    context 'passing custom configuration' do
      let(:custom_configuration) do
        { customer_id: 'somedifferent', verbose: true, format: 'plain' }
      end

      let(:subject) { Webtrends::Visitor.new(custom_configuration) }
      it 'does not use default configuration' do
        expect(subject.customer_id).to_not eq(default_configuration.customer_id)
        expect(subject.verbose).to_not eq(default_configuration.verbose)
        expect(subject.format).to_not eq(default_configuration.format)
      end
    end
  end
end