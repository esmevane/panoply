# This app glues together Stripe, and the Form/Notice modules in order
# to power the subscription creation form.
#
class Panoply.Apps.Subscribe
  constructor: (scope, @stripe) ->
    @form = new Panoply.Modules.Form scope
    @form.submit @captureSubmitEvent

  captureSubmitEvent: (event) =>
    event.preventDefault()
    @form.disableButton()
    @removeNotice()
    @retrieveToken()

  handleResponse: (status, response) =>
    if response.error
      @form.addNotice @notice response.error.message
      @form.enableButton()
    else
      @form.set 'subscription_form[stripe_token]', response.id
      @form.directSubmit()

  retrieveToken: -> @stripe.createToken @form.$scope, @handleResponse

  notice: (message) ->
    @_notice = new Panoply.Modules.Notice message, 'alert'
    @_notice.$element

  removeNotice: -> @_notice.remove() if @_notice?

Panoply.Apps.Subscribe.Capture = (scope) ->
  new Panoply.Apps.Subscribe scope, Stripe