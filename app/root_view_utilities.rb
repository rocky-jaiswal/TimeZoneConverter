module ViewUtilities

  def self.title_label
    label = UILabel.alloc.initWithFrame(CGRectMake(80, 2, 200, 50))
    label.backgroundColor = UIColor.clearColor
    label.font = UIFont.fontWithName("HelveticaNeue-CondenseBold", size: 24)
    label.color = UIColor.whiteColor
    label.text = "Time Zone Converter"
    label
  end

  def self.location_label(xPosition, yPosition)
    label = UILabel.alloc.initWithFrame(CGRectMake(xPosition, yPosition, 200, 50))
    label.backgroundColor = UIColor.clearColor
    label.font = UIFont.fontWithName("HelveticaNeue-CondenseBold", size: 18)
    label.text = "Another Time Zone"
    label
  end

  def self.time_label(xPosition, yPosition)
    label = UILabel.alloc.initWithFrame(CGRectMake(xPosition, yPosition, 200, 50))
    label.backgroundColor = UIColor.clearColor
    label.text = "Time"
    label.textColor = UIColor.whiteColor
    label
  end

  def self.select_time_zone_button (xPosition,yPosition)
    button = UIButton.buttonWithType(UIButtonTypeCustom)
    button.frame = CGRectMake(xPosition,yPosition,85,73)
    button.setBackgroundImage (UIImage.imageNamed("btnSelect.png"),forState:UIControlStateNormal)
    button.setTitle("Select",forState:UIControlStateNormal)
    button
  end

  def self.zone_picker (xPosition,yPosition)
    picker =  UIPickerView.alloc.initWithFrame(CGRectMake(xPosition,yPosition, 320, 250))
    picker.hidden = true
    picker.showsSelectionIndicator = true
    picker
  end

end