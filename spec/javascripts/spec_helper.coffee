path = "../../app/assets/javascripts"
libs = []

global.jQuery   = require 'jquery'
global._        = require 'underscore'
global.Backbone = require 'backbone'
global.$        = jQuery
Backbone.$      = jQuery
global.Panoply  = require("#{path}/panoply.js.coffee").Panoply

require "#{path}/#{lib}.js.coffee" for lib in libs