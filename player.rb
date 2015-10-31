
class Player

  VERSION = "All in strategy"

  def bet_request(game_state)
    hole_cards = game_state['players'][game_state['in_action']]['hole_cards']
    if hole_cards[0]['rank'] == 'A' and hole_cards[1]['rank'] == 'A'
      10000
    else
      1000
    end
  end

  def showdown(game_state)

  end
end
