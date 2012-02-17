module SlickGrid
  class Table

    class << self
      attr_reader :columns

      def register_column(name, options={})
        @columns ||= {}
        @columns[name] = options
      end
    end

    attr_accessor :rows

    def initialize(collection, i18n_scope="")
      @collection = collection
      @i18n_scope = i18n_scope
      @hidden_columns = [:id]
    end

    def columns
      self.class.columns
    end

    def hide_column(name)
      @hidden_columns |= [name.to_sym]
    end

    def active_columns
      columns.keys - @hidden_columns
    end

    def as_json
      {
        columns: generate_columns,
        rows: generate_rows,
      }
    end

    protected

    def generate_columns
      active_columns.map do |column|
        title = columns[column][:title] || column.to_s
        options = columns[column][:options] || {}
        { :id => column, :field => column, :name => title }.merge(options)
      end
    end

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
