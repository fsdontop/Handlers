local Handler = {}

Handler["Commands"] = {}

Handler.AddCommand = function(CommandName, Description, MainFunction, Arguments)
    if Arguments then
        table.insert(Handler.Commands, {CommandName, Description, MainFunction, Arguments})
    else
        table.insert(Handler.Commands, {CommandName, Description, MainFunction})
    end
end

Handler.CheckCommand = function(CommandName, IsChatted)
    CommandName = string.lower(CommandName)

    if IsChatted and string.sub(CommandName, 1, 1) ~= Handler.Prefix then
        return
    end

    local SplittedCN = string.split(CommandName, " ")
    local Arguments = string.split(CommandName, " ")

    table.remove(Arguments, 1)

    if string.sub(CommandName, 1, 1) == Handler.Prefix then
        CommandName = string.sub(SplittedCN[1], 2)
    end

    for _, Command in ipairs(Handler.Commands) do
        local Aliases = string.split(Command[1], "/")

        for _, Alias in ipairs(Aliases) do
            if CommandName == Alias then
                if Command[4] then
                    Command[3](unpack(Arguments))
                else
                    Command[3]()
                end
            end
        end
    end
end

Handler.InitializeChattedConnection = function()
    game:GetService("Players").LocalPlayer.Chatted:Connect(function(Message)
        Handler.CommandCheck(Message, true)
    end)
end

Handler.SetPrefix = function(Prefix)
    Handler["Prefix"] = Prefix
end

return Handler