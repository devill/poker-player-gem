
class Player

  VERSION = "High card strategy"

  def bet_request(game_state)
    hole_cards = game_state['players'][game_state['in_action']]['hole_cards']
    number_of_active_players = game_state['players'].count { |player| player['status'] != 'out' }

    if high?(hole_cards[0]) and high?(hole_cards[1])
      10000
    elsif high?(hole_cards[0]) or high?(hole_cards[1])
      200
    elsif number_of_active_players < 3
      200
    else
      0
    end
  end

  def high?(card)
    ['J','Q','K','A'].include? card['rank']
  end

  def showdown(game_state)

  end
end
