postsChannelFunctions = () ->

  checkMe = (comment_id) ->
    if $('meta[name=wizardwonka]').length < 1
      $(".comment[data-id=#{comment_id}] .control-panel").remove()
  #end

  createComment = (data) ->
    console.log(data)
    if $('.comment-container').data().id == data.post.id
      $('.comment-parent').append(data.partial)
      checkMe(data.comment.id)

  updateComment = (data) ->
    console.log(data)
    if $('.comment-container').data().id == data.post.id
      $(".comment[data-id=#{data.comment.id}]").replaceWith(data.partial)
      checkMe(data.comment.id)

  destroyComment = (data) ->
    console.log(data)
    if $('.comment-container').data().id == data.post.id
      $(".comment[data-id=#{data.comment.id}]").remove()

  if $('.comment-container').length > 0
    App.posts_channel = App.cable.subscriptions.create {
        channel: "PostsChannel"
    },
    connected: () ->
    #end

    disconnected: () ->
    #end

    received: (data) ->
      console.log(data.type)
      switch data.type
        when "create" then createComment(data)
        when "update" then updateComment(data)
        when "destroy" then destroyComment(data)

      #end
    #end
  #end
#end
$(document).on 'turbolinks:load', postsChannelFunctions
