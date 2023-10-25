using Pkg

# install packages automatically
function pkgAdd(list::Array{String,1})
    for p in list
        if !haskey(Pkg.project().dependencies, p)
            Pkg.add(p)
        end
    end
end

pk = ["CSV", "DataFrames", "JSON3", "VegaLite", "Images"]
pkgAdd(pk)

println("Precompilation...")

using CSV, DataFrames, JSON3, VegaLite, Images
