function checkUnknown(desiredQuantity::String)
        listofvariables = ["pressure", "density", "temperature"]
    if ( !(desiredQuantity in listofvariables))
        throw(DomainError(desiredQuantity, "desiredQuantity must be either density, pressure or temperature"))
    else
        println("desired quantity: " , desiredQuantity)
    end
    return nothing
end

function initializeRho_given_desiredQuantity!(givenQuantity2::Float64, desiredQuantity)
    list = ["pressure", "temperature"]
    if( desiredQuantity in list)
        return givenQuantity2
    elseif( desiredQuantity=="density")
        return nothing # will be calculated later
    else
        throw(DomainError(desiredQuantity, "unexpected desiredQuantity in initializeRho_given_desiredQuantity!"))
    end
end

function initializeT_given_desiredQuantity!(givenQuantity1::Float64, desiredQuantity)
    list = ["pressure", "density"]
    if( desiredQuantity in list)
        return givenQuantity1
    elseif( desiredQuantity=="temperature")
        return nothing # will be calculated later
    else
        throw(DomainError(desiredQuantity, "unexpected desiredQuantity in initializeT_given_desiredQuantity!"))
    end
end

function initializeP_given_desiredQuantity!(givenQuantity1::Float64, desiredQuantity)
    list = ["temperature", "density"]
    if( desiredQuantity in list)
        return givenQuantity1
    elseif( desiredQuantity=="pressure")
        return nothing # will be calculated later
    else
        throw(DomainError(desiredQuantity, "unexpected desiredQuantity in initializeP_given_desiredQuantity!"))
    end
end

function initializeVariables_p_T_rho(givenQuantity1=givenQuantity1, givenQuantity2=givenQuantity2, desiredQuantity=desiredQuantity)
    # desiredQuantity -> givenQuantity1, givenQuantity2
    #       p         ->        T      ,      rho
    #       T         ->        p      ,      rho
    #       rho       ->        T      ,      p
    
    rho = initializeRho_given_desiredQuantity!(givenQuantity2,desiredQuantity);
    T = initializeT_given_desiredQuantity!(givenQuantity1, desiredQuantity);
    p = initializeP_given_desiredQuantity!(givenQuantity1 ,desiredQuantity);
    if(desiredQuantity=="density")
        p = initializeP_given_desiredQuantity!(givenQuantity2 ,desiredQuantity);
    end
    
    return p, T, rho
end
