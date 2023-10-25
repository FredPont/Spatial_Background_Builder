###################
#   Graphes
###################

using VegaLite
#using FileIO

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

#  Graphe built a scatter plot of the Xcolname, Ycolname of the DataFrame df
function Graphe(df, fileName, Xcolname, Ycolname)
	filename = remExt(fileName)
	out = "plots/" * filename * "_" * Xcolname * "_" * Ycolname * ".png"
	Xcolname = Symbol(Xcolname)
	Ycolname = Symbol(Ycolname)
	df |>
	@vlplot(
		title = {text = "File =  $filename", anchor = "middle", fontSize = 30},
		mark = {
			:point,
			filled = true,
			#size = 100,
		},
		width = 1000,
		height = 1000,
		x = {Xcolname, axis = {labelFontSize = 15, titleFontSize = 20}},
		y = {
			Ycolname,
			axis = {labelFontSize = 20, titleFontSize = 20},
		}
	) |> save(out)
	# FileIO.save("plots/test.png")
	#save("plots/test.png")
end

