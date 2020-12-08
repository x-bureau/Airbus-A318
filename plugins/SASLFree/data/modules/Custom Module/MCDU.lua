------------------------------------------------------------------
--Airbus A318 by X-Bureau--
--MCDU

--Written By:
--FBI914
------------------------------------------------------------------
position = {505, 1543, 510, 410}
size = {510, 410}
------------------------------------------------------------------
--Defining Variables
------------------------------------------------------------------
--Defining all the MCDU keys
local MCDU_KEY_A = createGlobalPropertyi("A318/cockpit/mcdu/keys/a", 0)--Define the A key of the MCDU, Value goes to 1 when pushed.
local MCDU_KEY_B = createGlobalPropertyi("A318/cockpit/mcdu/keys/b", 0)--Define the B key of the MCDU, Value goes to 1 when pushed.
local MCDU_KEY_C = createGlobalPropertyi("A318/cockpit/mcdu/keys/c", 0)--Define the C key of the MCDU, Value goes to 1 when pushed.
local MCDU_KEY_D = createGlobalPropertyi("A318/cockpit/mcdu/keys/d", 0)--Define the D key of the MCDU, Value goes to 1 when pushed.
local MCDU_KEY_E = createGlobalPropertyi("A318/cockpit/mcdu/keys/e", 0)--Define the E key of the MCDU, Value goes to 1 when pushed.
local MCDU_KEY_F = createGlobalPropertyi("A318/cockpit/mcdu/keys/f", 0)--Define the F key of the MCDU, Value goes to 1 when pushed.
local MCDU_KEY_G = createGlobalPropertyi("A318/cockpit/mcdu/keys/g", 0)--Define the G key of the MCDU, Value goes to 1 when pushed.
local MCDU_KEY_H = createGlobalPropertyi("A318/cockpit/mcdu/keys/h", 0)--Define the H key of the MCDU, Value goes to 1 when pushed.
local MCDU_KEY_I = createGlobalPropertyi("A318/cockpit/mcdu/keys/i", 0)--Define the I key of the MCDU, Value goes to 1 when pushed.
local MCDU_KEY_J = createGlobalPropertyi("A318/cockpit/mcdu/keys/j", 0)--Define the J key of the MCDU, Value goes to 1 when pushed.
local MCDU_KEY_K = createGlobalPropertyi("A318/cockpit/mcdu/keys/k", 0)--Define the K key of the MCDU, Value goes to 1 when pushed.
local MCDU_KEY_L = createGlobalPropertyi("A318/cockpit/mcdu/keys/l", 0)--Define the L key of the MCDU, Value goes to 1 when pushed.
local MCDU_KEY_M = createGlobalPropertyi("A318/cockpit/mcdu/keys/m", 0)--Define the M key of the MCDU, Value goes to 1 when pushed.
local MCDU_KEY_N = createGlobalPropertyi("A318/cockpit/mcdu/keys/n", 0)--Define the N key of the MCDU, Value goes to 1 when pushed.
local MCDU_KEY_O = createGlobalPropertyi("A318/cockpit/mcdu/keys/o", 0)--Define the O key of the MCDU, Value goes to 1 when pushed.
local MCDU_KEY_P = createGlobalPropertyi("A318/cockpit/mcdu/keys/p", 0)--Define the P key of the MCDU, Value goes to 1 when pushed.
local MCDU_KEY_Q = createGlobalPropertyi("A318/cockpit/mcdu/keys/q", 0)--Define the Q key of the MCDU, Value goes to 1 when pushed.
local MCDU_KEY_R = createGlobalPropertyi("A318/cockpit/mcdu/keys/r", 0)--Define the R key of the MCDU, Value goes to 1 when pushed.
local MCDU_KEY_S = createGlobalPropertyi("A318/cockpit/mcdu/keys/s", 0)--Define the S key of the MCDU, Value goes to 1 when pushed.
local MCDU_KEY_T = createGlobalPropertyi("A318/cockpit/mcdu/keys/t", 0)--Define the T key of the MCDU, Value goes to 1 when pushed.
local MCDU_KEY_U = createGlobalPropertyi("A318/cockpit/mcdu/keys/u", 0)--Define the U key of the MCDU, Value goes to 1 when pushed.
local MCDU_KEY_V = createGlobalPropertyi("A318/cockpit/mcdu/keys/v", 0)--Define the V key of the MCDU, Value goes to 1 when pushed.
local MCDU_KEY_W = createGlobalPropertyi("A318/cockpit/mcdu/keys/w", 0)--Define the W key of the MCDU, Value goes to 1 when pushed.
local MCDU_KEY_X = createGlobalPropertyi("A318/cockpit/mcdu/keys/x", 0)--Define the X key of the MCDU, Value goes to 1 when pushed.
local MCDU_KEY_Y = createGlobalPropertyi("A318/cockpit/mcdu/keys/y", 0)--Define the Y key of the MCDU, Value goes to 1 when pushed.
local MCDU_KEY_Z = createGlobalPropertyi("A318/cockpit/mcdu/keys/z", 0)--Define the Z key of the MCDU, Value goes to 1 when pushed.

