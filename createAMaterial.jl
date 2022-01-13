module createAMaterial

include("materialDatabase.jl")

export createMaterial

function createMaterial(materialName::String, materialGamma=nothing, materialPinf=nothing, materialCp=nothing, materialDatabase=materialDatabase)
    
    name = materialName
    gamma = materialGamma
    pinf = materialPinf
    cp = materialCp
    
    if ( !(materialName in getNames(materialDatabase)) && (materialGamma==nothing || materialPinf==nothing || materialCp==nothing) )
        throw(DomainError(name, "material not in database: you need to specify gamma and pinf in main()"))
    elseif (!(materialName in getNames(materialDatabase) )   )
        println("custom material named <<", name, ">>, with gamma = ", gamma, ", pinf = ", pinf, ", and cp = ", cp)
    elseif ( materialName in getNames(materialDatabase) )
        if(materialGamma==nothing && materialPinf==nothing && materialCp==nothing)
            if ( materialName=="default" )
                default = getMaterialNamed("default")
                gamma = getGamma(default)
                pinf = getPinf(default)
                cp = getCp(default)
                println( "default material with gamma = ", gamma, ", pinf = ", pinf, " , and cp = ", cp)
            else
                material = getMaterialNamed(materialName)
                println("selected material <<", getName(material), ">> found in materialDatabase. Its properties are")
                name = getName(material)
                println("gamma = ", getGamma(material))
                gamma = getGamma(material)
                println("pinf = ", getPinf(material))
                pinf = getPinf(material)
                println("cp = ", getCp(material))
                cp = getCp(material)
            end
        else
            material = getMaterialNamed(materialName)
            if(gamma==nothing)
                gamma= getGamma(material)
            end
            if(pinf==nothing)
                pinf= getPinf(material)
            end
            if(cp==nothing)
                cp= getCp(material)
            end
            println("WARNING: using <<", materialName, ">> with new properties:")
            println("gamma = ", gamma)
            println("pinf = ", pinf)
        end  # second elseif
        
    end  # if
    
    the_used_material = (name, gamma, pinf, cp)    
    
    return the_used_material
end  # function


end   # module
