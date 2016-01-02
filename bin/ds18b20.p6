use RPi::Device::DS18B20;

MAIN: {
  my $ds18b20 = RPi::Device::DS18B20.new();

  my ($sensor) = $ds18b20.detect-sensors();
  die "ERROR: No DS18B20 sensors detected" if ! $sensor.defined;
  
  react {
    whenever Supply.interval(5, 0) {
      # Read the temperatures from all registered DS18B20 sensors every
      # 5 seconds.
      my $temperature = $sensor.read();

      die "ERROR: Temperature reading not avaialable" if ! $temperature.defined;
      
      say "Temperature: id=" ~ $sensor.id ~ ": temp=$temperature"
        if $temperature.defined;            
    }
  }
}
