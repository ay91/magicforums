votesChannelFunctions = () ->

  if $('.comment-container').length > 0
    App.votes_channel = App.cable.subscriptions.create {
      channel: "VotesChannel"
    },
    connected: () ->
    disconnected: () ->
    received: (data) ->
      $(".comment[data-id=#{data.comment_id}] .comment-total-votes").html(data.value)

$(document).on 'turbolinks:load', votesChannelFunctions
