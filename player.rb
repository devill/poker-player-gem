
class Player

  VERSION = "Conservative preflop"

  def bet_request(game_state)
    hole_cards = game_state['players'][game_state['in_action']]['hole_cards']
    number_of_active_players = game_state['players'].count { |player| player['status'] != 'out' }

    if pocket_aces?(hole_cards) or suited_high?(hole_cards)
      10000
    elsif number_of_active_players > 2
      0
    elsif high?(hole_cards[0]) and high?(hole_cards[1])
      10000
    else
      0
    end
  end

  def pocket_aces?(hole_cards)
    hole_cards[0]['rank'] == 'A' and hole_cards[1]['rank'] == 'A'
  end

  def suite_high?(hole_cards)
    includes_rank?(hole_cards, 'A') and includes_rank?(hole_cards, 'K') and suited?(hole_cards)
  end

  def suited?(hole_cards)
    hole_cards[0]['suit'] == hole_cards[1]['suit']
  end

  def includes_rank?(hole_cards, rank)
    hole_cards.count? { |card| card['rank'] == rank } > 0
  end

  def high?(card)
    ['J','Q','K','A'].include? card['rank']
  end

  def showdown(game_state)

  end
end
