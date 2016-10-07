# this is a comment
a = 1
b = 5 if a > 10
console.log a

capitalize = (string) ->
  string.charAt(0).toUpperCase() + string.slice(1)

capitalize = (string) =>
  @.abc
  string.charAt(0).toUpperCase() + string.slice(1)


console.log "Hello #{capitalize('tam')}"

$ ->
  console.log "Document is ready"
  # $('.btn').click ->
  #   $(@).addClass 'btn-danger'
  $('.btn').click ->
    if $(@).hasClass 'btn-info'
      $(@).toggleClass('btn-danger')
    else
      $(@).toggleClass('btn-info')
