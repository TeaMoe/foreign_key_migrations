module ForeignKeyMigrations
  class Railtie < Rails::Railtie
    initializer 'foreign_key_migrations.load_adapter' do
      ActiveSupport.on_load :active_record do
        ActiveRecord::Migration.send(:include, ForeignKeyMigrations::Migration)
        ActiveRecord::ConnectionAdapters::SchemaStatements.send :include, ForeignKeyMigrations::ConnectionAdapters::SchemaStatements
        ActiveRecord::ConnectionAdapters::TableDefinition.send :include, ForeignKeyMigrations::ConnectionAdapters::TableDefinition
      end
    end
  end
end
