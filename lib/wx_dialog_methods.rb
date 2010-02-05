require 'wx'

# This module is a reserved namespace for redesigning
# the behavior of dialogs.  It contains the following
# classes - FileDialog, ListItem, MessageBox
module WxDialogMethods

  class FileDialog
    # This method displays an open modal dialog and returns the path selected.
    # It requires two variables: message which shows as the title of the
    # dialog, and wildcardopen which should be set similar to the following:
    # $wildcardopen = "Kirin Source (*.kir)|*.kir|All files (*.*)|*.*"
    # Example: FileDialog.open(self,"Open Workspace..","Kirin Source (*.kir)|*.kir|All files (*.*)|*.*")
    def self.open(element, message,wildcardopen)
      dlg = Wx::FileDialog.new(element, message, Dir.getwd(), "", wildcardopen, Wx::OPEN)
      if dlg.show_modal() == Wx::ID_OK
        path = dlg.get_path()
        return path
      end
    end
    # This method displays a save modal dialog and returns the path selected.
    # It requires two variables: message which shows as the title of the
    # dialog, and wildcardsave which should be set similar to the following:
    # $wildcardsave = "All Files (*.*)|*.*|Kirin Source (*.kir)|*.kir"
    # Example: FileDialog.save(self,"Save Workspace..","All Files (*.*)|*.*|Kirin Source (*.kir)|*.kir")
    def self.save(element,message,wildcardsave)
      dlg = Wx::FileDialog.new(element, message, Dir.getwd(), "", wildcardsave, Wx::SAVE)
      dlg.set_filter_index(2)
      if dlg.show_modal() == Wx::ID_OK
        path = dlg.get_path()
        return path
      end
    end
  end

  # This class changes the way a default ListItem can
  # be created.  It uses the following syntax:
  # Format: ListItem.create(element,text,index,column,line)
  class ListItem
    # Example: ListItem.create(self,'col one row one',0,0,0)
    # Example: ListItem.create(self,'col two row one',0,1,1)
    # Example: ListItem.create(self,'col one row two',1,0,0)
    # Example: ListItem.create(self,'col two row two',1,1,1)
    def self.create(element,text,index,column,line)
      li = Wx::ListItem.new()
      li.set_text text
      li.set_id(index)
      li.set_column(column)
      element.insert_item(li) if line == 0
      element.set_item(li) if line != 0
    end
  end
  
  # This class manages message dialogs for simple message box displays.
  class MessageBox
    # This method displays a message box to the user.  It contains a header
    # and a message field that can be customized.
    # Example MessageBox.new("my title","my message")
    def self.new(header,message)
      Wx::MessageDialog.new(@frame,
        :message => message,
        :caption => "#{header}",
        :style => Wx::OK
      ).show_modal
    end
  end

end