module ForeignKeyMigrations::ConnectionAdapters
  module TableDefinition
    def self.included(base)
      base.class_eval do
        alias_method_chain :column, :foreign_key_migrations
      end
    end

    def column_definitions
      @column_definitions ||= []
    end

    def column_with_foreign_key_migrations(name, type, options = {})
      res = column_without_foreign_key_migrations(name, type, options)
      column_definitions << [ name, type, options ]
      res
    end

  end
end
