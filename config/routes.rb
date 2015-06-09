# encoding: utf-8

require_all 'app/call_controllers'

Adhearsion.router do

  # Specify your call routes, directing calls with particular attributes to a controller

  route 'default', OutboundCallController
end
