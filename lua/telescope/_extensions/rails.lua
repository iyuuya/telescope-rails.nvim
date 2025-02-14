local actions = require "telescope.actions"
local finders = require "telescope.finders"
local pickers = require "telescope.pickers"
local conf = require("telescope.config").values
local entry_display = require "telescope.pickers.entry_display"
local action_state = require "telescope.actions.state"

function path_to_display_name(file, target_path)
  path_without_prefix = file:sub(#target_path + 2)

  return path_without_prefix
end

local displayer = entry_display.create {
  separator = " ",
  items = {
    { remaining = true },
  },
}

local make_display = function(table)
  return displayer {
    table.ordinal,
  }
end

local find_rails = function(target, target_path, opts)
  opts = opts or {}
  pickers
      .new(opts, {
        prompt_title = target,
        finder = finders.new_oneshot_job({
          "find",
          target_path,
          "-type",
          "f",
        }, {
          entry_maker = function(file)
            local path_without_prefix = path_to_display_name(file, target_path)
            return {
              value = file,
              display = function(table)
                return make_display(table)
              end,
              ordinal = path_without_prefix,
              path = file,
            }
          end,
        }),
        sorter = conf.generic_sorter(opts),
      })
      :find()
end

local find_models = function(opts)
  find_rails("models", "app/models", opts)
end

local find_libs = function(opts)
  find_rails("libs", "lib", opts)
end

local find_migrations = function(opts)
  find_rails("migrations", "db/migrate", opts)
end

local find_controllers = function(opts)
  find_rails("controllers", "app/controllers", opts)
end

local find_specs = function(opts)
  find_rails("specs", "spec", opts)
end

local find_views = function(opts)
  find_rails("views", "app/views", opts)
end

function gen_find_app_fn(dir)
  return function(opts)
    find_rails(dir, "app/" + dir, opts)
  end
end

return require("telescope").register_extension {
  exports = {
    models = find_models,
    controllers = find_controllers,
    libs = find_libs,
    migrations = find_migrations,
    specs = find_specs,
    views = find_views,

    assets = function(opts) find_rails("assets", "app/assets", opts) end,
    batches = function(opts) find_rails("batches", "app/batches", opts) end,
    callbacks = function(opts) find_rails("callbacks", "app/callbacks", opts) end,
    channels = function(opts) find_rails("channels", "app/channels", opts) end,
    components = function(opts) find_rails("components", "app/components", opts) end,
    decorators = function(opts) find_rails("decorators", "app/decorators", opts) end,
    finders = function(opts) find_rails("finders", "app/finders", opts) end,
    forms = function(opts) find_rails("forms", "app/forms", opts) end,
    helpers = function(opts) find_rails("helpers", "app/helpers", opts) end,
    javascript = function(opts) find_rails("javascript", "app/javascript", opts) end,
    jobs = function(opts) find_rails("jobs", "app/jobs", opts) end,
    mailers = function(opts) find_rails("mailers", "app/mailers", opts) end,
    policies = function(opts) find_rails("policies", "app/policies", opts) end,
    queries = function(opts) find_rails("queries", "app/queries", opts) end,
    serializers = function(opts) find_rails("serializers", "app/serializers", opts) end,
    services = function(opts) find_rails("services", "app/services", opts) end,
    validators = function(opts) find_rails("validators", "app/validators", opts) end,
    view_models = function(opts) find_rails("view_models", "app/view_models", opts) end,

    graphql = function(opts) find_rails("graphql", "app/graphql", opts) end,
    graphql_mutations = function(opts) find_rails("graphql mutations", "app/graphql/mutations", opts) end,
    graphql_resolvers = function(opts) find_rails("graphql resolvers", "app/graphql/resolvers", opts) end,
    graphql_sources = function(opts) find_rails("graphql sources", "app/graphql/sources", opts) end,
    graphql_types = function(opts) find_rails("graphql types", "app/graphql/types", opts) end,
  },
}
