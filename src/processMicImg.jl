
include("backgroundImg.jl")

# processMicImg compute the scaling factor, produce a background image based on the microscopy image
# and convert cluster columns to integers
function processMicImg(filename::String, config::CONF)
    ScalingFactorImg(config.initialImgWidth, config.finalImgWidth, margin=config.margin)
    BuildImg(config::CONF)
    df = CSV.read("data/$filename", DataFrame)
    ColToInt(df::DataFrame, config::CONF)
    CSV.write("results/$filename", df; delim="\t")
end

function BuildImg(config::CONF)
    imgWidth = config.finalImgWidth
    imgHeight = round(Int, (imgWidth / config.initialImgWidth) * config.initialImgHeight)
    printstyled("final image size : ", imgWidth, " x ", imgHeight; color=:yellow)
    println()
    backgroundImg(imgWidth::Int, imgHeight::Int)
end