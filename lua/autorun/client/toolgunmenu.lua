// EASY TOOLGUN USE

// Message
MsgN( "\nEASY TOOLGUN MENU - VERISION 0.5" )
MsgN( "\nMade by Walker [JB] TR" )

// Vars
local ToolName = {}
local ToolCommand = {}
local UserToolName = {}
local UserToolCommand = {}
local UserUnsaveToolName = {}
local UserUnsaveToolCommand = {}
local KeyListOptions = {}
local KeyListMenu = {}
local Data = {}
local jsonTable = {}
local jsonTable2 = {}
local FoundToolNum = 0
local MenuToolNum = 0
local DeleteCount = 0

// Get Key List Options
KeyListOptions[1] = {"Mouse 3",MOUSE_MIDDLE,"Mouse"}
KeyListOptions[2] = {"F1",KEY_F1,"Key"}
KeyListOptions[3] = {"F2",KEY_F2,"Key"}
KeyListOptions[4] = {"F3",KEY_F3,"Key"}
KeyListOptions[5] = {"F4",KEY_F4,"Key"}
KeyListOptions[6] = {"F5",KEY_F5,"Key"}
KeyListOptions[7] = {"F6",KEY_F6,"Key"}
KeyListOptions[8] = {"F7",KEY_F7,"Key"}
KeyListOptions[9] = {"F8",KEY_F8,"Key"}
KeyListOptions[10] = {"F9",KEY_F9,"Key"}
KeyListOptions[11] = {"F10",KEY_F10,"Key"}
KeyListOptions[12] = {"F11",KEY_F11,"Key"}
KeyListOptions[13] = {"F12",KEY_F12,"Key"}

//Get Key List Menu
KeyListMenu[1] = {"Mouse 3",MOUSE_MIDDLE,"Mouse"}
KeyListMenu[2] = {"F1",KEY_F1,"Key"}
KeyListMenu[3] = {"F2",KEY_F2,"Key"}
KeyListMenu[4] = {"F3",KEY_F3,"Key"}
KeyListMenu[5] = {"F4",KEY_F4,"Key"}
KeyListMenu[6] = {"F5",KEY_F5,"Key"}
KeyListMenu[7] = {"F6",KEY_F6,"Key"}
KeyListMenu[8] = {"F7",KEY_F7,"Key"}
KeyListMenu[9] = {"F8",KEY_F8,"Key"}
KeyListMenu[10] = {"F9",KEY_F9,"Key"}
KeyListMenu[11] = {"F10",KEY_F10,"Key"}
KeyListMenu[12] = {"F11",KEY_F11,"Key"}
KeyListMenu[13] = {"F12",KEY_F12,"Key"}

//Data
Data[1] = "1" //KeyListMenu
Data[2] = "2" //KeyListOptions

//ToolData

// User Settings
file.CreateDir("toolgunmenu")

file.Append("toolgunmenu/tooldata.txt","")
if file.Read("toolgunmenu/tooldata.txt")=="" then
    file.Write("toolgunmenu/tooldata.txt", '{"1":{"1":"weld","2":"rope","3":"elastic","4":"light","5":"remover"},"2":{"1":"gmod_tool weld","2":"gmod_tool rope","3":"gmod_tool elastic","4":"gmod_tool light","5":"gmod_tool remover"}}')
end

file.Append("toolgunmenu/data.txt","")
if file.Read("toolgunmenu/data.txt")=="" then
    file.Write("toolgunmenu/data.txt", util.TableToJSON(Data))
end
    Data = util.JSONToTable(file.Read("toolgunmenu/data.txt","DATA"))
    jsonTable = util.JSONToTable(file.Read("toolgunmenu/tooldata.txt", "DATA"))
    UserToolName = jsonTable[1]
    UserToolCommand = jsonTable[2]
local MenuToolNum = #UserToolName

// Fonts
surface.CreateFont("MenuHeader",
{
font = "coolvetica",
size = 20,
weight = 400,
antialiasing = true,
additive = false
})

surface.CreateFont("MenuAllert",
{
font = "coolvetica",
size = 17,
weight = 10,
antialiasing = true,
additive = false
})

surface.CreateFont("ToolsTextFont",
{
font = "arial",
size = 15,
weight = 400,
antialiasing = true,
additive = false
})

