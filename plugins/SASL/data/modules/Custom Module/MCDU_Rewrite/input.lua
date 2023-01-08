-------------------------
--    MCDU Input Handler 
-------------------------



-- Create Key Datarefs
keys = {
    [0] = createGlobalPropertyi("A318/systems/mcdu/keys/key_a"),
    [1] = createGlobalPropertyi("A318/systems/mcdu/keys/key_b"),
    [2] = createGlobalPropertyi("A318/systems/mcdu/keys/key_c"),
    [3] = createGlobalPropertyi("A318/systems/mcdu/keys/key_d"),
    [4] = createGlobalPropertyi("A318/systems/mcdu/keys/key_e"),
    [5] = createGlobalPropertyi("A318/systems/mcdu/keys/key_f"),
    [6] = createGlobalPropertyi("A318/systems/mcdu/keys/key_g"),
    [7] = createGlobalPropertyi("A318/systems/mcdu/keys/key_h"),
    [8] = createGlobalPropertyi("A318/systems/mcdu/keys/key_i"),
    [9] = createGlobalPropertyi("A318/systems/mcdu/keys/key_j"),
    [10] = createGlobalPropertyi("A318/systems/mcdu/keys/key_k"),
    [11] = createGlobalPropertyi("A318/systems/mcdu/keys/key_l"),
    [12] = createGlobalPropertyi("A318/systems/mcdu/keys/key_m"),
    [13] = createGlobalPropertyi("A318/systems/mcdu/keys/key_n"),
    [14] = createGlobalPropertyi("A318/systems/mcdu/keys/key_o"),
    [15] = createGlobalPropertyi("A318/systems/mcdu/keys/key_p"),
    [16] = createGlobalPropertyi("A318/systems/mcdu/keys/key_q"),
    [17] = createGlobalPropertyi("A318/systems/mcdu/keys/key_r"),
    [18] = createGlobalPropertyi("A318/systems/mcdu/keys/key_s"),
    [19] = createGlobalPropertyi("A318/systems/mcdu/keys/key_t"),
    [20] = createGlobalPropertyi("A318/systems/mcdu/keys/key_u"),
    [21] = createGlobalPropertyi("A318/systems/mcdu/keys/key_v"),
    [22] = createGlobalPropertyi("A318/systems/mcdu/keys/key_w"),
    [23] = createGlobalPropertyi("A318/systems/mcdu/keys/key_x"),
    [24] = createGlobalPropertyi("A318/systems/mcdu/keys/key_y"),
    [25] = createGlobalPropertyi("A318/systems/mcdu/keys/key_z"),
    [26] = createGlobalPropertyi("A318/systems/mcdu/keys/key_1"),
    [27] = createGlobalPropertyi("A318/systems/mcdu/keys/key_2"),
    [28] = createGlobalPropertyi("A318/systems/mcdu/keys/key_3"),
    [29] = createGlobalPropertyi("A318/systems/mcdu/keys/key_4"),
    [30] = createGlobalPropertyi("A318/systems/mcdu/keys/key_5"),
    [31] = createGlobalPropertyi("A318/systems/mcdu/keys/key_6"),
    [32] = createGlobalPropertyi("A318/systems/mcdu/keys/key_7"),
    [33] = createGlobalPropertyi("A318/systems/mcdu/keys/key_8"),
    [34] = createGlobalPropertyi("A318/systems/mcdu/keys/key_9"),
    [35] = createGlobalPropertyi("A318/systems/mcdu/keys/key_0"),
    [36] = createGlobalPropertyi("A318/systems/mcdu/keys/key_."),
    [37] = createGlobalPropertyi("A318/systems/mcdu/keys/key_/"),
    [38] = createGlobalPropertyi("A318/systems/mcdu/keys/key_sp"),
    [39] = createGlobalPropertyi("A318/systems/mcdu/keys/key_ovfy"),
    [40] = createGlobalPropertyi("A318/systems/mcdu/keys/key_clr"),
    [41] = createGlobalPropertyi("A318/systems/mcdu/keys/key_+-")
}
keysDecoder = {
   [0] = "A",
   [1] = "B",
   [2] = "C",
   [3] = "D",
   [4] = "E",
   [5] = "F",
   [6] = "G",
   [7] = "H",
   [8] = "I",
   [9] = "J",
   [10] = "K",
   [11] = "L",
   [12] = "M",
   [13] = "N",
   [14] = "O",
   [15] = "P",
   [16] = "Q",
   [17] = "R",
   [18] = "S",
   [19] = "T",
   [20] = "U",
   [21] = "V",
   [22] = "W",
   [23] = "X",
   [24] = "Y",
   [25] = "Z",
   [26] = 1,
   [27] = 2,
   [28] = 3,
   [29] = 4,
   [30] = 5,
   [31] = 6,
   [32] = 7,
   [33] = 8,
   [34] = 9,
   [35] = 0,
   [36] = ".",
   [37] = "/",
   [38] = "s",
   [39] = "o",
   [40] = "c",
   [41] = "+-"
}

