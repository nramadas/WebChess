this.Player = (() ->
  Canvas = (element, game_id, player) ->
    that = this

    this.element = element
    this.game_id = game_id
    this.player = player
    this.board = null

    this.printBoard = () ->
      that.update(that.render)

    this.update = (callback) ->
      $.getJSON(
        "/games/" + that.game_id + ".json",
        (data) ->
          that.board = data

          console.log(data)

          callback() if callback
      )

    this.render = () ->
      for i in [0...64] by 1
        p = null

        if that.board.pieces[i]
          p = $("<div class='square'>" + that.board.pieces[i] + "</div>")
          p.addClass("piece")
        else
          p = $("<div class='square'></div>")
      
        p.addClass("dark") if (i % 2 == 0 && i % 16 < 8)
        p.addClass("dark") if (i % 2 == 1 && i % 16 > 8)

        that.element.append(p)


    return

  return {
    Canvas: Canvas
  }
)()