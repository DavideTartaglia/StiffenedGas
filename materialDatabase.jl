# materialDatabase

function liquidWater()
    name = "liquidwater"
    gamma = 2.8
    pinf = 8.5e8
    cp = 4186.
    return name, gamma, pinf, cp
end

function air()
    name = "air"
    gamma = 1.4
    pinf = 0.0
    cp = 1005.
    return name, gamma, pinf, cp
end

function default()
    name = "default"
    gamma = 1.4
    pinf = 0.0
    cp = gamma/(gamma-1.)*8.314462618
    return name, gamma, pinf, cp
end

# interface of the database:

    # get name of a material
    function getName( a_material )
        return a_material[1]
    end

    # get gamma of a material
    function getGamma( a_material )
        return a_material[2]
    end

    # get pinf of a material
    function getPinf( a_material )
        return a_material[3]
    end

    # get cp of a material
    function getCp( a_material )
        return a_material[4]
    end

    function materialDatabase()
        return liquidWater(), air(), default()
    end

    function getNames(materialDatabase=materialDatabase)
        return collect( getName(material) for material in materialDatabase() )
    end

    function getGammas(materialDatabase=materialDatabase)
        return collect( getGamma(material) for material in materialDatabase() )
    end

    function getPinfs(materialDatabase=materialDatabase)
        return collect( getPinf(material) for material in materialDatabase() )
    end

    function getCps(materialDatabase=materialDatabase)
        return collect( getCps(material) for material in materialDatabase() )
    end

    function getMaterialNamed(a_name::String)
        if ( eltype(materialDatabase()[ findall(x->x==a_name, getNames()) ])==Union{})
            throw(DomainError(a_name, "material not in database"))
        end
        return materialDatabase()[ findall(x->x==a_name, getNames() )[1] ]
    end
