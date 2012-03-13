module ForeignKeyMigrations::ConnectionAdapters::SchemaStatements

  def self.included(base)
    base.class_eval do
      alias_method_chain :create_table, :foreign_key_migrations
      alias_method_chain :table_definition, :foreign_key_migrations
    end
  end

  def create_table_with_foreign_key_migrations(table_name, options = {}, &block)
    create_table_without_foreign_key_migrations(table_name, options, &block)

    @table_definition.column_definitions.each do |column_params|
      column_name = column_params.first
      column_options = column_params.last
      ForeignKeyMigrations.add_foreign_key self, table_name, column_name, column_options
    end

  end

  private
  def table_definition_with_foreign_key_migrations
    @table_definition = ActiveRecord::ConnectionAdapters::TableDefinition.new(self)
  end
end
