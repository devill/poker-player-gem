
class Player

  VERSION = "Loosen up a bit Call v2"

  def bet_request(game_state)
    me = game_state['players'][game_state['in_action']]
    hole_cards = me['hole_cards']
    number_of_active_players = game_state['players'].count { |player| player['status'] != 'out' }

    if (pocket_pairs?(hole_cards) and high_cards(hole_cards)) or suited_high?(hole_cards)
      [game_state['current_buy_in'] - me['bet'] + game_state['minimum_raise'], (me['stack'] / 2).to_i].max
    elsif pocket_pairs?(hole_cards)
      game_state['current_buy_in'] - me['bet']
    elsif number_of_active_players > 2
      0
    elsif high_cards(hole_cards)
      10000
    else
      0
    end
  end

  def high_cards(hole_cards)
    high?(hole_cards[0]) and high?(hole_cards[1])
  end

  def pocket_aces?(hole_cards)
    hole_cards[0]['rank'] == 'A' and hole_cards[1]['rank'] == 'A'
  end

  def pocket_pairs?(hole_cards)
    hole_cards[0]['rank'] == hole_cards[1]['rank']
  end

  def suited_high?(hole_cards)
    includes_rank?(hole_cards, 'A') and includes_rank?(hole_cards, 'K') and suited?(hole_cards)
  end

  def suited?(hole_cards)
    hole_cards[0]['suit'] == hole_cards[1]['suit']
  end

  def includes_rank?(hole_cards, rank)
    hole_cards.count { |card| card['rank'] == rank } > 0
  end

  def high?(card)
    ['J','Q','K','A'].include? card['rank']
  end

  def showdown(game_state)

  end
end
