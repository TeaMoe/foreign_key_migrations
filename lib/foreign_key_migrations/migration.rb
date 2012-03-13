module ForeignKeyMigrations
  module Migration
    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      def add_column(table_name, column_name, type, options = {})
        super
        references = ForeignKeyMigrations.references(table_name, column_name, options)
        add_foreign_key table_name, references.first, options.merge(:column => column_name) if references
      end
    end
  end
end
