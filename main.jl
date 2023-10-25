# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

# Written by Frederic PONT.
# (c) Frederic Pont 2023



include("src/installPkg.jl")
include("src/readconf.jl")
include("src/scalingFactor.jl")
include("src/process.jl")
include("src/processMicImg.jl")

function title()
    println("   ┌────────────────────────────────────────────┐") # unicode U+250C
    println("   │  Spatial background (c)Frederic PONT 2023  │")
    println("   │  Free Software GNU General Public License  │")
    println("   └────────────────────────────────────────────┘")
end

function main()
    userConf = readConf()
    #println(userConf)
    tables = readdir("data/")
    #println(tables)
    title()

    t1 = time()

    
    for filename in tables
        if userConf.OptimizeScatterPlot
            processTable(filename::String, userConf::CONF)
        else
            processMicImg(filename::String, userConf::CONF)
        end
    end

    t2 = time()
    println("Total elapsed time : ", t2 - t1, " sec !")
end

main()