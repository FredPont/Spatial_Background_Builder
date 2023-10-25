using Images

# backgroundImg create a black and a white background image of size W x H
function backgroundImg(W::Int, H::Int)
    # Create a black image
    img = fill(Gray(0), H, W) # create a WxH array of Gray(0) pixels
    # Save the image as a PNG file
    save("background/black_image.png", img)
    # Create a white image
    img = fill(Gray(1), H, W) # create a WxH array of Gray(1) pixels
    # Save the image as a PNG file
    save("background/white_image.png", img)
end