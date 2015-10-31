
class Player

  VERSION = "Tricky"

  def bet_request(game_state)
    hole_cards = me(game_state)['hole_cards']
    number_of_active_players = game_state['players'].count { |player| player['status'] != 'out' }

    if pocket_pairs?(hole_cards) and high_cards(hole_cards)
      10000
    elsif suited_high?(hole_cards)
      if game_state['bet_index'].to_i >= number_of_active_players and game_state['pot'].to_i < 200
        10000
      else
        call(game_state)
      end
    elsif pocket_pairs?(hole_cards) and hole_cards[0]['rank'].to_i > 6
      call(game_state)
    elsif number_of_active_players > 2
      (game_state['current_buy_in'] < 200) ? minimum_raise(game_state) : 0
    elsif high_cards(hole_cards)
      10000
    elsif me(game_state)['stack'].to_i < 333 and [*0..10].sample == 10
      10000
    elsif me(game_state)['stack'].to_i < 150
      10000
    else
      (game_state['current_buy_in'] < 200) ? minimum_raise(game_state) : 0
    end
  end

  def call(game_state)
    game_state['current_buy_in'] - me(game_state)['bet']
  end

  def me(game_state)
    game_state['players'][game_state['in_action']]
  end

  def random_raise(game_state)
    min_raise = minimum_raise(game_state)
    max_raise = [min_raise, me(game_state)['stack']].max + 1
    [*min_raise..max_raise].sample
  end

  def minimum_raise(game_state)
    game_state['current_buy_in'] - me(game_state)['bet'] + game_state['minimum_raise']
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
