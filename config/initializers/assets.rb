# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
Rails.application.config.assets.precompile += %w( css/bootstrap.min.css )
Rails.application.config.assets.precompile += %w( css/bootstrap-responsive.min.css )
Rails.application.config.assets.precompile += %w( css/font-awesome.min.css )
Rails.application.config.assets.precompile += %w( css/ace.min.css )
Rails.application.config.assets.precompile += %w( css/ace-responsive.min.css )
Rails.application.config.assets.precompile += %w( css/ace-skins.min.css )

Rails.application.config.assets.precompile += %w( jquery-2.0.3.min.js )
Rails.application.config.assets.precompile += %w( js/bootstrap.min.js )
Rails.application.config.assets.precompile += %w( js/jquery-ui-1.10.3.custom.min.js )
Rails.application.config.assets.precompile += %w( js/jquery-ui-1.10.3.custom.min.js )
Rails.application.config.assets.precompile += %w( js/jquery.ui.touch-punch.min.js )
Rails.application.config.assets.precompile += %w( js/jquery.slimscroll.min.js )
Rails.application.config.assets.precompile += %w( js/jquery.easy-pie-chart.min.js )
Rails.application.config.assets.precompile += %w( js/jquery.sparkline.min.js )
Rails.application.config.assets.precompile += %w( js/flot/jquery.flot.min.js )
Rails.application.config.assets.precompile += %w( js/flot/jquery.flot.pie.min.js)
Rails.application.config.assets.precompile += %w( js/flot/jquery.flot.resize.min.js )
Rails.application.config.assets.precompile += %w( js/ace-elements.min.js)
Rails.application.config.assets.precompile += %w( js/ace.min.js)
Rails.application.config.assets.precompile += %w( .svg .eot .woff .ttf )
Rails.application.config.assets.precompile += %w( asistencias/*.js )
Rails.application.config.assets.precompile += %w( asistencias/*.css )
Rails.application.config.assets.precompile += %w( setting.css )
Rails.application.config.assets.precompile += %w( setting.js )

Rails.application.config.assets.precompile += %w( root.css )
Rails.application.config.assets.precompile += %w( root.js )


%w( categorias departamentos empleados proyectos horarios usuarios sessions asistencias historia_medicas sexos horario_empleados check_ins check_outs roles hora_extras incidencias incidencia_empleados contratos contrato_empleados feriados).each do |controller|
  Rails.application.config.assets.precompile += ["#{controller}.js", "#{controller}.css"]
end