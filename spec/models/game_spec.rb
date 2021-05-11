require 'rails_helper'

RSpec.describe Game, type: :model do
  describe "Game Validations" do
    it { should have_many(:ships).class_name('Ship')}
    it { should define_enum_for(:phase).with(%i[setup play game_over]) }
  end
end
