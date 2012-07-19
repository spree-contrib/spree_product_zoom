SpreeProductZoom
===================

A Spree extension that adds lightbox zoom functionality for product images.
The lightbox is powered by [fancyBox](http://fancyapps.com/fancybox/).


Installation	
=======

Add this extension to your Gemfile:

```ruby
gem "spree_product_zoom", :git => "git://github.com/spree/spree_product_zoom.git"
```

Then run:

```
bundle install
```

Run:

```
bundle exec rails g spree_product_zoom:install
```

in order to copy over the required css and js files.

Once installation is complete your product images can be zoomed by clicking on the "Zoom In" button beneath an image.

Copyright (c) 2012 John Dyer, released under the New BSD License
