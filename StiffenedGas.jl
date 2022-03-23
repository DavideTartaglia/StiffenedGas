module StiffenedGas

export main

include("createAMaterial.jl")

import .createAMaterial as cr
using .cr

include("materialDatabase.jl")

include("initializeVariables.jl")

function calculateDesiredQuantity!( p, T, rho, desiredQuantity, material)
    
    gamma = getGamma(material)
    pinf = getPinf(material)
    cp = getCp(material)
    
    R = ((gamma - 1.)/gamma)*cp   # specific gas constant (i.e., per unit mass)
    
    if(desiredQuantity=="temperature")
        T = (p + pinf)/rho/R
    end
    
    if(desiredQuantity=="pressure")
        p = rho*(gamma-1)*cp*T/gamma - pinf
    end
    
    if(desiredQuantity=="density")
        rho = (p + pinf)/T/R
    end
    
    e = cp*T/gamma + pinf/rho     # internal energy
    
    return p, T, rho, e
end

function main(desiredQuantity::String, givenQuantity1, givenQuantity2, materialName="default", gamma=nothing, pinf=nothing, cp=nothing, materialDatabase=materialDatabase)
    
    # cast to Float64:
    givenQuantity1 = Float64(givenQuantity1)
    givenQuantity2 = Float64(givenQuantity2)
    
    # convert to lower case desiredQuantity
    desiredQuantity = lowercase(desiredQuantity)
    
    # convert to lower case materialName
    materialName = lowercase(materialName)
    
    # perform a few validity checks and initialize material
    checkUnknown(desiredQuantity)
    println()
    material = cr.createMaterial(materialName, gamma, pinf, cp)
    
    # initialize pressure, temperature and density
    (p, T, rho) = initializeVariables_p_T_rho(givenQuantity1, givenQuantity2, desiredQuantity)
    
    # run the calculation of the desired quantity
    (p, T, rho, e) = calculateDesiredQuantity!(p, T, rho, desiredQuantity, material)
    
    # output
    println()
    println("output: ")
    println("p = ", p)
    println("T = ", T)
    println("rho = ", rho)
    println("e = ", e)
    println()
    println("ending main")


    if(desiredQuantity=="pressure")
        return p
    end
    if(desiredQuantity=="temperature")
        return T
    end
    if(desiredQuantity=="density")
        return rho
    end
                
end # main

end # module

# main parameters:

# desiredQuantity -> givenQuantity1, givenQuantity2, materialName(optional), gamma(optional), pinf(optional), cp (opt)
#       p         ->        T      ,      rho
#       T         ->        p      ,      rho
#       rho       ->        T      ,      p

# example: main("temperature", 1.01325e5, 1117, "liquidwater", 2.35, 10e9, 4267)
