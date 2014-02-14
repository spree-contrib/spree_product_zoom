module Spree::ProductZoom; end

module SpreeProductZoom
  class Engine < Rails::Engine
    require 'spree/core'
    isolate_namespace Spree
    engine_name 'spree_product_zoom'

    config.autoload_paths += %W(#{config.root}/lib)

    # use rspec for tests
    config.generators do |g|
      g.test_framework :rspec
    end

    initializer :assets do |config|
      Rails.application.config.assets.precompile += %w( store/fancybox_*.* store/blank.gif )
    end

    initializer("spree.product_zoom.preferences", 
                :after => "spree.environment",
                :before => :load_config_initializers) do |app|
      Spree::ProductZoom::Config = Spree::ProductZoomConfiguration.new
    end

    def self.activate
      Dir.glob(File.join(File.dirname(__FILE__), '../../app/**/*_decorator*.rb')) do |c|
        Rails.configuration.cache_classes ? require(c) : load(c)
      end
    end

    config.to_prepare &method(:activate).to_proc
  end
end
