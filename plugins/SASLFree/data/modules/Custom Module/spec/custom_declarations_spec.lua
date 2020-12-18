describe('common_declarations', function()
    local datarefs = {}

    local setVsi = function(vsi)
        datarefs['sim/cockpit2/gauges/indicators/vvi_fpm_pilot'] = function() return vsi end
    end

    before_each(function()
        _G.sasl = {}
        _G.globalPropertyi = function(dataref) return dataref end
        _G.createGlobalPropertyi = function(dataref) return dataref end
        _G.createGlobalPropertyia = function(dataref) return dataref end
        _G.globalPropertyf = function(dataref) return dataref end
        _G.createGlobalPropertyf = function(dataref) return dataref end
        _G.createGlobalPropertyfa = function(dataref) return dataref end
    
        _G.sasl.gl = {}
        _G.sasl.gl.loadFont = function(path) end

        _G.get = function(dataref) return datarefs[dataref]() end
        require('../common_declarations')
        datarefs['A318/efb/config/units'] = function() return units.metric end
    end)

    describe('get_weight', function()
        test('in kgs', function()
            assert.are.equal(100, get_weight(100))
        end)

        test('in lbs', function()
            datarefs['A318/efb/config/units'] = function() return units.imperial end
            assert.are.equal(220, math.floor(get_weight(100)))
        end)
    end)

    describe('get_temp', function()
        test('in celsius', function()
            assert.are.equal(18, get_temp(18))
        end)
        test('in farenheit', function()
            datarefs['A318/efb/config/units'] = function() return units.imperial end
            assert.are.equal(64.4, get_temp(18))
        end)
    end)

    describe('get_vsi', function()
        test('0', function()
            setVsi(0)
            assert.are.same({
                ['blink'] = false,
                ['colour'] = ECAM_COLOURS['GREEN'],
                ['value'] = 0
            }, get_vsi())
        end)
        test('1800', function()
            setVsi(1800)
            assert.are.same({
                ['blink'] = true,
                ['colour'] = ECAM_COLOURS['GREEN'],
                ['value'] = 1800
            }, get_vsi())
        end)
    end)
end)