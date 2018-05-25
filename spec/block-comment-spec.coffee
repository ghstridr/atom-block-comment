{WorkspaceView} = require 'atom'
BlockComment = require '../lib/block-comment-ng'

# Use the command `window:run-package-specs` (cmd-alt-ctrl-p) to run specs.
#
# To run a specific `it` or `describe` block add an `f` to the front (e.g. `fit`
# or `fdescribe`). Remove the `f` to unfocus the block.

describe "BlockCommentNG", ->
  activationPromise = null

  beforeEach ->
    atom.workspaceView = new WorkspaceView
    activationPromise = atom.packages.activatePackage('block-comment')

  describe "when the block-comment-ng:toggle event is triggered", ->
    it "attaches and then detaches the view", ->
      expect(atom.workspaceView.find('.block-comment-ng')).not.toExist()

      # This is an activation event, triggering it will cause the package to be
      # activated.
      atom.workspaceView.trigger 'block-comment-ng:toggle'

      waitsForPromise ->
        activationPromise

      runs ->
        expect(atom.workspaceView.find('.block-comment-ng')).toExist()
        atom.workspaceView.trigger 'block-comment-ng:toggle'
        expect(atom.workspaceView.find('.block-comment-ng')).not.toExist()
