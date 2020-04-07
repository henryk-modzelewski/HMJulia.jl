module HMJulia

using Pkg
using IJulia
using InteractiveUtils

############################################################
## notebooks ###############################################
export hm_update_Julia
function hm_update_Julia()

    println("registry update ...")
    Pkg.Registry.update()
    println("... done")

    println("1st resolve ...")
    try
        Pkg.resolve()
    catch
        @warn "First resolve failed"
    end
    println("... done")

    println("1st update ...")
    Pkg.update()
    println("... done")

    println("2nd resolve ...")
    Pkg.resolve()
    println("... done")

    println("2nd update ...")
    Pkg.update()
    println("... done")

    println("gc ...")
    Pkg.gc()
    println("... done")
end

############################################################
## notebooks ###############################################
export notebooks_hm
notebooks_hm = joinpath(ENV["HOME"],"Projects/Julia/Notebooks")
notebooks_HM() = notebook(dir=joinpath(notebooks))
function notebooks_HM(subdir::String)
    newpath = joinpath(notebooks,subdir)
    isdir(newpath) || mkdir(newpath)
    notebook(dir=newpath)
end
export notebooks_softmeet
notebooks_sm = joinpath(ENV["HOME"],"Projects/Julia/SLIM/Software-meeting/Julia-tutorials")
notebooks_softmeet() = notebook(dir=notebooks_sm)

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
