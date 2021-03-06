Lucky::Server.configure do |settings|
  if Lucky::Env.production?
    settings.secret_key_base = secret_key_from_env
    settings.host = "0.0.0.0"
    settings.port = ENV["PORT"].to_i
  else
    settings.secret_key_base = "JNBFw0+imkGvmYdnetzIcTOEnizNioRXjVQ9f0qsEPQ="
    # Change host/port in config/watch.yml
    # Alternatively, you can set the PORT env to set the port
    settings.host = Lucky::ServerSettings.host
    settings.port = Lucky::ServerSettings.port
  end
end

Lucky::ForceSSLHandler.configure do |settings|
  # To force SSL in production, uncomment the line below.
  # This will cause http requests to be redirected to https:
  #
  #    settings.enabled = Lucky::Env.production?
  #
  # Or, leave it disabled:
  settings.enabled = false
end

private def secret_key_from_env
  ENV["SECRET_KEY_BASE"]? || raise_missing_secret_key_in_production
end

private def raise_missing_secret_key_in_production
  raise "Please set the SECRET_KEY_BASE environment variable. You can generate a secret key with 'lucky gen.secret_key'"
end
