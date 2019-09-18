$(document).ready ->
  if $('#messages').hasClass("active")
    App.answers = App.cable.subscriptions.create "AnswersChannel",
      connected: ->
        # Called when the subscription is ready for use on the server
        return $('#messages').append("<p class=\"text-success\">Listening to chanel 'Answers'...</p>");

      disconnected: ->
        # Called when the subscription has been terminated by the server

      received: (data) ->
        # Called when there's incoming data on the websocket for this channel
        return $('#messages').append(
          $("<div class=\"ease\"><p>Answer: <b>" + data.user + "</b> " + data.message + "</p> <pre>" + data.answer + "</pre></div><hr>").hide().fadeIn(800)
          );
  else
