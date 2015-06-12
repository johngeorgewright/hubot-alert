hubotAlert = require '../src/alert'
chai = require 'chai'
sinon = require 'sinon'
chai.use require 'sinon-chai'
{expect} = chai

describe 'alert', ->
  beforeEach ->
    @robot =
      router:
        post: sinon.spy()
    hubotAlert @robot

  it 'registers a POST listener', ->
    expect(@robot.router.post).to.have.been.calledWith '/hubot/alert/:token'
