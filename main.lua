local function parent_dir(str)
    return str:match("(.*)[/\\]")
end
local script_folder = parent_dir(debug.getinfo(1).source)
local log_folder = parent_dir(parent_dir(script_folder)) .. '/' .. 'mpv-history'

local o = {
    log_folder_path = log_folder, -- path to write logs to
    period_secs = 5, -- between heartbeats
}

local options = require 'mp.options'
options.read_options(o)

local utils = require 'mp.utils'

local function get_log()
    return log_folder .. '/' .. os.date('!%Y-%m-%d') .. '.log'
end

local function timestamp()
    return os.date('!%Y-%m-%dT%H:%M:%SZ') -- that's all the precision os.date can do - no millis...
end

local function basic()
    return {
        ['time'] = timestamp(),
        ['filename'] = mp.get_property('filename'),
        ['title'] = mp.get_property('media-title')
    }
end

local function merge(a, b)
    local c = {}
    for k, v in pairs(a) do c[k] = v end
    for k, v in pairs(b) do c[k] = v end
    return c
end

local function send_heartbeat()
    local paused = mp.get_property_bool("pause")
    if (paused ~= false) then return end
    local data = merge(basic(),
        {
            ['kind'] = 'playing',
            -- ['length'] = mp.get_property('duration'),
            -- ['pos'] = mp.get_property('time-pos'),
        }
    )
    local logfile = io.open(get_log(), 'a+');
    logfile:write(utils.format_json(data) .. '\n');
    logfile:close();
end

local heartbeat_timer = mp.add_periodic_timer(o.period_secs, send_heartbeat)
