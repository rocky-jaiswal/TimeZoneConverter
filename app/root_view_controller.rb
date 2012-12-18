class RootViewController < UIViewController

  def set_default_time_zone
    @defaultTimeZoneLabel.text =  NSTimeZone.localTimeZone.name
  end

  def set_default_time
    defaultTimeZone = NSTimeZone.timeZoneWithName(@defaultTimeZoneLabel.text)
    formatter = NSDateFormatter.alloc.init
    formatter.setDateFormat('HH:mm')
    formatter.setTimeZone(defaultTimeZone)
    dateFormat = formatter.stringFromDate(NSDate.date)
    @defaultTimeLabel.text = "UTC "+(NSTimeZone.localTimeZone.secondsFromGMT/3600).to_s + "  "+dateFormat
  end

  def present_local_zone_picker(sender)
    button = sender
    @zonePicker.frame = CGRectMake(0,244, 320, 216)
    @currentZoneLabel = @defaultTimeZoneLabel

    if @zonePicker.isHidden
      @zonePicker.hidden = false
      button.setTitle("Choose", forState:UIControlStateNormal)
    else
      @zonePicker.hidden = true
      button.setTitle("Select", forState:UIControlStateNormal)
      set_default_time
    end
  end

  def present_convert_zone_picker(sender)
    button = sender
    @zonePicker.frame = CGRectMake(0,0, 320, 216)
    @currentZoneLabel = @converTimeZoneLabel

    if @zonePicker.isHidden
      @zonePicker.hidden = false
      button.setTitle("Choose",forState:UIControlStateNormal)
    else
      @zonePicker.hidden = true
      button.setTitle("Select",forState:UIControlStateNormal)
      set_convert_time
    end
  end

  def set_convert_time
    convertZone = NSTimeZone.timeZoneWithName(@converTimeZoneLabel.text)
    formatter = NSDateFormatter.alloc.init
    formatter.setDateFormat('HH:mm')
    formatter.setTimeZone(convertZone)
    dateFormat = formatter.stringFromDate(NSDate.date)
    @convertDate = formatter.dateFromString(dateFormat)
    @convertTimeLabel.text = "UTC "+(convertZone.secondsFromGMT/3600).to_s + "  "+ dateFormat
  end

  # UIPicker View Controller DataSource
  def numberOfComponentsInPickerView(pickerView)
    1
  end

  def pickerView(pickerView,numberOfRowsInComponent:component)
    NSTimeZone.knownTimeZoneNames.count
  end

  # UIPicker View Controller Delegate
  def pickerView(pickerView, titleForRow:row,forComponent:component)
    NSTimeZone.knownTimeZoneNames[row]
  end

  def pickerView(pickerView, didSelectRow:row, inComponent:component)
    @currentZoneLabel.text = NSTimeZone.knownTimeZoneNames[row]
  end

  def viewDidLoad
    titleLabel = ViewUtilities.title_label

    @defaultTimeZoneLabel = ViewUtilities.location_label(25,120)
    @defaultTimeLabel = ViewUtilities.time_label(50,147)
    
    chooseLocalButton = ViewUtilities.select_time_zone_button(220,128)
    chooseLocalButton.addTarget(self,
                                  action: :'present_local_zone_picker:',
                                  forControlEvents:UIControlEventTouchUpInside)
    
    @converTimeZoneLabel =  ViewUtilities.location_label(25,290)
    @convertTimeLabel = ViewUtilities.time_label(50,320)
    
    chooseconvertButton = ViewUtilities.select_time_zone_button(220,300)
    chooseconvertButton.addTarget(self, action: :'present_convert_zone_picker:',forControlEvents:UIControlEventTouchUpInside)
    
    view.addSubview(@converTimeZoneLabel)
    view.addSubview(@convertTimeLabel)
    view.addSubview(chooseconvertButton)
    
    @zonePicker = ViewUtilities.zone_picker(0,244)
    @zonePicker.dataSource = self
    @zonePicker.delegate = self
    
    view.addSubview(titleLabel)
    view.addSubview(@defaultTimeZoneLabel)
    view.addSubview(@defaultTimeLabel)
    view.addSubview(chooseLocalButton)
    view.addSubview(@zonePicker)
    set_default_time_zone
    set_default_time
    view.backgroundColor = UIColor.colorWithPatternImage(UIImage.imageNamed("bgApp.png"))
  end
end