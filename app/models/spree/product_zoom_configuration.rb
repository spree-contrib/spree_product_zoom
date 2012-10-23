class Spree::ProductZoomConfiguration < Spree::Preferences::Configuration
  preference :default_image_style, :symbol, :default => :original
end
