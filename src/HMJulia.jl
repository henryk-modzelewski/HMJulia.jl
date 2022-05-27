module HMJulia

using Pkg
using IJulia
using InteractiveUtils
using Random

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
notebook_dir_hm = joinpath(ENV["HOME"],"Projects/Julia/Notebooks")
notebook_dir_sm = joinpath(ENV["HOME"],"Projects/Julia/SLIM/Software-meeting/Julia-tutorials")

export notebooks_HM
notebooks_HM() = notebook(dir=joinpath(notebook_dir_hm))
function notebooks_HM(subdir::String...)
    newpath = joinpath(notebook_dir_hm,subdir...)
    isdir(newpath) || mkpath(newpath)
    @async notebook(dir=newpath)
end

export notebooks_here
notebooks_here() = @async notebook(dir=pwd())

export notebooks_softmeet
notebooks_softmeet() = @async notebook(dir=notebook_dir_sm)

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


export hm_time_diff
"""
    hm_time_diff(hs,ms,he,me)
    hm_time_diff("hs:ms,he:me")
"""
function hm_time_diff(hs::Integer,ms::Integer,he::Integer,me::Integer)
    te = he*60+me
    ts = hs*60+ms
    tm = te-ts
    ts = tm*60
    tr = ts+rand(-29:30)
    return tm,ts,tr
end
function hm_time_diff(in::String)
    dummy = split(in,',')
    ts = split(dummy[1],':')
    te = split(dummy[2],':')
    hs = parse(Int,ts[1])
    ms = parse(Int,ts[2])
    he = parse(Int,te[1])
    me = parse(Int,te[2])
    return hm_time_diff(hs,ms,he,me)
end

end # module
