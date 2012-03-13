module Core
  require 'core/active_record/base'
  require 'core/active_record/schema'
  require 'core/active_record/schema_dumper'
  require 'core/active_record/connection_adapters/abstract_adapter'
  require 'core/active_record/connection_adapters/foreign_key_definition'
  require 'core/active_record/connection_adapters/column'
  require 'core/active_record/connection_adapters/index_definition'
  require 'core/active_record/connection_adapters/mysql_adapter'
  require 'core/active_record/connection_adapters/mysql_column'
  require 'core/active_record/connection_adapters/postgresql_adapter'
  require 'core/active_record/connection_adapters/schema_statements'
  require 'core/active_record/connection_adapters/sqlite3_adapter'
  require 'core/active_record/connection_adapters/table_definition'
end

ActiveRecord::Base.send(:include, Core::ActiveRecord::Base)
ActiveRecord::Schema.send(:include, Core::ActiveRecord::Schema)
ActiveRecord::SchemaDumper.send(:include, Core::ActiveRecord::SchemaDumper)
ActiveRecord::ConnectionAdapters::IndexDefinition.send(:include, Core::ActiveRecord::ConnectionAdapters::IndexDefinition)
ActiveRecord::ConnectionAdapters::TableDefinition.send(:include, Core::ActiveRecord::ConnectionAdapters::TableDefinition)
ActiveRecord::ConnectionAdapters::Column.send(:include, Core::ActiveRecord::ConnectionAdapters::Column)
ActiveRecord::ConnectionAdapters::AbstractAdapter.send(:include, Core::ActiveRecord::ConnectionAdapters::AbstractAdapter)
ActiveRecord::ConnectionAdapters::SchemaStatements.send(:include, Core::ActiveRecord::ConnectionAdapters::SchemaStatements)

if defined?(ActiveRecord::ConnectionAdapters::PostgreSQLAdapter) then
  ActiveRecord::ConnectionAdapters::PostgreSQLAdapter.send(:include, Core::ActiveRecord::ConnectionAdapters::PostgresqlAdapter)
end
if defined?(ActiveRecord::ConnectionAdapters::MysqlAdapter) then
  ActiveRecord::ConnectionAdapters::MysqlColumn.send(:include, Core::ActiveRecord::ConnectionAdapters::MysqlColumn)
  ActiveRecord::ConnectionAdapters::MysqlAdapter.send(:include, Core::ActiveRecord::ConnectionAdapters::MysqlAdapter)
  if ActiveRecord::Base.connection.send(:version)[0] < 5
    #include MySql4Adapter
    ActiveRecord::ConnectionAdapters::MysqlAdapter.send(:include, Core::ActiveRecord::ConnectionAdapters::Mysql4Adapter)
  else
    #include MySql5Adapter
    ActiveRecord::ConnectionAdapters::MysqlAdapter.send(:include, Core::ActiveRecord::ConnectionAdapters::Mysql5Adapter)
  end

end
if defined?(ActiveRecord::ConnectionAdapters::SQLite3Adapter) then
  ActiveRecord::ConnectionAdapters::SQLite3Adapter.send(:include, Core::ActiveRecord::ConnectionAdapters::Sqlite3Adapter)
end
