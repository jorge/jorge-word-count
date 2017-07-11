JorgeWordCountView = require './jorge-word-count-view'
{CompositeDisposable} = require 'atom'

module.exports = JorgeWordCount =
  jorgeWordCountView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @jorgeWordCountView = new JorgeWordCountView(state.jorgeWordCountViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @jorgeWordCountView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'jorge-word-count:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @jorgeWordCountView.destroy()

  serialize: ->
    jorgeWordCountViewState: @jorgeWordCountView.serialize()

  toggle: ->
    console.log 'JorgeWordCount was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      editor = atom.workspace.getActiveTextEditor()
      words = editor.getText().split(/\s+/).length
      console.log words
      @jorgeWordCountView.setCount(words)
      @modalPanel.show()
