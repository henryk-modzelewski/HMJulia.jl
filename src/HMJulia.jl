module HMJulia
    using IJulia

    export mynotebook
    notebooks = joinpath(ENV["HOME"],"Projects/Julia/Notebooks")
    function mynotebook()
        notebook(dir=joinpath(ENV["HOME"],notebooks))
    end
    function mynotebook(subdir::String)
        newpath = joinpath(notebooks,subdir)
        isdir(newpath) || mkdir(newpath)
        notebook(dir=newpath)
    end

end # module
