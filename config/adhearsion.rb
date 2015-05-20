# encoding: utf-8

Adhearsion.config do |config|

  # Centralized way to specify any Adhearsion platform or plugin configuration
  # - Execute rake config:show to view the active configuration values
  #
  # To update a plugin configuration you can write either:
  #
  #    * Option 1
  #        Adhearsion.config.<plugin-name> do |config|
  #          config.<key> = <value>
  #        end
  #
  #    * Option 2
  #        Adhearsion.config do |config|
  #          config.<plugin-name>.<key> = <value>
  #        end

  config.development do |dev|
    dev.platform.logging.level = :debug
  end

  config.production do |prod|
    prod.platform.environment = :production
    prod.platform.logging.level = :error
  end

  config.platform.logging.outputters = 'log/ahn/adhearsion.log'

  ##
  # Use with Rayo (eg Voxeo PRISM or FreeSWITCH mod_rayo)
  #
  config.punchblock.username = "adhearsion@fs" # Your XMPP JID for use with Rayo
  config.punchblock.password = "barfoo" # Your XMPP password

  ##
  # Use with Asterisk
  #
  # config.punchblock.platform = :asterisk # Use Asterisk
  # config.punchblock.username = "manager" # Your AMI username
  # config.punchblock.password = "password" # Your AMI password
  # config.punchblock.host = "asterisk.local-dev.mojolingo.com" # Your AMI host

  ##
  # voipms_rates settings override
  # config.voipms_rates.canada_use_premium = true
  # config.voipms_rates.intl_use_premium   = true
  # config.voipms_rates.rates_endpoint     = "https://www.voip.ms/rates/xmlapi.php"
end
