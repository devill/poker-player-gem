
class Player

  VERSION = "Conservative preflop"

  def bet_request(game_state)
    hole_cards = game_state['players'][game_state['in_action']]['hole_cards']
    number_of_active_players = game_state['players'].count { |player| player['status'] != 'out' }

    if hole_cards[0]['rank'] == 'A' and hole_cards[1]['rank'] == 'A'
      10000
    elsif number_of_active_players > 2
      0
    elsif high?(hole_cards[0]) and high?(hole_cards[1])
      10000
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