--LINE SELECTOR BUTTONS (LEFT)
local MCDU_LINE_L_1 = createGlobalPropertyi("A318/cockpit/mcdu/keys/line_l_1", 0)--Define the LEFT 1st LINE SELECTOR key of the MCDU, Value goes to 1 when pushed.
local MCDU_LINE_L_2 = createGlobalPropertyi("A318/cockpit/mcdu/keys/line_l_2", 0)--Define the LEFT 2nd LINE SELECTOR key of the MCDU, Value goes to 1 when pushed.
local MCDU_LINE_L_3 = createGlobalPropertyi("A318/cockpit/mcdu/keys/line_l_3", 0)--Define the LEFT 3rd LINE SELECTOR key of the MCDU, Value goes to 1 when pushed.
local MCDU_LINE_L_4 = createGlobalPropertyi("A318/cockpit/mcdu/keys/line_l_4", 0)--Define the LEFT 4th LINE SELECTOR key of the MCDU, Value goes to 1 when pushed.
local MCDU_LINE_L_5 = createGlobalPropertyi("A318/cockpit/mcdu/keys/line_l_5", 0)--Define the LEFT 5th LINE SELECTOR key of the MCDU, Value goes to 1 when pushed.
local MCDU_LINE_L_6 = createGlobalPropertyi("A318/cockpit/mcdu/keys/line_l_6", 0)--Define the LEFT 6th LINE SELECTOR key of the MCDU, Value goes to 1 when pushed.
--LINE SELECTOR BUTTONS (RIGHT)
local MCDU_LINE_R_1 = createGlobalPropertyi("A318/cockpit/mcdu/keys/line_r_1", 0)--Define the RIGHT 1st LINE SELECTOR key of the MCDU, Value goes to 1 when pushed.
local MCDU_LINE_R_2 = createGlobalPropertyi("A318/cockpit/mcdu/keys/line_r_2", 0)--Define the RIGHT 2nd LINE SELECTOR key of the MCDU, Value goes to 1 when pushed.
local MCDU_LINE_R_3 = createGlobalPropertyi("A318/cockpit/mcdu/keys/line_r_3", 0)--Define the RIGHT 3rd LINE SELECTOR key of the MCDU, Value goes to 1 when pushed.
local MCDU_LINE_R_4 = createGlobalPropertyi("A318/cockpit/mcdu/keys/line_r_4", 0)--Define the RIGHT 4th LINE SELECTOR key of the MCDU, Value goes to 1 when pushed.
local MCDU_LINE_R_5 = createGlobalPropertyi("A318/cockpit/mcdu/keys/line_r_5", 0)--Define the RIGHT 5th LINE SELECTOR key of the MCDU, Value goes to 1 when pushed.
local MCDU_LINE_R_6 = createGlobalPropertyi("A318/cockpit/mcdu/keys/line_r_6", 0)--Define the RIGHT 6th LINE SELECTOR key of the MCDU, Value goes to 1 when pushed.

