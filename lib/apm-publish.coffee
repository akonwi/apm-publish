{BufferedProcess} = require 'atom'
OutputView = require './output-view'

dir = atom.project.getRepo()?.getWorkingDirectory() or atom.project.getPath()

module.exports =
  activate: ->
    atom.workspaceView.command 'apm-publish:major', => @publish('major')
    atom.workspaceView.command 'apm-publish:minor', => @publish('minor')
    atom.workspaceView.command 'apm-publish:patch', => @publish('patch')

  publish: (version) ->
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
