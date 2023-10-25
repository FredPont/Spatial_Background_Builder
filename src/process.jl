include("graphe.jl")
include("processPlotImg.jl")

using  .Threads

# processTable use the CSV table to convert cluster columns to int and scatter plot columns xy to convert the coordinates to 
# pixel coordinates. A plot preview is computed in the plot directory
function processTable(filename::String, config::CONF)
    df = CSV.read("data/$filename", DataFrame)
    ColToInt(df::DataFrame, config::CONF)
    dataPlotScaleDF(df::DataFrame, config::CONF)
    job1 = Threads.@spawn CSV.write("results/$filename", df ; delim="\t")
    job2 = Threads.@spawn plotRescaleData(df::DataFrame, config::CONF, filename::String)
    job3 = Threads.@spawn processPlotImg(df::DataFrame, filename::String, config::CONF)
    fetch(job1)
    fetch(job2)
    fetch(job3)
end


# Transform cluster columns to integers
function ColToInt(df::DataFrame, config::CONF)
    for col in config.Cluster
        if checkColType(df::DataFrame, col::String) == String
            println("Cannot convert String column ", col, " to Integer")
            return
        elseif checkColType(df::DataFrame, col::String) == Float64
            FloatToInt(df::DataFrame, col::String)
        end
    end
end

# checkColType check DataFrame column type
function checkColType(df::DataFrame, colname::String)::Type
    # Variable column name
    col = Symbol(colname)
    column_data = df[!, col]

    # Get the type of the column
    column_type = eltype(column_data)

    #println("Type of column '$col': $column_type")
    return column_type
end

# change column float to integers
function FloatToInt(df::DataFrame, colname::String)
    # Variable column name
    col = Symbol(colname)
    colInt = Symbol("Int_" * colname)

    df.temp = Int64.(round.(df[!, col]))
    rename!(df, :temp => colInt)

    # Print the modified DataFrame
    #println(df[1:3, [1; 9; 11:end]])
end

