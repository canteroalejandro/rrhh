class Setting < Settingslogic
  source "#{Rails.root}/config/application.yml"
  namespace "defaults"

  # data = YAML.load_file Settings.source
  # File.open(Settings.source, 'w') { |f| YAML.dump(data, f) }
end