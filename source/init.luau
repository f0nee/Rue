_G.__internal_debug = function(message) 
    if _G.debug then
        warn("[Rue]: " .. message .. " (At Time: " .. os.time() .. ")")
    end
end