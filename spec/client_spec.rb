# frozen_string_literal: true

invalid_params =  {
  'scheduleTime': '12344566',
  'description': 'A 30cm by 30cm box',
  'addresses': [
    {
      'type': 'PICKUP',
      'lat': 0.1,
      'lon': 0.3,
      'label': 'Calle la X, 29'
    },
    {
      'type': 'DELIVERY',
      'lat': 0.15,
      'lon': 0.3,
      'label': 'Calle la X, 30'
    }
  ]
}

RSpec.describe Glovo::Client do
  let(:cli) { described_class.new }

  before do
    Glovo.configure do |c|
      c.api_key = '1212'
      c.api_secret = '1212'
      c.env = 'test'
    end
  end

  it 'is not broken' do
    expect(cli).not_to be nil
  end

  it '#estimate_cost with invalid params' do
    expect(cli.estimate_cost(invalid_params)).to eq(
      Glovo::ResponseError.new(400)
    )
  end

  xit '#estimate_cost with valid params' do
  end
end
