{BufferedProcess} = require 'atom'
OutputView = require './output-view'

dir = atom.project.getRepositories()[0]?.getWorkingDirectory() or atom.project.getPath()

module.exports =
  activate: ->
    atom.commands.add 'atom-workspace', 'apm-publish:major', => @publish 'major'
    atom.commands.add 'atom-workspace', 'apm-publish:minor', => @publish 'minor'
    atom.commands.add 'atom-workspace', 'apm-publish:patch', => @publish 'patch'

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