local MCDU_CURRENT_PAGE = createGlobalPropertyi("A318/cockpit/mcdu/current_page", 1)--0 is the template page. WILL BE REMOVED AFTER TESTING

--PAGE LABELS
local R_label_1 = "label 1"
local R_label_2 = "label 2"
local R_label_3 = "label 3"
local R_label_4 = "label 4"
local R_label_5 = "label 5"
local R_label_6 = "label 6"
local L_label_1 = "label 1"
local L_label_2 = "label 2"
local L_lable_3 = "label 3"
local L_label_4 = "label 4"
local L_label_5 = "label 5"
local L_label_6 = "label 6"

local R_data_1 = "DATA 1"
local R_data_2 = "DATA 1"
local R_data_3 = "DATA 1"
local R_data_4 = "DATA 1"
local R_data_5 = "DATA 1"
local R_data_6 = "DATA 1"
local L_data_1 = "DATA 1"
local L_data_2 = "DATA 1"
local L_data_3 = "DATA 1"
local L_data_4 = "DATA 1"
local L_data_5 = "DATA 1"
local L_data_6 = "DATA 1"

local MCDU_GREEN = {0, 1.0, 0}
local MCDU_WHITE = {0, 1.0, 0}
local AIRBUS_FONT = sasl.gl.loadFont("panel_font.ttf")

-----------------------------------------
--Setting up the pages
-----------------------------------------
--Drawing the page
local function drawPage()
	--DRAWING THE DATA
	if get(L_data_1) != null then
		sasl.gl.drawText(AIRBUS_FONT, 15, 350, get(L_data_1), TEXT_ALIGN_LEFT, MCDU_GREEN)
	end
	if get(L_data_2) != null then
		sasl.gl.drawText(AIRBUS_FONT, 15, 300, get(L_data_2), TEXT_ALIGN_LEFT, MCDU_GREEN)
	end
	if get(L_data_3) != null then
		sasl.gl.drawText(AIRBUS_FONT, 15, 250, get(L_data_3), TEXT_ALIGN_LEFT, MCDU_GREEN)
	end
	if get(L_data_4) != null then
		sasl.gl.drawText(AIRBUS_FONT, 15, 200, get(L_data_4), TEXT_ALIGN_LEFT, MCDU_GREEN)
	end
	if get(L_data_5) != null then
		sasl.gl.drawText(AIRBUS_FONT, 15, 150, get(L_data_5), TEXT_ALIGN_LEFT, MCDU_GREEN)
	end
	if get(L_data_6) != null then
		sasl.gl.drawText(AIRBUS_FONT, 15, 100, get(L_data_6), TEXT_ALIGN_LEFT, MCDU_GREEN)
	end
	if get(R_data_1) != null then
		sasl.gl.drawText(AIRBUS_FONT, 410, 350, get(R_data_1), TEXT_ALIGN_LEFT, MCDU_GREEN)
	end
	if get(R_data_2) != null then
		sasl.gl.drawText(AIRBUS_FONT, 410, 300, get(R_data_2), TEXT_ALIGN_LEFT, MCDU_GREEN)
	end
	if get(R_data_3) != null then
		sasl.gl.drawText(AIRBUS_FONT, 410, 250, get(R_data_3), TEXT_ALIGN_LEFT, MCDU_GREEN)
	end
	if get(R_data_4) != null then
		sasl.gl.drawText(AIRBUS_FONT, 410, 200, get(R_data_4), TEXT_ALIGN_LEFT, MCDU_GREEN)
	end
	if get(R_data_5) != null then
		sasl.gl.drawText(AIRBUS_FONT, 410, 150, get(R_data_5), TEXT_ALIGN_LEFT, MCDU_GREEN)
	end
	if get(R_data_6) != null then
		sasl.gl.drawText(AIRBUS_FONT, 410, 100, get(R_data_6), TEXT_ALIGN_LEFT, MCDU_GREEN)
	end
	--DRAWING THE LABELS
	if get(R_label_1) != null then
		sasl.gl.drawText(AIRBUS_FONT, 410, 370, get(L_label_1), TEXT_ALIGN_LEFT, MCDU_WHITE)
	end
	if get(R_label_2) != null then
		sasl.gl.drawText(AIRBUS_FONT, 410, 320, get(L_label_2), TEXT_ALIGN_LEFT, MCDU_WHITE)
	end
	if get(R_label_3) != null then
		sasl.gl.drawText(AIRBUS_FONT, 410, 270, get(L_label_3), TEXT_ALIGN_LEFT, MCDU_WHITE)
	end
	if get(R_label_4) != null then
		sasl.gl.drawText(AIRBUS_FONT, 410, 220, get(L_label_4), TEXT_ALIGN_LEFT, MCDU_WHITE)
	end
	if get(R_label_5) != null then
		sasl.gl.drawText(AIRBUS_FONT, 410, 170, get(L_label_5), TEXT_ALIGN_LEFT, MCDU_WHITE)
	end
	if get(R_label_6) != null then
		sasl.gl.drawText(AIRBUS_FONT, 410, 120, get(L_label_6), TEXT_ALIGN_LEFT, MCDU_WHITE)
	end
	if get(L_label_1) != null then
		sasl.gl.drawText(AIRBUS_FONT, 15, 370, get(R_label_1), TEXT_ALIGN_LEFT, MCDU_WHITE)
	end
	if get(L_label_2) != null then
		sasl.gl.drawText(AIRBUS_FONT, 15, 320, get(R_label_2), TEXT_ALIGN_LEFT, MCDU_WHITE)
	end
	if get(L_label_3) != null then
		sasl.gl.drawText(AIRBUS_FONT, 15, 270, get(R_label_3), TEXT_ALIGN_LEFT, MCDU_WHITE)
	end
	if get(L_label_4) != null then
		sasl.gl.drawText(AIRBUS_FONT, 15, 220, get(R_label_4), TEXT_ALIGN_LEFT, MCDU_WHITE)
	end
	if get(L_label_5) != null then
		sasl.gl.drawText(AIRBUS_FONT, 15, 170, get(R_label_5), TEXT_ALIGN_LEFT, MCDU_WHITE)
	end
	if get(L_label_6) != null then
		sasl.gl.drawText(AIRBUS_FONT, 15, 120, get(R_label_6), TEXT_ALIGN_LEFT, MCDU_WHITE)
	end
