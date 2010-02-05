require 'wx'

# This module is a reserved namespace for redesigning
# the behavior of Wx::Controls
module WxControlMethods

  # This class changes the way a default ListItem can
  # be created.  It uses the following syntax:
  # Format: ListItem.create(element,text,index,column,line)
  # Example: ListItem.create(self,'col one row one',0,0,0)
  # Example: ListItem.create(self,'col two row one',0,1,1)
  # Example: ListItem.create(self,'col one row two',1,0,0)
  # Example: ListItem.create(self,'col two row two',1,1,1)
  class ListItem
    def self.create(element,text,index,column,line)
      li = Wx::ListItem.new()
      li.set_text text
      li.set_id(index)
      li.set_column(column)
      element.insert_item(li) if line == 0
      element.set_item(li) if line != 0
    end
  end

end