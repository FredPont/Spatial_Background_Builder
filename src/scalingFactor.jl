# dataPlotScaleDF rescale the XY columns indicated in the conf.json file to fit the final image size and the margin
function dataPlotScaleDF(df::DataFrame, config::CONF)
    for colname in vcat(config.Xcoor, config.Ycoor)
        col = Symbol(colname)
        colRescale = Symbol("Rescale_" * colname)
        scalingFac = ScalingFactor(config.finalImgWidth; xmin=minimum(df[!, col]), xmax=maximum(df[!, col]), margin=config.margin)
        df.temp = map(v -> CoordTranform(x=v, xmin=minimum(df[!, col]), sf=scalingFac, margin=config.margin), df[!, col])
        rename!(df, :temp => colRescale)
    end
    # Print the modified DataFrame
    #println(df[1:3, [1; 12:end]])
end

# CoordTranform compute the new coordinates of x in the background image
function CoordTranform(; x=0.0, xmin=0, sf=1.0, margin=0)
    xshift = margin + sf * (x - xmin)
    return round(Int, xshift)
end

# ScalingFactor to convert scatter plot coordinates to pixel coordinates
# Lf final size of the image
function ScalingFactor(Lf; xmin=0, xmax=1000, margin=0)
    if Lf == 0
        println("The size of the final image must be > 0 !")
        return 0
    else
        return (Lf - 2 * margin) / (xmax - xmin)
    end
end

# scaling factor based on the initial/final image width of the microscopy image
function ScalingFactorImg(Li, Lf; margin=0)
    if Lf == 0
        println("The size of the final image must be > 0 !")
        return 0
    else
        sfImg = (Lf - 2 * margin) / Li
        printstyled("scaling factor : ", sfImg ; color=:blue)
        println()
        return sfImg
    end
end

# FinalImgHeight of the scatter plot background image
# function FinalImgHeight(; finalImgWidth=1000, xmin=-10, xmax=10, ymin=-10, ymax=10)
#     if xmax != xmin
#         imgRatio = (ymax - ymin) / (xmax - xmin)
#         return finalImgWidth * imgRatio
#     else
#         println("Cannot calculate image size, xmin=xmax")
#         return 0
#     end
# end