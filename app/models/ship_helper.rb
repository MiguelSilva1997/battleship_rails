module ShipHelper
    SHIP_TYPES = {
        "carrier" => 5,
        "battleship" => 4,
        "cruiser" => 3,
        "submarine" => 3,
        "destroyer" => 2,
    }

    def coord_validation(coordinates, all_coords)
        valid_letters = ("A".."J").to_a
        valid_nums = ("0".."9").to_a
        coordinates.each do |coord|
            letter, number = coord[0], coord[1]
            if all_coords.include?(coord) || !valid_letters.include?(letter) || !valid_nums.include?(number)
                return false
            end
        end
        return true
    end

    def format_return(game, phase_change, ship_created)
        if ship_created and phase_change
            return {"phase" => game.phase, "player" => game.player_one}
        end
        return {"phase" => game.phase, "next_player" => game.next_player, "placed" => ship_created}
    end

    def get_all_coords(all_ships)
        return all_ships.map { |ship| ship.coordinates.split(", ") }.flatten
    end

    def get_life_points(ship)
        return SHIP_TYPES[ship]
    end

    def get_horizontal(coordinate, ship_type)
        coordinates = [coordinate]
        letter = coordinate[0]
        
        (SHIP_TYPES[ship_type] - 1).times do
            letter = letter.next
            coordinates.push(letter + coordinate[1])
        end
        coordinates
    end

    def get_vertical(coordinate, ship_type)
        coordinates = [coordinate]
        number = coordinates[1].to_i
        
        (SHIP_TYPES[ship_type] - 1).times do
            number = number + 1
            coordinates.push(coordinates[0] + number.to_s)
        end
        coordinates
    end

    def validate_coordinates(coordinate, direction, ship_type, all_coords)
        if direction == "down"
            coordinates = get_vertical(coordinate, ship_type)
        else
            coordinates = get_horizontal(coordinate, ship_type)
        end

        is_valid = coord_validation(coordinates, all_coords)

        return [is_valid, coordinates]
    end
end
