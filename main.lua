#! /usr/bin/env lua

require "modules.init"
require "json"

for x in pairs (_G) do
    print ( x )
end