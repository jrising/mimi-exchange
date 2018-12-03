using YAML

function templatereplace(template, fillins)
    for (key, value) in fillins
        template = replace(template, "\${" * key * "}", value)
    end

    template
end

infos = YAML.load_file("example.yml")
template = open("template.html") do file
    read(file, String)
end

itemstrs = String[]
for info in infos
    fillins = Dict{String, String}("name" => info["name"], "namespace" => info["namespace"])
    if "description" in keys(info)
        fillins["description"] = info["description"]
    else
        fillins["description"] = "No description."
    end
    push!(itemstrs, templatereplace(template, fillins))
end

println(join(itemstrs, ""))
