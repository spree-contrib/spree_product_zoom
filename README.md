SpreeProductZoom
===================

A Spree extension that allows product images to be enlarged using a lightbox.
The lighbox is powered by [fancyBox](http://fancyapps.com/fancybox/).


Installation	
=======

Add this extension to your Gemfile:

```ruby
gem "spree_social_products", :git => "git://github.com/spree/spree_product_zoom.git"
```

Then run:

```
bundle install
```

Run:

```
bundle exec rails g spree_social_products:install
```

in order to copy over the required css and js files.

Once installation is complete your product images can be zoomed by clicking on the "Zoom In" button beneath an image.

Copyright (c) 2012 John Dyer, released under the New BSD License
