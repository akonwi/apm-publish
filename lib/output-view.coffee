{ScrollView} = require 'atom'

module.exports =
class OutputView extends ScrollView
  @content: ->
    @div class: 'apm-publish info-view', =>
      @pre class: 'output'

  initialize: ->
    super
    atom.workspaceView.appendToBottom(this)
    setTimeout =>
      @detach()
    , 5000

  addLine: (line) ->
    @find(".output").append(line)
