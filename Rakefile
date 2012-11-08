# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project'
require 'bundler'

Bundler.require

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = 'Readingrecs'
  app.identifier = 'se.adaptiv.readingrecs'
  #app.codesign_certificate = 'iPhone Developer: Johan Lind (P8FK6Z5FED)'
  app.pods do
    pod 'MBProgressHUD'
    pod 'SVPullToRefresh'
  end
end
