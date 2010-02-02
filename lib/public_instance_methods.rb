require 'wx'
# This Module should be placed in the custom libraries set in RUBYLIB
# This module is used for WxRuby2 applications and applies to
# public instance methods associated with the core app.  It is
# not designed to replace modules that require they be extended
# from variables Wx_Sugar assigns from XRC source.
module PublicInstanceMethods

  # This method displays an open modal dialog and returns the path selected.
  # It requires two variables: message which shows as the title of the
  # dialog, and wildcardopen which should be set similar to the following:
  # $wildcardopen = "Kirin Source (*.kir)|*.kir|All files (*.*)|*.*"
  def dlg_on_open(message,wildcardopen)
    dlg = Wx::FileDialog.new(self, message, Dir.getwd(), "", wildcardopen, Wx::OPEN)
    if dlg.show_modal() == Wx::ID_OK
      path = dlg.get_path()
      return path
    end
  end

  # This method displays a save modal dialog and returns the path selected.
  # It requires two variables: message which shows as the title of the
  # dialog, and wildcardsave which should be set similar to the following:
  # $wildcardsave = "All Files (*.*)|*.*|Kirin Source (*.kir)|*.kir"
  def dlg_on_save(message,wildcardsave)
    dlg = Wx::FileDialog.new(self, message, Dir.getwd(), "", wildcardsave, Wx::SAVE)
    dlg.set_filter_index(2)
    if dlg.show_modal() == Wx::ID_OK
      path = dlg.get_path()
      return path
    end
  end

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

end