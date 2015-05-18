module VoipmsRates
  class Plugin < Adhearsion::Plugin

    require_relative "version"

    # Actions to perform when the plugin is loaded
    #
    init :voipms_rates do
      logger.warn "VoipmsRates has been loaded"
    end

    # Basic configuration for the plugin
    #
    config :voipms_rates do
      rates_endpoint 'https://www.voip.ms/rates/xmlapi.php', desc: "The URL for voip.ms' rates API endpoint"
      canada_use_premium false, desc: "Set to true if you are using premium routes for Canada (change this setting on voip.ms > Account Settings > Account Routing)"
      intl_use_premium false, desc: "Set to true if you are using premium routes for International calls (change this setting on voip.ms > Account Settings > Account Routing)"
    end

    # Defining a Rake task is easy
    # The following can be invoked with:
    #   rake plugin_demo:info
    #
    tasks do
      namespace :voipms_rates do
        desc "Prints the PluginTemplate information"
        task :info do
          STDOUT.puts "VoipmsRates plugin v. #{VERSION}"
        end

        desc "Changes the Canada routing option to match your settings on voip.ms > Account Settings > Account Routing"
        task :canada_use_premium do
          config.canada_use_premium = !config.canada_use_premium
          STDOUT.puts "Use Canada premium routes rate: #{config.canada_use_premium}."
        end

        desc "Changes the International routing option to match your settings on voip.ms > Account Settings > Account Routing"
        task :intl_use_premium do
          config.intl_use_premium = !config.intl_use_premium
          STDOUT.puts "Use International premium routes rate: #{config.canada_use_premium}."
        end
      end
    end

  end
end
