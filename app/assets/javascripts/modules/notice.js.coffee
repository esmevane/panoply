class Panoply.Modules.Notice
  constructor: (content = '', suffix = 'notice') ->
    @element = @composeElement content, suffix
    @$element = $ @element

  composeElement: (content, suffix) ->
    notice = document.createElement 'div'
    notice.id = "flash_#{suffix}"
    notice.innerHTML = content
    notice

  remove: ->
    destroy = => @$element.remove()
    @$element.addClass 'is-invisible'
    setTimeout destroy, 300
