# SPDX-FileCopyrightText: 2025 Alexander Wietek <awietek@pks.mpg.de>
#
# SPDX-License-Identifier: Apache-2.0

LinearAlgebra.norm(state::State)::Float64 = cxx_norm(state.cxx_state)
norm1(state::State)::Float64 = cxx_norm1(state.cxx_state)
norminf(state::State)::Float64 = cxx_norminf(state.cxx_state)

function LinearAlgebra.dot(v::State, w::State)
    if isreal(v) && isreal(w)
        return cxx_dot(v.cxx_state, w.cxx_state)
    else
        return cxx_dotC(v.cxx_state, w.cxx_state)
    end
end

function inner(ops::OpSum, v::State)
    if isreal(ops) && isreal(v)
        return cxx_inner(ops.cxx_opsum, v.cxx_state)
    else
        return cxx_innerC(ops.cxx_opsum, v.cxx_state)
    end
end


function inner(op::Op, v::State)
    if isreal(op) && isreal(v)
        return cxx_inner(op.cxx_op, v.cxx_state)
    else
        return cxx_innerC(op.cxx_op, v.cxx_state)
    end
end

# Vector space operations
Base.:+(v::State, w::State)::State = cxx_add(v.cxx_state, w.cxx_state)
Base.:-(v::State, w::State)::State = cxx_sub(v.cxx_state, w.cxx_state)
Base.:*(alpha::Float64, v::State)::State = cxx_scalar_mult(alpha, v.cxx_state)
Base.:*(alpha::ComplexF64, v::State)::State = cxx_scalar_mult(alpha, v.cxx_state)
Base.:*(v::State, alpha::Float64)::State = cxx_scalar_mult(alpha, v.cxx_state)
Base.:*(v::State, alpha::ComplexF64)::State = cxx_scalar_mult(alpha, v.cxx_state)
Base.:/(v::State, alpha::Float64)::State = cxx_scalar_div(v.cxx_state, alpha)
Base.:/(v::State, alpha::ComplexF64)::State = cxx_scalar_div(v.cxx_state, alpha)
