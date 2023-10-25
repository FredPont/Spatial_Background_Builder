
include("backgroundImg.jl")

# processPlotImg computes the maximum xy value of the rezized column to  produce a square background image
function processPlotImg(df::DataFrame, filename::String, config::CONF)
    maxPixel = 0
    for col in names(df)
        if startswith(col, r"Rescale_")
            colmax = maximum(df[!, col])
            if colmax > maxPixel
                maxPixel = colmax
            end
        end
    end
    imgSize = maxPixel + 2 * config.margin
    backgroundImg(imgSize::Int, imgSize::Int)
end

