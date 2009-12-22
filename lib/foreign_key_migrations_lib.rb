ActiveRecord::Base.send(:include, ForeignKeyMigrations::ActiveRecord::Base)
ActiveRecord::Migration.send(:include, ForeignKeyMigrations::ActiveRecord::Migration)
ActiveRecord::ConnectionAdapters::TableDefinition.send(:include, ForeignKeyMigrations::ActiveRecord::ConnectionAdapters::TableDefinition)
