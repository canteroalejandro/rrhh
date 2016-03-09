class SettingController < ApplicationController
  # before_filter :breadcrum
  before_filter :set_modelo, only: [:root, :update]

  # respond_to :html

  def root
    @config = @config["defaults"]
    respond_to do |format|
      format.html
    end
  end

  def update
    @config["defaults"] = params[:settings]
    File.open(Setting.source, 'w') { |f| YAML.dump(@config, f) }
    Setting.reload!
    respond_to do |format|
      format.html { redirect_to setting_path, notice: 'La Configuracion fue actualizado con exito.'  }
    end
  end

  private
    def set_modelo
      @config = YAML.load_file Setting.source
    end

    def breadcrum
      # add_breadcrumb 'Configuracion', ""
    end
end
