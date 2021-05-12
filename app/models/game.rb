class Game < ApplicationRecord
    self.primary_key = 'session_id'
    
    has_many :ships, foreign_key: 'session_id', primary_key: 'session_id'
    has_many :turns, foreign_key: 'session_id', primary_key: 'session_id'
    before_create :change_players_id, :add_uuid_to_session_id

    enum phase: %i[setup play game_over]

    def update_game_over
      enemy_id = self.next_player == self.player_one ? self.player_two : self.player_one
      if ships.where(is_sunk: false, player_id: enemy_id).empty?
        update(phase: "game_over", next_player: enemy_id)
        return self
      end
      update(next_player: enemy_id)
      return self
    end

    private
      def change_players_id
        self.player_one = "#{self.player_one}##{SecureRandom.uuid}"
        self.player_two = "#{self.player_two}##{SecureRandom.uuid}"
        self.next_player = self.player_one
      end

      def add_uuid_to_session_id
        if self.session_id.nil?
            self.session_id = SecureRandom.uuid
        end
      end
end
