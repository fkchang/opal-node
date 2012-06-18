version    = '0.3.19'
extensions = ['.opal', '.rb']

execSync     = require('exec-sync')
exports.Opal = require("./opal-#{version}").Opal

compile = (filename) ->
  return execSync("opal _#{version}_ #{filename}")

for extension in extensions
  require.extensions[extension] = (module, filename) ->
    content = "var Opal = require('opal').Opal;"+
              "Opal.require = require;"+
              compile(filename)
    module._compile(content, filename)
