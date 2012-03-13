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
end

require 'foreign_key_migrations/railtie' if defined?(Rails)
