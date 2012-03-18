class RemoteModel
  constructor: (@url) ->
    @onDataLoading = new Slick.Event()
    @onDataLoaded = new Slick.Event()
    @onDataLoadedSuccess = new Slick.Event()
    @onDataLoadedError = new Slick.Event()

    @onDataWriting = new Slick.Event()
    @onDataWritten = new Slick.Event()
    @onDataWrittenSuccess = new Slick.Event()
    @onDataWrittenError = new Slick.Event()

    @request = null

  loadData: ->
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
        @onDataLoadedSuccess.notify({data: response})
      error: =>
        @onDataLoadedError.notify()

  writeData: (args) ->
    @onDataWriting.notify()

    $.ajax
      url: args.item.path
      type: 'PUT'
      data: args.item
      dataType: 'json'
      complete: =>
        @onDataWritten.notify()
      success: (response) =>
        @onDataWrittenSuccess.notify({
          row: args.row
          item: args.item
          data: response[0]
        })
      error: =>
        @onDataWrittenError.notify()

$.extend(true, window, {
  "Slick": {
    "Data": {
      "RemoteModel": RemoteModel
    }
  }
})
