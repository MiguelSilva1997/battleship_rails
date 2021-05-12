FactoryBot.define do
  factory :game do
    session_id { "game_uuid" }
    phase { "setup" }
    player_one { "Miguel" }
    player_two { "Silva" }
    next_player { "Miguel" }
  end

  factory :play, class: 'Game' do
    session_id { "game_uuid" }
    phase { "play" }
    player_one { "Miguel" }
    player_two { "Silva" }
    next_player { "Miguel" }
  end

  factory :game_over, class: 'Game' do
    session_id { "game_uuid" }
    phase { "game_over" }
    player_one { "Miguel" }
    player_two { "Silva" }
    next_player { "Miguel" }
  end
end
