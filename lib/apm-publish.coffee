{BufferedProcess} = require 'atom'
OutputView = require './output-view'

module.exports =
  activate: (state) ->
    atom.workspaceView.command 'apm-publish:major', => @publish('major')
    atom.workspaceView.command 'apm-publish:minor', => @publish('minor')
    atom.workspaceView.command 'apm-publish:patch', => @publish('patch')

  publish: (version) ->
    dir = atom.project.getRepo().getWorkingDirectory()
    view = new OutputView
    new BufferedProcess
      command: 'apm'
      args: ['publish', version]
      options:
        cwd: dir
      stdout: (data) ->
        view.addLine data.toString()
      stderr: (data) ->
        view.addLine data.toString()
      exit: (code) ->
        view.finish()

  deactivate: ->

  serialize: ->
