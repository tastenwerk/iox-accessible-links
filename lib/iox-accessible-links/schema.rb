module IoxAccessibleLinks
  # Provides helper methods that can be used in migrations.
  module Schema
    COLUMNS = { :anonymous_access           => :boolean,
                :anonymous_access_expires   => :date,
                :public_key                 => :string }

    def self.included(base)
      ActiveRecord::ConnectionAdapters::Table.send :include, TableDefinition
      ActiveRecord::ConnectionAdapters::TableDefinition.send :include, TableDefinition
      ActiveRecord::ConnectionAdapters::AbstractAdapter.send :include, Statements
      ActiveRecord::Migration::CommandRecorder.send :include, CommandRecorder
    end

    module Statements
      def add_accessible_links(table_name)
        COLUMNS.each_pair do |column_name, column_arr|
          add_column(table_name, "#{column_name}",
                                  IoxCloud::Schema.get_column_type(column_arr),
                                  IoxCloud::Schema.get_column_opts(column_arr) )
        end
      end

      def remove_accessible_links(table_name)
        COLUMNS.each_pair do |column_name, column_type|
          remove_column(table_name, "#{column_name}")
        end
      end

    end

    module TableDefinition
      def accessible_links
        COLUMNS.each_pair do |column_name, column_arr|
          column("#{column_name}",
                  IoxCloud::Schema.get_column_type(column_arr),
                  IoxCloud::Schema.get_column_opts(column_arr) )
        end
      end
    end

    module CommandRecorder
      def add_accessible_links(*args)
        record(:add_attachment, args)
      end

      private

      def invert_add_accessible_links(args)
        [:remove_attachment, args]
      end
    end

    def self.get_column_type( column_arr )
      return column_arr.is_a?(Array) ? column_arr[0] : column_arr
    end

    def self.get_column_opts( column_arr )
      return column_arr.is_a?(Array) ? column_arr[1] : {}
    end

  end
end
