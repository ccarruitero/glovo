# frozen_string_literal: true

RSpec.describe Glovo::Client do
  let(:cli) { described_class.new }
  let(:invalid_params) { FactoryBot.build(:invalid_params) }

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
end
