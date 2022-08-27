local plugin = {
    PRIORITY = 1000, -- set the plugin priority, which determines plugin execution order
    VERSION = "0.1", -- version in X.Y.Z format. Check hybrid-mode compatibility requirements.
  }
  

  
  

  function plugin:access(plugin_conf)

    kong.log.info("http redirect plugin begin")
    local current_timestamp = os.time(os.date("!*t"))
    kong.log.info("PLUGIN START TIME" .. os.date("%X",current_timestamp) )



    if plugin_conf.enabled == false or kong.request.get_scheme() == "https" then
        kong.log.info("Https is already been enabled on this route")
        return
    end

    local redirection_url = "https://" .. kong.request.get_host()
    kong.log.info('redirecting to url:' .. redirection_url)



 -- Note Time calculation is done in seconds . if you requires milli seconds use clock module .This would require you to load posix and socket libraries in kongs
    
    kong.log.info("http redirect plugin end")
    local end_timestamp = os.time(os.date("!*t"))
    kong.log.info("PLUGIN END TIME" .. os.date("%X",end_timestamp) )
    local time_elapsed = end_timestamp - current_timestamp
    kong.log.info("Time take to execute this Plugin" .. os.date("%X",time_elapsed) )


    return ngx.redirect(redirection_url, plugin_conf.redirection_status_code)
end

return plugin
