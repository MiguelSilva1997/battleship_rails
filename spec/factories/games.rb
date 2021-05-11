FactoryBot.define do
  factory :game do
    session_id { "game_uuid" }
    phase { "setup" }
    player_one { "Miguel" }
    player_two { "Silva" }
    next_player { "Miguel" }
  end
end
