class Panoply.Modules.Form
  constructor: (@selector) -> @$scope = $(@selector).find 'form'
  addNotice: (content) -> @container().prepend content
  button: -> @_button ?= @$scope.find 'input[type=submit], button'
  container: -> @_container ?= @$scope.closest('.form-card').parent()
  directSubmit: -> @$scope.get(0).submit()
  disableButton: -> @button().prop disabled: true
  enableButton: -> @button().prop disabled: false
  set: (name, value) -> @$scope.find("[name='#{name}']").val value
  submit: (handler) -> @$scope.submit handler

