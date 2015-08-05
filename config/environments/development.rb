Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  # Asset digests allow you to set far-future HTTP expiration dates on all assets,
  # yet still be able to expire them through the digest params.
  config.assets.digest = true

  # Adds additional error checking when serving assets at runtime.
  # Checks for improperly declared sprockets dependencies.
  # Raises helpful error messages.
  config.assets.raise_runtime_errors = true

  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true
end

# # Launch a Byebug remote debugger service, if specified and not already running:
# if %w(true 1).include? (ENV.fetch 'ENABLE_DEBUG_SERVER', 'false').to_s.downcase
#   require 'socket'
#   byebug_server_host = '0.0.0.0'
#   byebug_server_port = (ENV.fetch 'RUBY_DEBUG_PORT', 8989).to_i
#   begin
#     # Open a client socket to check if Byebug server is already running:
#     test_socket = TCPSocket.new byebug_server_host, byebug_server_port
#
#     # If code is running at this point, we'll assume that a Byebug server
#     # is already running at the requested host:port.
#
#
#     # Close the socket connection:
#     test_socket.close
#
#     puts "A service (most probably a Byebug server) is already listening in '#{byebug_server_host}:#{byebug_server_port}'"
#   rescue Errno::ECONNREFUSED => e
#     # No Byebug server was found running...
#     require 'byebug'
#     Byebug.start_server byebug_server_host, byebug_server_port
#     puts "Byebug server started at '#{byebug_server_host}:#{byebug_server_port}'"
#   end
# end
