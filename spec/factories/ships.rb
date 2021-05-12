FactoryBot.define do
  factory :ship do
    is_sunk { false }
    life_points { 3 }
    ship_type { "cruiser" }
    coordinates { "A1, A2, A3" }
    player_id { "player" }
    session_id { "game_uuid" }
  end

  factory :carrier, class: 'Ship' do
    is_sunk { false }
    life_points { 5 }
    ship_type { "carrier" }
    coordinates { "B1, B2, B3, B4, B5" }
    player_id { "player" }
    session_id { "game_uuid" }
  end

  factory :battleship, class: 'Ship' do
    is_sunk { false }
    life_points { 4 }
    ship_type { "battleship" }
    coordinates { "C1, C2, C3, C4" }
    player_id { "player" }
    session_id { "game_uuid" }
  end

  factory :submarine, class: 'Ship' do
    is_sunk { false }
    life_points { 3 }
    ship_type { "submarine" }
    coordinates { "D1, D2, D3" }
    player_id { "player" }
    session_id { "game_uuid" }
  end

  factory :destroyer, class: 'Ship' do
    is_sunk { false }
    life_points { 2 }
    ship_type { "destroyer" }
    coordinates { "E1, E2" }
    player_id { "player" }
    session_id { "game_uuid" }
  end

  factory :ship_one_left, class: 'Ship' do
    is_sunk { false }
    life_points { 1 }
    ship_type { "cruiser" }
    coordinates { "A1, A2, A3" }
    player_id { "player" }
    session_id { "game_uuid" }
  end

  factory :carrier_sunk, class: 'Ship' do
    is_sunk { true }
    life_points { 0 }
    ship_type { "carrier" }
    coordinates { "B1, B2, B3, B4, B5" }
    player_id { "player" }
    session_id { "game_uuid" }
  end

  factory :battleship_sunk, class: 'Ship' do
    is_sunk { true }
    life_points { 0 }
    ship_type { "battleship" }
    coordinates { "C1, C2, C3, C4" }
    player_id { "player" }
    session_id { "game_uuid" }
  end

  factory :submarine_sunk, class: 'Ship' do
    is_sunk { true }
    life_points { 0 }
    ship_type { "submarine" }
    coordinates { "D1, D2, D3" }
    player_id { "player" }
    session_id { "game_uuid" }
  end

  factory :destroyer_sunk, class: 'Ship' do
    is_sunk { true }
    life_points { 0 }
    ship_type { "destroyer" }
    coordinates { "E1, E2" }
    player_id { "player" }
    session_id { "game_uuid" }
  end
end
