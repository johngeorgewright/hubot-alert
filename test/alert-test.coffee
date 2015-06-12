hubotAlert = require '../src/alert'
chai = require 'chai'
sinon = require 'sinon'
chai.use require 'sinon-chai'
{expect} = chai

describe 'alert', ->
  beforeEach ->
    @robot =
      respond: sinon.spy()
      hear: sinon.spy()
    hubotAlert @robot

  it 'registers a respond listener', ->
    expect(@robot.respond).to.have.been.calledWith(/hello/)

  it 'registers a hear listener', ->
    expect(@robot.hear).to.have.been.calledWith(/orly/)
