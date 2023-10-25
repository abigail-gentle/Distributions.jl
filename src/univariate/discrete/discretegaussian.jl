struct DiscreteGaussian{T<:Rational} <: DiscreteUnivariateDistribution
    σ::T
    μ::T
    function DiscreteGaussian{T}(σ::T, μ::T) where {T <: Real}
        new{T}(σ, μ)
    end
end

DiscreteGaussian() = DiscreteGaussian(1//2, 0)

function rand(rng::AbstractRNG, d::DiscreteGaussian)
    σ = d.σ
    ss = σ^2
    μ = d.μ
    t = floor(Int, σ) + 1
    while true
        Y = rand(rng, DiscreteLaplace(t))
        C = rand(rng, NegExpBernoulli((abs(Y)-ss//t)^2 // 2*ss))
        if C == 1
            return Y
        end
    end
end
