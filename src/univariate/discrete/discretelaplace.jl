"""
    DiscreteLaplace(s, t)

A *Discrete Laplace Distribution* given s and t

"""
struct DiscreteLaplace{T<:Rational} <: DiscreteUnivariateDistribution
    θ::Rational
    DiscreteLaplace{T}(θ) where {T <: Rational} = new{T}(θ)
end

function DiscreteLaplace{T}(θ::Rational; check_args::Bool=true)
    @check_args DiscreteLaplace (θ, θ >= 0)
    return DiscreteLaplace(θ)
end

DiscreteLaplace(θ::Float64; tol::Real=eps(θ), check_args::Bool=true) = DiscreteLaplace(rationalize(θ, tol); check_args=check_args)
DiscreteLaplace(s::Integer, t::Integer; check_args::Bool=true) = DiscreteLaplace(t // s)

const DiscreteBiexponential = DiscreteLaplace


### Parameters

scale(d::DiscreteLaplace) = d.θ
params(d::DiscreteLaplace) = (d.θ)


### Sampling
function rand(rng::AbstractRNG, d::DiscreteLaplace)
    
end
