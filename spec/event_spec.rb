describe Webtrends::Event do

  let(:successful_response) do
     OpenStruct.new({response: File.read(File.join('spec', 'fixtures', 'success.xml')), code: 200})
  end
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
        subject.tags = {'dcsuri' => '/waffles'}
        response = subject.track
        expect(response.code).to eq(200)
      end

      it 'should merge tags and options' do
        RestClient.stub(:post).and_return(successful_response)
        subject.tags = {'dcsuri' => '/waffles'}
        expect(RestClient).to receive(:post).with(subject.send(:endpoint), subject.tags.merge(subject.send(:options)))
        response = subject.track
      end
    end

    context 'unsuccessful response' do
      it 'should trigger an exception' do
        RestClient.stub(:post).and_raise(RestClient::BadRequest.new '400 Bad Request')
        subject.tags = {'WT.ti' => 'waffles'}
        begin
          response = subject.track
        rescue Exception => e
          expect(e).to be_kind_of(RestClient::BadRequest)
        end
        expect(response).to be_nil
      end

      it 'should not call webtrends if tags is empty' do
        expect(RestClient).to_not receive(:post)
        response = subject.track
      end
    end
  end

  describe '#initialize' do
    context 'not passing default configuraiton' do
      it 'uses default config attributes' do
        expect(subject.customer_id).to eq(default_configuration.customer_id)
        expect(subject.verbose).to eq(default_configuration.verbose)
        expect(subject.format).to eq(default_configuration.format)
      end
    end

    context 'passing default configuraiton' do
      let(:custom_configuration) do
        OpenStruct.new(
        customer_id: 'somedifferent',
        verbose: true,
        format: 'plain')
      end

      let(:subject) { Webtrends::Event.new(custom_configuration.to_h) }
      it 'does not uses default config attributes' do
        expect(subject.customer_id).to_not eq(default_configuration.customer_id)
        expect(subject.verbose).to_not eq(default_configuration.verbose)
        expect(subject.format).to_not eq(default_configuration.format)
      end
    end
  end
end