module Admin::DashboardHelper
  def latest_migration
    # For schema_migrations table (standard Rails migrations)
    latest = ActiveRecord::Base.connection.execute("SELECT version FROM schema_migrations ORDER BY version DESC LIMIT 1").first

    latest ? latest['version'] : "No migrations run" # Handle the case where no migrations have been run
  rescue ActiveRecord::StatementInvalid # Handle potential database errors
      "Error getting migration info"
  end
end
