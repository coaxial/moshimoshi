# encoding: utf-8

module VarsHelper
  def ringback_tone_location
    # this is the path on the FreeSWITCH machine
    "file:///usr/share/assets/us_ringback_tone.mp3"
  end

  def recording_beep_location
    "file:///usr/share/assets/beep.mp3"
  end

  def default_callerid
    "Test 15145551234"
  end

  def apps_keymaps
    {
      recorder: '*7'
    }
  end
end
