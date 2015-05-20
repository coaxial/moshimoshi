# encoding: utf-8

class SilentHoldController < Adhearsion::CallController
  def run
    main_dial.rejoin
  end

  def main_dial
    metadata['current_dial']
  end
end
