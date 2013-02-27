this.Player = (() ->
  Piece = (element, game_id, refresh, callback) ->
    that = this

    this.element = element

    this.element.click(() ->
      source = that.element.data('square')

      $(".piece").not(that.element).removeClass("piece")
      destinations = $(".square").not(".piece")
      destinations.addClass("destination")

      that.element.unbind("click")
      that.element.click(() ->
        refresh()
      )

      destinations.click(() ->
        instruction = source + " " + $(this).data('square')

        $(destinations).unbind("click")
        $(destinations).removeClass("destination")
        $.ajax({
          url: "/games/" + game_id,
          type: "PUT",
          data: "instruction=" + instruction + "&id=" + game_id,
          statusCode: {
            200: () -> # move successful
              callback()

            405: (data) -> # move not allowed
              console.log(data.responseText)
              refresh(data.responseText)

          }
        })
      )
    )

    return


  Canvas = (element, game_id, player) ->
    that = this

    this.element = element
    this.game_id = game_id
    this.player = player
    this.board = null
    this.interval = null

    this.printBoard = () ->
      that.update(that.render)

    this.update = (callback) ->
      $.ajax({
        dataType: "json",
        url: "/games/" + that.game_id + ".json",
        statusCode: {
          200: (data) ->
            that.board = data

            callback() if callback
        }
      })

    this.render = (instruction) ->
      that.element.empty()
      that.printInstructions(instruction) if instruction

      columns = ['a','b','c','d','e','f','g','h']

      for i in [0...64] by 1
        p = null

        if that.board.pieces[i]
          p = $("<div class='square'>" + that.board.pieces[i].token + "</div>")
          p.data('player', that.board.pieces[i].player)

          if that.board.pieces[i].player == that.player
            p.addClass("piece")
            new Piece(p, that.game_id,
                         that.render,
                         that.checkForMove)

        else
          p = $("<div class='square'></div>")
      
        p.data('square', columns[i % 8] + Math.ceil((64-i)/8))

        p.addClass("dark") if (i % 2 == 0 && i % 16 < 8)
        p.addClass("dark") if (i % 2 == 1 && i % 16 > 8)

        that.element.append(p)

    this.checkForMove = () ->
      that.printBoard()
      $(".piece").unbind("click")
      $(".piece").removeClass("piece")
      that.printInstructions("Waiting on opponent...")

      t = setInterval(() ->
        $.ajax({
          dataType: "json",
          url: "/games/" + that.game_id + ".json",
          statusCode: {
            200: (data) ->
              if data.last_moved != that.player
                clearInterval(t)
                that.board = data
                that.render()
                that.printInstructions("Your turn...")

                if data.check
                  that.printInstructions("Check")

              if data.checkmate || data.forfeit
                clearInterval(t)
                that.printBoard
                $(window).off("beforeunload")
                endGameScreen = $("<div class='endGame'></div>")
                that.element.append(endGameScreen)

                if data.checkmate
                  that.printInstructions("Checkmate!")

                if data.forfeit
                  that.printInstructions(data.forfeit + " has forfeited!")
          }
        })
      , 3000)

    this.printInstructions = (instruction) ->
      $("#instructions").empty()
      $("#instructions").append(instruction)

    return

  return {
    Canvas: Canvas
  }
)()