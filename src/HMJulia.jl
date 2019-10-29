module HMJulia

using IJulia
using InteractiveUtils

############################################################
## notebooks ###############################################
export hm_notebook
notebooks = joinpath(ENV["HOME"],"Projects/Julia/Notebooks")
function hm_mynotebook()
    notebook(dir=joinpath(ENV["HOME"],notebooks))
end
function hm_notebook(subdir::String)
    newpath = joinpath(notebooks,subdir)
    isdir(newpath) || mkdir(newpath)
    notebook(dir=newpath)
end

############################################################
## type tree ###############################################
export hm_type_tree
function hm_type_tree(top::Type=Number;bl::String="* ",in::String="  ",super::Bool=true)
    super ? println(bl,top," <: ",supertype(top)) : println(bl,top)
    ts = subtypes(top)
    if length(ts) > 0
        for t in ts
            T=Base.unwrap_unionall(t)
            hm_type_tree(T;bl=in*bl,in=in,super=false)
        end
    end
end

end # module
