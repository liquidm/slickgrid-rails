module SlickGrid
  class Table

    class << self
      # for easy access in generator functions
      include ::Rails.application.routes.url_helpers

      attr_reader :columns

      def column(name, options={})
        @columns ||= {id: {hidden: true}}
        @columns[name.to_sym] = options
      end
    end

    attr_accessor :rows

    def initialize(collection, i18n_scope="")
      @collection = collection
      @i18n_scope = i18n_scope
    end

    def columns
      self.class.columns
    end

    def as_json
      generate_rows
    end

    protected

    def generate_rows
      @collection.map do |obj|
        generate_row(obj)
      end
    end

    def generate_row(obj)
      Hash[columns.map do |name, options|
        [name, generate_cell(obj, name, options)]
      end]
    end

    def generate_cell(obj, name, options)
      generator = options[:generator]

      if generator and generator.respond_to?(:call)
        generator.call(obj)
      else
        obj.send(name)
      end
    end

  end
end
