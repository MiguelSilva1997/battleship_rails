FactoryBot.define do
  factory :turn do
    is_hit { false}
    coordinate { "J9"}
    message { "miss" }
    player_id { "" }
    session_id { "" }
  end
end
