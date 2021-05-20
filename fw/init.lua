#! /usr/bin/env lua

print (package.config)
print (package.cpath)
print (package.path)
print (package.loaded)
print (package.preload)
print (package.searchers)

-- local __package_loaded = [
--     "io",
--     "table",
--     "string",
--     "os",
--     "coroutine",
--     "bit32",
--     "package",
--     "debug",
--     "_G",
--     "math",
--     "utf8"
-- ]

-- [ "currentline", "func", "istailcall", "what", "isvararg", "lastlinedefined", "nups", "source", "namewhat", "nparams", "short_src", "linedefined" ]

local __searchers = coroutine.create ( function (e)
    for _, x in pairs ( package.searchers ) do
        coroutine.yield ( x )
    end
end )

local __bool, fn = coroutine.resume ( __searchers )

print ( debug.getinfo ( fn ) .currentline )
print ( debug.getinfo ( fn ) .func )
print ( debug.getinfo ( fn ) .istailcall )
print ( debug.getinfo ( fn ) .what )
print ( debug.getinfo ( fn ) .isvararg )
print ( debug.getinfo ( fn ) .lastlinedefined )
print ( debug.getinfo ( fn ) .nups )
print ( debug.getinfo ( fn ) .source )
print ( debug.getinfo ( fn ) .namewhat )
print ( debug.getinfo ( fn ) .nparams )
print ( debug.getinfo ( fn ) .short_src )
print ( debug.getinfo ( fn ) .linedefined )


-- "[C]", "stdin" short_src
--package.loadlib
--package.searchpath