{ScrollView} = require 'atom'

module.exports =
class OutputView extends ScrollView
  @content: ->
    @div class: 'apm-publish info-view', =>
      @pre class: 'output'

  initialize: ->
    super
    @message = ''
    atom.workspaceView.appendToBottom(this)

  addLine: (line) ->
    @message += line

  finish: ->
    @find(".output").append(@message)
    setTimeout =>
      @detach()
    , 10000