end

--if get(MCDU_CURRENT_PAGE) == 0

if get(MCDU_CURRENT_PAGE) == 1 --MENU Page of the MCDU
	local R_label_1 = null
	local R_label_2 = null
	local R_label_3 = null
	local R_label_4 = null
	local R_label_5 = null
	local R_label_6 = null
	local L_label_1 = null
	local L_label_2 = null
	local L_lable_3 = null
	local L_label_4 = null
	local L_label_5 = null
	local L_label_6 = null

	local R_data_1 = null
	local R_data_2 = null
	local R_data_3 = null
	local R_data_4 = null
	local R_data_5 = null
	local R_data_6 = "Return>"
	local L_data_1 = "<FMGC"
	local L_data_2 = "<DATA LINK"
	local L_data_3 = "<AIDS"
	local L_data_4 = "CFDS [REQ]"
	local L_data_5 = null
	local L_data_6 = null

	if get(MCDU_LINE_L_1) == 1 then
		set(MCDU_CURRENT_PAGE) == 2 --FMGS PAGE
	end

	if get(MCDU_LINE_L_2) == 1 then
		set(MCDU_CURRENT_PAGE) == 3 --DATA LINK PAGE
	end

	if get(MCDU_LINE_L_3) == 1 then
		set(MCDU_CURRENT_PAGE) == 4 --AIDS PAGE
	end

	if get(MCDU_LINE_L_3) == 1 then
		set(MCDU_CURRENT_PAGE) == 5 --CFDS PAGE
	end
end


function draw()
	drawPage()
end

