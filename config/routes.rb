# encoding: utf-8

require 'call_controllers/outbound_call'

Adhearsion.router do

  # Specify your call routes, directing calls with particular attributes to a controller

  route 'default', OutboundCallController
end
