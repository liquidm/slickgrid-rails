# SlickGrid::Rails

slickgrid-rails is a simple gem to add
[SlickGrid](https://github.com/mleibman/SlickGrid) vendor files to the Rails
asset pipeline. It also provides a simple `SlickGrid::Table` class to render JSON
output suitable for the Grid/DataView.

## Installation

Add this line to your application's Gemfile:

    gem 'slickgrid-rails'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install slickgrid-rails

## Usage

To use the basic grid functionality you just need to include the slick.js file
in your Sprocket manifest:

    //= require slick

The above example will include all required jQuery dependencies and
core.js/grid.js from SlickGrid. To use one of the more advanced example modules
simply add them to your manifest:

    //= require slick/dataview
    //= require slick/editors
    //= require slick/formatters

### Rails Table Helper

A simple table helper is included to generate SlickGrid compatible JSON output:

    require "slickgrid/table"

    class UsersTable < SlickGrid::Table
      column :name
      column :email
      column :last_login
    end

To render a list of all users add the following to your controller:

    class UsersController < ApplicationController
      def index
        respond_with(@users) do |format|
          format.json { render :json => UsersTable.new(@users).as_json }
        end
      end
    end

The `SlickGrid::Table` class will render columns for each model instance by
simply calling the column methods on the instance. If you want to customize the
output, specify a custom generator function:

    class UsersTable < SlickGrid::Table
      column :name, generator: ->(obj) { "#{obj.first_name} #{obj.last_name}" }
      column :email
      column :last_login
    end

### Rails Model Support

This gem also replaces the example RemoteModel (which can only load data from
digg.com) to support loading and updating standard Rails REST models. First,
include the class into your manifest:

    //= require slick/remotemodel

Then update your table definition to include a path column for each
instance:

    class UsersTable < SlickGrid::Table
      ...
      column :path, generator: ->(obj) { user_path(obj) }
    end

Finally wire up all the grid events (example taken from the
[requirejs-controllers](https://github.com/madvertise/requirejs-controllers)
gem):

    initGrid: (@selector, @columns, @options) ->
      @dataView = new Slick.Data.DataView()
      @grid = new Slick.Grid(@selector, @dataView, @columns, @options)
      @model = model = new Slick.Data.RemoteModel()

    initLoader: ->
      @model.onDataLoading.subscribe (e, args) =>
        @showIndicator()

      @model.onDataLoaded.subscribe (e, args) =>
        @hideIndicator()

      @model.onDataLoadedSuccess.subscribe (e, args) =>
        @dataView.beginUpdate()
        @dataView.setItems(args.data)
        @dataView.endUpdate()
        @grid.invalidateAllRows()
        @grid.render()

      @model.onDataLoadedError.subscribe (e, args) =>
        alert("failed to load data from server")

    initWriter: ->
      @model.onDataWriting.subscribe (e, args) =>
        @showIndicator("Writing")

      @model.onDataWritten.subscribe (e, args) =>
        @hideIndicator()

      @model.onDataWrittenSuccess.subscribe (e, args) =>
        @dataView.updateItem(args.item.id, args.data)
        @grid.updateRow(args.row)

      @model.onDataWrittenError.subscribe (e, args) =>
        alert("failed to write data on server")

      @grid.onCellChange.subscribe (e, args) =>
        @model.writeData(args)

## Update SlickGrid

To upgrade SlickGrid version just run

    rake slickgrid:update

It will clone the current SlickGrid master and will copy all javascript and stylesheet files into this repository. 
Don't forget to update the gemspec version!

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
