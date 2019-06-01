# frozen_string_literal: true

RSpec.describe Glovo do
  it 'has a version number' do
    expect(Glovo::VERSION).not_to be nil
  end

  it 'has configuration' do
    expect(Glovo.configuration).not_to be nil
  end
end
