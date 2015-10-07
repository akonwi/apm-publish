{BufferedProcess} = require 'atom'
notifier = require('atom-notify')('Apm Publish')
OutputView = require './output-view'
InputView = require './input-view'

dir = atom.project.getRepositories()[0]?.getWorkingDirectory() or atom.project.getPath()

module.exports =
  activate: ->
    atom.commands.add 'atom-workspace', 'apm-publish:version', => @showInput()
    atom.commands.add 'atom-workspace', 'apm-publish:major', => @publish 'major'
    atom.commands.add 'atom-workspace', 'apm-publish:minor', => @publish 'minor'
    atom.commands.add 'atom-workspace', 'apm-publish:patch', => @publish 'patch'

  publish: (version) ->
    message = notifier.addInfo "Publishing...", dismissable: true
    view = new OutputView
    new BufferedProcess
      command: atom.packages.getApmPath()
      args: ['publish', '--no-color', version]
      options:
        cwd: dir
      stdout: (data) ->
        view.addLine data.toString()
      stderr: (data) ->
        view.addLine data.toString()
      exit: (code) ->
        message.dismiss()
        view.finish()

  showInput: -> new InputView(@publish)
