XRegExp = require('xregexp').XRegExp

module.exports.parse = (input) ->
  result = {}
  result.content = input
  result.blockId = 2
  pattern = new XRegExp("O(?<MsgType>\\d{3})(?<InputTime>\\d{4})(?<InputDate>\\d{6})(?<Bic>\\w*?)(?<Session>\\w{4})(?<Sequence>\\w{6})(?<OutputDate>\\d{6})(?<OutputTime>\\d{4})(?<Prio>[SNU])")
  match = pattern.xexec(input)
  if(match?)
    result.direction = 'O'
    result.msgType = match.MsgType
    result.inputTime = match.InputTime
    result.inputDate = match.InputDate
    result.bic = match.Bic
    result.sessionNumber = match.Session
    result.sequenceNumber = match.Sequence
    result.outputDate = match.OutputDate
    result.outputTime = match.OutputTime
    result.prio = match.Prio
    return result

  pattern = new XRegExp("I(?<MsgType>\\d{3})(?<Bic>\\w{7,12})(?<Prio>[SNU])(?<MonitoringField>[123])?(?<Obsolescence>\\d{3})?")
  match = pattern.xexec(input)
  if(match?)
    result.direction = 'I'
    result.msgType = match.MsgType
    result.bic = match.Bic
    result.prio = match.Prio
    result.monitoringField = match.MonitoringField
    result.obsolescence = match.Obsolescence

  return result

