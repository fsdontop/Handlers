local Handler = {}

Handler["Commands"] = {}

Handler.AddCommand = function(CommandName, Description, MainFunction, Arguments)
    if Arguments then
        table.insert(Handler.Commands, {CommandName, Description, MainFunction, Arguments})
    else
        table.insert(Handler.Commands, {CommandName, Description, MainFunction})
    end
end

Handler.CheckCommand = function(CommandName)
    CommandName = string.lower(CommandName)

    local SplittedCN = string.split(CommandName, " ")
    local Arguments = string.split(CommandName, " ")

    table.remove(Arguments, 1)

    if string.sub(CommandName, 1, 1) == Handler.Prefix then
        CommandName = string.sub(SplittedCN[1], 2)
    end
    
    print(unpack(Arguments))

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

Handler.SetPrefix = function(Prefix)
    Handler["Prefix"] = Prefix
end

return Handler
