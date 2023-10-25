

using JSON3

struct CONF
    OptimizeScatterPlot::Bool
    initialImgWidth::Int
    initialImgHeight::Int
    finalImgWidth::Int
    margin::Int
    Xcoor::Vector{String}
    Ycoor::Vector{String}
    IntegerConvert::Bool    # convert columns in the cluster categorie to the nearest integers
    Cluster::Vector{String}
end

function readConf()
    # Read the JSON file into a string
    json_string = read("conf.json", String)

    # Parse the JSON string into a Julia struct
    userConf = JSON3.read(json_string, CONF)

    return userConf
end


