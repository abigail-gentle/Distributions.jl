"""
    sample_bounded_neg_exp_bernoulli(rng::AbstractRNG, x::Rational)

Efficiently samples from a Bernoulli(exp(-x)) distribution
assumes x is a rational number in [0,1]
"""
function sample_bounded_neg_exp_bernoulli(rng::AbstractRNG, x::Rational)
    @assert 0 <= x <= 1
    k = 1
    while true
        if rand(rng, Bernoulli(x//k)) == 1
            k += 1
        else
            break
        end
    end
    return k % 2
end

"""
    sample_neg_exp_bernoulli(rng::AbstractRNG, x::Rational)

Efficiently samples from a Bernoulli(exp(-x)) distribution
assumes x is a rational number >= 0
"""
function sample_neg_exp_bernoulli(rng::AbstractRNG, x::Rational)
    while x > 1
        if sample_bounded_neg_exp_bernoulli(rng, 1//1) == 1
            x -= 1
        else
            return 0
        end
    end
    return sample_bounded_neg_exp_bernoulli(rng, x)
end
"""
    sample_neg_exp_geometric(rng::AbstractRNG, x::Rational)

Efficiently samples from a Geometric(1-exp(-x)) distribution
"""
function sample_neg_exp_geometric(rng::AbstractRNG, x::Rational)
    if x == 0
        return 0
    end
    @assert x > 0

    t = denominator(x)
    while true
        u = rand(rng,0:t)
        b = sample_neg_exp_bernoulli(rng, u//t)
        if b == 1
            break
        end
    end
    v = rand(rng, Geometric(1.0))
    value = v*t + u
    return value // x.numerator
end