###################
#   Graphes
###################

using VegaLite
using FileIO

include("fileutil.jl")

# plotRescaleData plots the XY scatter plot columns converted to pixel coordinates.
# the plot is in the "plots" directory
function plotRescaleData(df::DataFrame, config::CONF, filename::String)
	for (i, Xcolname) in enumerate(config.Xcoor)
		Xcolname = "Rescale_" * Xcolname
		Ycolname = "Rescale_" * config.Ycoor[i]
		#println(Xcolname, typeof(Ycolname))
		Graphe(df, filename, Xcolname, Ycolname)
	end
end

# Graphe plots the XY scatter plot columns converted to pixel coordinates.
# the plot is in the "plots" directory
function Graphe(df, fileName, Xcolname, Ycolname)
    filename = remExt(fileName)
    out = "plots/" * filename * "_" * Xcolname * "_" * Ycolname * ".png"

    maxNBpoints = 5000 # max number of points to plot ; VegaLite have issues with too many points
    if size(df, 1) > maxNBpoints
        df = df[rand(1:size(df, 1), maxNBpoints), :]
    end
    
    
    # Convert column names to Symbols
    Xcolname = Symbol(Xcolname)
    Ycolname = Symbol(Ycolname)
    
    # Create the plot
    plot = df |>
        @vlplot(
            title = {text = "File = $filename", anchor = "middle", fontSize = 30},
            mark = {
                :point,
                filled = true,
            },
            width = 1000,
            height = 1000,
            x = {field = Xcolname, axis = {labelFontSize = 15, titleFontSize = 20}},
            y = {field = Ycolname, axis = {labelFontSize = 20, titleFontSize = 20}}
        )
    
    # Save the plot as a PNG file
    save(out, plot)
end

