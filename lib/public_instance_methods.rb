require 'wx'
# This Module should be placed in the custom libraries set in RUBYLIB
# This module is used for WxRuby2 applications and applies to
# public instance methods associated with the core app.  It is
# not designed to replace modules that require they be extended
# from variables Wx_Sugar assigns from XRC source.
module PublicInstanceMethods

  # This method is currently a quick debug box for reading variables
  # and values.
  def debug_box(method, variable, value)
    dlg = Wx::MessageDialog.new(self,
      "Method = #{method}\nVariable = #{variable}\nValue = #{value}", "Debugging #{method}",
      Wx::OK | Wx::ICON_INFORMATION
    )
    dlg.show_modal()
  end

  # This method processes a close/exit event for the GUI.
  def on_exit
    close
  end

  # This method sets the default icon for the given window or frame
  # and requires that the icon type be ICO format.
  def set_icon_file(path, *file)
    icon_file = File.join(File.dirname(path), file)
    set_icon Wx::Icon.new(icon_file, Wx::BITMAP_TYPE_ICO)
  end

  # This method creates an event timer that enforces the passing of
  # threads within the application.  threadms refers to the number
  # of milliseconds for the thread event timer.  timerms refers to
  # the number of milliseconds for the actual timer start.
  def set_timer_threads(threadms,timerms)
    t = Wx::Timer.new(self, threadms)
    evt_timer(threadms) { Thread.pass }
    t.start(timerms)
  end

  # This method creates a default about box for the program.  It is
  # currently preset with developer and copyright information to
  # minimize input.  The only input arguments it takes is version
  # and description.
  def show_about_box(version,description)
    Wx::about_box(
      :name => self.title,
      :version => version,
      :description => description,
      :developers => ['Joel Dezenzio'],
      :copyright => "(C) 2010 Joel Dezenzio.  All rights reserved."
    )
  end

  # This method displays a default message multiline text control to
  # the user.  It can be used to display long messages.
  def show_message(message)
    dialog = Wx::Dialog.new(@frame)
    dialog.sizer = Wx::BoxSizer.new(Wx::VERTICAL)
    text = Wx::TextCtrl.new(dialog,:style => Wx::TE_READONLY | Wx::TE_MULTILINE,:value => message)
    dialog.sizer.add(text, 1, Wx::EXPAND)
    ok_button = Wx::Button.new(dialog, Wx::ID_OK, "OK")
    dialog.sizer.add(ok_button, 0, Wx::ALIGN_CENTER_HORIZONTAL)
    ok_button.set_default
    ok_button.set_focus
    dialog.show_modal
  end

  # This method converts a string to boolean format.
  def to_boolean(string)
    return true if string == true || string =~ /^true$/i
    return false if string == false || string.nil? || string =~ /^false$/i
    raise ArgumentError.new("invalid value for to_boolean: \"#{string}\"")
  end

end