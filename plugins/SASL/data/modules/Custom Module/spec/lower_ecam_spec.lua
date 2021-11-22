describe('lower_ecam', function()
    local datarefs = {}
    
    before_each(function()
        _G.sasl = {}
        _G.globalProperty = function(dataref) return dataref end
        _G.globalPropertyi = function(dataref) return dataref end
        _G.globalPropertyia = function(dataref) return dataref end
        _G.createGlobalPropertyi = function(dataref) return dataref end
        _G.createGlobalPropertyia = function(dataref) return dataref end
        _G.globalPropertyf = function(dataref) return dataref end
        _G.globalPropertyfa = function(dataref) return dataref end
        _G.createGlobalPropertyf = function(dataref) return dataref end
        _G.createGlobalPropertyfa = function(dataref) return dataref end
    
        _G.sasl.gl = {}
        _G.sasl.gl.loadFont = function(path) end
        _G.sasl.gl.loadImage = function(path) end
        _G.sasl.gl.setFontRenderMode = function() end

        _G.get = function(dataref, index)
            return datarefs[dataref](index)
        end
        _G.set = function(dataref, value)
            print(dataref)
            datarefs[dataref] = function() return value end
        end
        require('../lower_ecam')
        datarefs['sim/cockpit2/engine/indicators/fuel_flow_kg_sec'] = function(index) return 1 end
        datarefs['sim/cockpit2/gauges/indicators/vvi_fpm_pilot'] = function() return 0 end
        datarefs['sim/flightmodel2/engines/engine_is_burning_fuel'] = function(index) return 0 end
        datarefs['A318/cockpit/ecam/flight_phase'] = function() return 1 end
    end)

    describe('update', function()
        test('something', function()
            update()
            assert.True(1 == 1)
        end)
    end)

    local isa_test_cases = {
        {['alt'] = 42145, ['expected'] = -56.5},
        {['alt'] = 37100, ['expected'] = -56.5},
        {['alt'] = 36000, ['expected'] = -56.3},
        {['alt'] = 26000, ['expected'] = -36.5},
        {['alt'] = 18250, ['expected'] = -20.6}
    }
    describe('calculating ISA', function()
        for k, v in pairs(isa_test_cases) do
            test('for altitude ' .. v.alt, function()
                datarefs['sim/cockpit2/gauges/indicators/altitude_ft_pilot'] = function() return v.alt end
                assert.are.equal(v.expected, get_isa())
            end)
        end
    end)
end)