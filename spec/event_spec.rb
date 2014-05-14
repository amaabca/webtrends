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

      it 'merges tags and options' do
        RestClient.stub(:post).and_return(successful_response)
        subject.tags = {'dcsuri' => '/waffles'}
        expect(RestClient).to receive(:post).with(subject.send(:endpoint), subject.tags.merge(subject.send(:options)))
        response = subject.track
      end
    end

    context 'unsuccessful response' do
      it 'triggers an exception' do
        RestClient.stub(:post).and_raise(RestClient::BadRequest.new)
        subject.tags = {'WT.ti' => 'waffles'}
        expect { subject.track }.to raise_error(Webtrends::Exception)
      end

      it 'does not call webtrends if tags is empty' do
        expect(RestClient).to_not receive(:post)
        response = subject.track
      end

      it 'does not call webtrends if tags is nil' do
        subject.tags = nil
        expect(RestClient).to_not receive(:post)
        response = subject.track
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

      let(:subject) { Webtrends::Event.new(custom_configuration) }
      it 'does not use default configuration' do
        expect(subject.customer_id).to_not eq(default_configuration.customer_id)
        expect(subject.verbose).to_not eq(default_configuration.verbose)
        expect(subject.format).to_not eq(default_configuration.format)
      end
    end
  end
end