// Menu Open
function toolgunoptionspanel()  
    ToolName = {}
    ToolCommand = {}
    FoundToolNum = 0
    ToolName[#ToolName+1] = "Physics Gun"
    ToolCommand[#ToolCommand+1] = "use weapon_physgun"
    ToolName[#ToolName+1] = "Gravity Gun"
    ToolCommand[#ToolCommand+1] = "use weapon_physcannon"
    for k1,v1 in pairs(spawnmenu.GetTools()) do
        for k, v in ipairs(spawnmenu.GetTools()[k1].Items) do
            //print ("-- Found Category ("..v.ItemName..") \n")
            for k2, v2 in ipairs(spawnmenu.GetTools()[k1].Items[k]) do
                if v2.Command != "" then
                    FoundToolNum = FoundToolNum + 1
                    //print ("-- Found Tool ("..v2.ItemName..") \n")
                    if string.ToTable(v.Text)[1] != "#" then
                        ToolName[#ToolName+1] = v2.Text
                    else
                        ToolName[#ToolName+1] = v2.ItemName
                    end
                    ToolCommand[#ToolCommand+1] = v2.Command
                end
            end
        end
    end
    local InstalledToolNum = #ToolName
  
    ToolgunOptionsPanel = vgui.Create("DFrame")
    ToolgunOptionsPanel:SetPos(ScrW()/2-400,0)
    ToolgunOptionsPanel:SetSize(800, 700)
    ToolgunOptionsPanel:ShowCloseButton(false)
    ToolgunOptionsPanel:SetDraggable(false)
    ToolgunOptionsPanel:SetTitle("Options")
    ToolgunOptionsPanel:MakePopup()
    ToolgunOptionsPanel.Paint = function()
        surface.SetDrawColor( 50, 50, 50, 200 )
        surface.DrawRect( 0, 0, ToolgunOptionsPanel:GetWide(), ToolgunOptionsPanel:GetTall() )
        
        surface.SetTextColor( 255, 255, 255, 255 )
        surface.SetFont("MenuHeader")
        surface.SetTextPos( 50, 30 ) 
        surface.DrawText( "INSTALLED TOOLS" )
        surface.SetTextPos( 450, 30 ) 
        surface.DrawText( "MENU TOOLS" )
        surface.SetTextPos( 450, 480 ) 
        surface.DrawText( "MENU OPTIONS" )
        
        surface.SetFont("MenuAllert")
        surface.SetTextPos( 50, 45 ) 
        surface.DrawText( "Double Click To Move" )
        surface.SetTextPos( 450, 45 ) 
        surface.DrawText( "Double Click To Remove" )
        surface.SetTextPos( 450, 495 ) 
        surface.DrawText( "Change Options" )
        
        surface.SetDrawColor( 150, 150, 150, 200)
        surface.DrawRect( 450, 515, 300, 150 )
    end
    
    // Change Menu Key
    local ToolgunOptionsPanelChangeMenuKey = vgui.Create("DButton")
    ToolgunOptionsPanelChangeMenuKey:SetParent( ToolgunOptionsPanel )
    ToolgunOptionsPanelChangeMenuKey:SetText( "Radial Tool Menu Key (".. KeyListMenu[tonumber(Data[1])][1] ..")" )
    ToolgunOptionsPanelChangeMenuKey:SetPos(455, 520)
    ToolgunOptionsPanelChangeMenuKey:SetSize( 290, 20 )
    ToolgunOptionsPanelChangeMenuKey.DoClick = function ( btn )
    local ToolgunOptionsPanelChangeMenuKeyOptions = DermaMenu() -- Creates the menu
    for i=1, #KeyListMenu do
        ToolgunOptionsPanelChangeMenuKeyOptions:AddOption(KeyListMenu[i][1], function() Data[1] = i file.Write("toolgunmenu/data.txt", util.TableToJSON(Data)) end )
    end
    ToolgunOptionsPanelChangeMenuKeyOptions:Open()
    end

    // Change Options Key
    local ToolgunOptionsPanelChangeOptionsKey = vgui.Create("DButton")
    ToolgunOptionsPanelChangeOptionsKey:SetParent( ToolgunOptionsPanel )
    ToolgunOptionsPanelChangeOptionsKey:SetText( "Options Key (".. KeyListOptions[tonumber(Data[2])][1] ..")" )
    ToolgunOptionsPanelChangeOptionsKey:SetPos(455,545)
    ToolgunOptionsPanelChangeOptionsKey:SetSize( 290, 20 )
    ToolgunOptionsPanelChangeOptionsKey.DoClick = function ( btn )
    local ToolgunOptionsPanelChangeOptionsKeyOptions = DermaMenu()
    for i=1, #KeyListOptions do
        ToolgunOptionsPanelChangeOptionsKeyOptions:AddOption(KeyListOptions[i][1], function() Data[2] = i file.Write("toolgunmenu/data.txt", util.TableToJSON(Data)) end )
    end
    ToolgunOptionsPanelChangeOptionsKeyOptions:Open()
    end

    // Installed Tools View
    local ToolgunOptionsPanelInstalledTools = vgui.Create("DListView")
    ToolgunOptionsPanelInstalledTools:SetPos(50, 65)
    ToolgunOptionsPanelInstalledTools:SetParent(ToolgunOptionsPanel)
    ToolgunOptionsPanelInstalledTools:SetSize(300,600)
    ToolgunOptionsPanelInstalledTools:SetMultiSelect(false)
    ToolgunOptionsPanelInstalledTools:AddColumn("Tool Name")
    ToolgunOptionsPanelInstalledTools:AddColumn("Tool Command")
    ToolgunOptionsPanelInstalledTools.Paint = function()
        surface.SetDrawColor( 150, 150, 150, 200)
        surface.DrawRect( 0, 0, ToolgunOptionsPanelInstalledTools:GetWide(), ToolgunOptionsPanelInstalledTools:GetTall() )
    end
    
    // Installed Tools View (Add Lines)
    for i=1,InstalledToolNum do
        ToolgunOptionsPanelInstalledTools:AddLine(string.upper(ToolName[i]),ToolCommand[i])
    end
    
    // User Tools View
    local ToolgunOptionsPanelUserTools = vgui.Create("DListView")
    ToolgunOptionsPanelUserTools:SetPos(450, 65)
    ToolgunOptionsPanelUserTools:SetParent(ToolgunOptionsPanel)
    ToolgunOptionsPanelUserTools:SetSize(300,400)
    ToolgunOptionsPanelUserTools:SetMultiSelect(false)
    ToolgunOptionsPanelUserTools:AddColumn("Tool Name")
    ToolgunOptionsPanelUserTools:AddColumn("Tool Command")
    ToolgunOptionsPanelUserTools:SetSortable()
        ToolgunOptionsPanelUserTools.Paint = function()
        surface.SetDrawColor( 150, 150, 150, 200)
        surface.DrawRect( 0, 0, ToolgunOptionsPanelUserTools:GetWide(), ToolgunOptionsPanelUserTools:GetTall() )
    end
    
    // User Tools View (Add Lines)
    if MenuToolNum > 0 then
        for i=1,MenuToolNum do
            ToolgunOptionsPanelUserTools:AddLine(string.upper(UserToolName[i]),UserToolCommand[i])
        end
    end
    
    // User Tools View (Remove Line)
    ToolgunOptionsPanelUserTools.DoDoubleClick = function(parent, index, selected)
        ToolgunOptionsPanelUserTools:RemoveLine(index)
        local DeleteCount = DeleteCount+1
    end
    
    // Installed Tools View (Move Line)
    ToolgunOptionsPanelInstalledTools.DoDoubleClick = function(parent, index, selected)
        ToolgunOptionsPanelUserTools:AddLine(string.upper(selected:GetValue(1)),selected:GetValue(2))
    end
    
    // Save
    local ToolgunOptionsPanelButton = vgui.Create( "DButton", ToolgunOptionsPanel )
    ToolgunOptionsPanelButton:SetSize( 798, 30 )
    ToolgunOptionsPanelButton:SetPos( 1, 669 )
    ToolgunOptionsPanelButton:SetText( "Save" )
    ToolgunOptionsPanelButton.DoClick = function()
        UserToolName = {}
        UserToolCommand = {}
        
        for k, v in pairs(ToolgunOptionsPanelUserTools:GetLines()) do
            UserToolName[#UserToolName+1] = ToolgunOptionsPanelUserTools:GetLine(k):GetValue(1)
            UserToolCommand[#UserToolCommand+1] = ToolgunOptionsPanelUserTools:GetLine(k):GetValue(2)   
        end
            
        jsonTable[1] = UserToolName
        jsonTable[2] = UserToolCommand
        MenuToolNum = #UserToolName
        
        file.Write("toolgunmenu/tooldata.txt", util.TableToJSON(jsonTable))
        RunConsoleCommand("-toolgun_options_menu")
        end
end

function toolgunpanel()
    ToolgunPanel = vgui.Create("DFrame")
    ToolgunPanel:SetPos(0,0)
    ToolgunPanel:SetSize(ScrW(), ScrH())
    ToolgunPanel:ShowCloseButton(false)
    ToolgunPanel:SetDraggable(false)
    ToolgunPanel:SetTitle("")
    ToolgunPanel:MakePopup()
    ToolgunPanel.Paint = function()
        surface.SetDrawColor( 50, 50, 50, 150 )
        surface.DrawRect( 0, 0, ToolgunPanel:GetWide(), ToolgunPanel:GetTall() )
        
        surface.SetDrawColor( 200, 200, 200, 255 )
        surface.DrawLine(ScrW()/2,ScrH()/2,gui.MousePos())
        
        // Toolgun Sliders
        if MenuToolNum > 1 then
            for i = 1, MenuToolNum+1 do
                local x = ScrW()/2 + math.sin( math.rad( 360/MenuToolNum * i ) + math.rad( 360/(MenuToolNum)/2 ) ) * 100
                local y = ScrH()/2 - math.cos( math.rad( 360/MenuToolNum * i ) + math.rad( 360/(MenuToolNum)/2 ) ) * 100
                local x2 = ScrW()/2 + math.sin( math.rad( 360/MenuToolNum * i ) + math.rad( 360/(MenuToolNum)/2 ) ) * 300
                local y2 = ScrH()/2 - math.cos( math.rad( 360/MenuToolNum * i ) + math.rad( 360/(MenuToolNum)/2 ) ) * 300
                       
                local ang1 = (i-1)*(360/MenuToolNum) + (360/MenuToolNum/2)
                local ang2 = (i-0)*(360/MenuToolNum) + (360/MenuToolNum/2)
                local ang3 = 360 - (math.deg(math.atan2(gui.MouseX() - ScrW()/2, gui.MouseY() - ScrH()/2)) + 180)
                
                if ang3 < ang2 and ang3 > ang1 then
                    LocalPlayer():ConCommand(UserToolCommand[i])
                end
                
                if ang2 > 360 then
                    ang2 = ang2-360
                end
                
                if ang2 < ang1 then
                    if ang3 < ang2 then
                        LocalPlayer():ConCommand(UserToolCommand[i])
                    end
                end
                
                if ang3 < ang2 and ang3 > ang1 then
                    LocalPlayer():ConCommand(UserToolCommand[i])
                end
                
                surface.SetDrawColor( 255, 255, 255, 255)
                surface.DrawLine(x,y,x2,y2)
                
            end
        end
    end
    
    // Toolgun Buttons
    for i = 1, MenuToolNum do
        local Tool = vgui.Create("DButton", ToolgunPanel)
        
        local x = ScrW()/2 + math.sin( math.rad( 360/MenuToolNum * i ) ) * 250 - 50
        local y = ScrH()/2 - math.cos( math.rad( 360/MenuToolNum * i ) ) * 250 - 15

        Tool:SetSize( 100, 30 )
        Tool:SetPos( x,y )
        Tool:SetTextColor(Color(255,255,255,255))
        Tool:SetFont("ToolsTextFont")
        Tool:SetText( string.upper(UserToolName[i]) )
        Tool.DoClick = function()
            LocalPlayer():ConCommand(UserToolCommand[i] )
        end
        Tool.Paint = function()
                surface.SetDrawColor( 68, 87, 101, 0 )
        end
    end
    
end

function hookcheck()
    if KeyListMenu[tonumber(Data[1])][3] == "Mouse" then
        if(input.IsMouseDown(KeyListMenu[tonumber(Data[1])][2]) and !ToolgunPanel) then
            RunConsoleCommand("+toolgun_menu")
        end
        if(!input.IsMouseDown(KeyListMenu[tonumber(Data[1])][2]) and ToolgunPanel) then
            RunConsoleCommand("-toolgun_menu")
        end
    end
    if KeyListMenu[tonumber(Data[1])][3] == "Key" then
        if(input.IsKeyDown(KeyListMenu[tonumber(Data[1])][2]) and !ToolgunPanel) then
            RunConsoleCommand("+toolgun_menu")
        end
        if(!input.IsKeyDown(KeyListMenu[tonumber(Data[1])][2]) and ToolgunPanel) then
            RunConsoleCommand("-toolgun_menu")
        end
    end

    if KeyListOptions[tonumber(Data[2])][3] == "Mouse" then
        if(input.IsMouseDown(KeyListMenu[tonumber(Data[2])][2]) and !ToolgunOptionsPanel) then
            RunConsoleCommand("+toolgun_options_menu")
        end
    end
    if KeyListOptions[tonumber(Data[2])][3] == "Key" then
        if(input.IsKeyDown(KeyListMenu[tonumber(Data[2])][2]) and !ToolgunOptionsPanel) then
            RunConsoleCommand("+toolgun_options_menu")
        end
    end
end

hook.Add("HUDPaint", "Hookcheck", hookcheck)

// Console Command
concommand.Add("+toolgun_menu",toolgunpanel)
concommand.Add("+toolgun_options_menu",toolgunoptionspanel)
concommand.Add("-toolgun_menu",function() ToolgunPanel:Close() ToolgunPanel = nill end)
concommand.Add("-toolgun_options_menu",function() ToolgunOptionsPanel:Close() ToolgunOptionsPanel = nill end)
