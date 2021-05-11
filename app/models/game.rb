class Game < ApplicationRecord
    self.primary_key = 'session_id'
    before_create :change_players_id, :add_uuid_to_session_id

    enum phase: %i[setup play game_over]

    private
      def change_players_id
        self.player_one = "#{self.player_one}##{SecureRandom.uuid}"
        self.player_two = "#{self.player_two}##{SecureRandom.uuid}"
      end

      def add_uuid_to_session_id
        if self.session_id.nil?
            self.session_id = SecureRandom.uuid
        end
      end
end