buttons = {
    [0] = createGlobalPropertyi("A318/systems/mcdu/buttons/button_l_1"),
    [1] = createGlobalPropertyi("A318/systems/mcdu/buttons/button_l_2"),
    [2] = createGlobalPropertyi("A318/systems/mcdu/buttons/button_l_3"),
    [3] = createGlobalPropertyi("A318/systems/mcdu/buttons/button_l_4"),
    [4] = createGlobalPropertyi("A318/systems/mcdu/buttons/button_l_5"),
    [5] = createGlobalPropertyi("A318/systems/mcdu/buttons/button_l_6"),
    [6] = createGlobalPropertyi("A318/systems/mcdu/buttons/button_r_1"),
    [7] = createGlobalPropertyi("A318/systems/mcdu/buttons/button_r_2"),
    [8] = createGlobalPropertyi("A318/systems/mcdu/buttons/button_r_3"),
    [9] = createGlobalPropertyi("A318/systems/mcdu/buttons/button_r_4"),
    [10] = createGlobalPropertyi("A318/systems/mcdu/buttons/button_r_5"),
    [11] = createGlobalPropertyi("A318/systems/mcdu/buttons/button_r_6"),
    [12] = createGlobalPropertyi("A318/systems/mcdu/page/DIR"),
    [13] = createGlobalPropertyi("A318/systems/mcdu/page/PROG"),
    [14] = createGlobalPropertyi("A318/systems/mcdu/page/PERF"),
    [15] = createGlobalPropertyi("A318/systems/mcdu/page/INIT"),
    [16] = createGlobalPropertyi("A318/systems/mcdu/page/DATA"),
    [17] = createGlobalPropertyi("A318/systems/mcdu/page/F-PLN"),
    [18] = createGlobalPropertyi("A318/systems/mcdu/page/RAD_NAV"),
    [19] = createGlobalPropertyi("A318/systems/mcdu/page/FUEL_PRED"),
    [20] = createGlobalPropertyi("A318/systems/mcdu/page/SEC_F-PLN"),
    [21] = createGlobalPropertyi("A318/systems/mcdu/page/ATC_COMM"),
    [22] = createGlobalPropertyi("A318/systems/mcdu/page/MCDU_MENU"),
    [23] = createGlobalPropertyi("A318/systems/mcdu/page/AIRPORT"),
    [24] = createGlobalPropertyi("A318/systems/mcdu/page/ARROW_LEFT"),
    [25] = createGlobalPropertyi("A318/systems/mcdu/page/ARROW_UP"),
    [26] = createGlobalPropertyi("A318/systems/mcdu/page/ARROW_RIGHT"),
    [27] = createGlobalPropertyi("A318/systems/mcdu/page/ARROW_DOWN"),
}


function checkForPress(keys)
    for i = 0, 41 do -- Check the keys
        if get(keys[i]) == 1 then
            return i
        end
    end
    return -1
end

function checkForPress(button)
    for i = 0, 41 do -- Check the keys
        if get(button[i]) == 1 then
            return i
        end
    end
    return -1
end
