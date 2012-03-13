require "foreign_key_migrations/version"
require 'foreigner'

module ForeignKeyMigrations
  extend self

  require 'foreign_key_migrations/migration'
  require 'foreign_key_migrations/connection_adapters/table_definition'
  require 'foreign_key_migrations/connection_adapters/schema_statements'

  def references(table_name, column_name, options = {})
    column_name = column_name.to_s
    if options.has_key?(:references)
      references = options[:references]
      references = [references, :id] unless references.nil? || references.is_a?(Array)
      references
    elsif column_name == 'parent_id'
      [table_name, :id]
    elsif column_name =~ /^(.*)_id$/
      [$1.pluralize, :id]
    end
  end

  def add_foreign_key adapter, table_name, column_name, column_options
    references = ForeignKeyMigrations.references(table_name, column_name, column_options)
    convert_legacy_options!(column_options)
    adapter.add_foreign_key table_name, references.first, column_options.merge(:column => column_name) if references
  end

  def convert_legacy_options! options
    on_delete = options.delete :on_delete
    if on_delete
      options[:dependent] = case on_delete
                            when :set_null
                              :nullify
                            when :cascade
                              :delete
                            else
                              on_delete
                            end
    end
  end
end

require 'foreign_key_migrations/railtie' if defined?(Rails)
