using Test
include("src/readconf.jl")
include("src/scalingFactor.jl")

function unitTests()
    @testset "Scaling factor Img" begin
        @test ScalingFactorImg(4000, 2000, margin=0) == 0.5
        @test ScalingFactorImg(47000, 4700, margin=0) == 0.1
        @test ScalingFactorImg(4000, 2000, margin=10) == 0.495
    end

    @testset "Scaling factor" begin
        @test ScalingFactor(2000, xmin=-10, xmax=10, margin=0) == 100
        @test ScalingFactor(2000, xmin=-10, xmax=10, margin=10) == 99
    end

    @testset "Transform coordinates" begin
        @test CoordTranform(x=0.0, xmin=0.0, sf=0.1, margin=0) == 0
        @test CoordTranform(x=40000.0, xmin=0.0, sf=0.1, margin=0) == 4000
        @test CoordTranform(x=0.0, xmin=0.0, sf=0.1, margin=10) == 10
        @test CoordTranform(x=0.0, xmin=-20000.0, sf=0.1, margin=0) == 2000
        @test CoordTranform(x=0.0, xmin=-2000.0, sf=0.495, margin=10) == 1000
        @test CoordTranform(x=-10.0, xmin=-10.0, sf=100, margin=10) == 10.0
        @test CoordTranform(x=10.0, xmin=-10.0, sf=99, margin=10) == 1990.0
        @test CoordTranform(x=8.0, xmin=-10.0, sf=100, margin=0) == 1800.0
        @test CoordTranform(x=8.0, xmin=-10.0, sf=99, margin=10) == 1792.0
    end

    # @testset "Final image size" begin
    #     @test FinalImgHeight(;finalImgWidth=1000, xmin=-10, xmax=10, ymin=-10, ymax=10) == 1000
    #     @test FinalImgHeight(;finalImgWidth=1000, xmin=-10, xmax=10, ymin=-20, ymax=10) == 1500
    # end
end

unitTests()