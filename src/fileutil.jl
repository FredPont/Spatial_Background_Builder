

# remExt remove file extension
function remExt(filename::String)
    filename, extension = splitext(filename)
    return filename
end

