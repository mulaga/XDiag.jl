# SPDX-FileCopyrightText: 2025 Alexander Wietek <awietek@pks.mpg.de>
#
# SPDX-License-Identifier: Apache-2.0

function to_armadillo(mat::Matrix{Float64}; copy=true)
    m, n = size(mat)
    memptr = Base.unsafe_convert(Ptr{Float64}, mat)
    return cxx_arma_mat(memptr, m, n, copy, true)
end


function to_armadillo(mat::Matrix{ComplexF64}; copy=true)
    m, n = size(mat)
    memptr = Base.unsafe_convert(Ptr{ComplexF64}, mat)
    return cxx_arma_cx_mat(memptr, m, n, copy, true)
end

function to_armadillo(vec::Vector{Float64}; copy=true)
    m = size(vec)[1]
    memptr = Base.unsafe_convert(Ptr{Float64}, vec)
    return cxx_arma_vec(memptr, m, copy, true)
end


function to_armadillo(vec::Vector{ComplexF64}; copy=true)
    m = size(vec)[1]
    memptr = Base.unsafe_convert(Ptr{ComplexF64}, vec)
    return cxx_arma_cx_vec(memptr, m, copy, true)
end


function to_julia(vec::cxx_arma_vec)
    m = n_rows(vec)
    julia_vec = Vector{Float64}(undef, m)

    # Low level C call to copy
    vec_ptr = memptr(vec).cpp_object
    julia_vec_ptr = Base.unsafe_convert(Ptr{Float64}, julia_vec)
    Base.unsafe_copyto!(julia_vec_ptr, vec_ptr, m)
    return julia_vec
end

function to_julia(vec::cxx_arma_cx_vec)
    m = n_rows(vec)
    julia_vec = Vector{ComplexF64}(undef, m)

    # Low level C call to copy
    vec_ptr = memptr(vec).cpp_object
    julia_vec_ptr = Base.unsafe_convert(Ptr{ComplexF64}, julia_vec)
    Base.unsafe_copyto!(julia_vec_ptr, vec_ptr, m)
    return julia_vec
end

function to_julia(mat::cxx_arma_mat)
    m = n_rows(mat)
    n = n_cols(mat)
    N = n_elem(mat)
    julia_mat = Matrix{Float64}(undef, m, n)

    # Low level C call to copy
    mat_ptr = memptr(mat).cpp_object
    julia_mat_ptr = Base.unsafe_convert(Ptr{Float64}, julia_mat)
    Base.unsafe_copyto!(julia_mat_ptr, mat_ptr, N)
    return julia_mat
end

function to_julia(mat::cxx_arma_cx_mat)
    m = n_rows(mat)
    n = n_cols(mat)
    N = n_elem(mat)
    julia_mat = Matrix{ComplexF64}(undef, m, n)

    # Low level C call to copy
    mat_ptr = memptr(mat).cpp_object
    julia_mat_ptr = Base.unsafe_convert(Ptr{ComplexF64}, julia_mat)
    Base.unsafe_copyto!(julia_mat_ptr, mat_ptr, N)
    return julia_mat
end
