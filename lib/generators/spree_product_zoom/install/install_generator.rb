module SpreeProductZoom
  module Generators
    class InstallGenerator < Rails::Generators::Base

      def add_javascripts
        append_file 'vendor/assets/javascripts/spree/frontend/all.js', "//= require spree/product_zoom\n"
      end

      def add_stylesheets
        if File.exists?('vendor/assets/stylesheets/spree/frontend/all.css')
          inject_into_file 'vendor/assets/stylesheets/spree/frontend/all.css', " *= require spree/product_zoom\n", :before => /\*\//, :verbose => true
        elsif File.exists?('vendor/assets/stylesheets/spree/frontend/all.css.scss')
          append_file 'vendor/assets/stylesheets/spree/frontend/all.css.scss', "\n@import 'spree/product_zoom'\n"
        elsif File.exists?('vendor/assets/stylesheets/spree/frontend/all.scss')  
          append_file 'vendor/assets/stylesheets/spree/frontend/all.scss', "\n@import 'spree/product_zoom'\n"
        end
      end
    end
  end
end
