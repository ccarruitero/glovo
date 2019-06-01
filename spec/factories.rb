# frozen_string_literal: true

FactoryBot.define do
  factory :invalid_params do
    {
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
  end
end
