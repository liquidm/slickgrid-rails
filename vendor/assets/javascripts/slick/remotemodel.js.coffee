class RemoteModel
  constructor: (@url) ->
    @onDataLoading = new Slick.Event()
    @onDataLoaded = new Slick.Event()
    @onDataSuccess = new Slick.Event()
    @onDataError = new Slick.Event()
    @request = null

  ensureData: ->
    if @request
      @request.abort()

    @onDataLoading.notify()

    @request = $.ajax
      url: @url
      dataType: 'json'
      cache: false
      complete: =>
        @onDataLoaded.notify()
      success: (response) =>
        @request = null
        @onDataSuccess.notify({data: response})
      error: =>
        @onDataError.notify()

$.extend(true, window, {
  "Slick": {
    "Data": {
      "RemoteModel": RemoteModel
    }
  }
})
